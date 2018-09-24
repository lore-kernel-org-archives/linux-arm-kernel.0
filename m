From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 24 Sep 2018 18:26:23 +0000
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <CAOesGMgqjGEXzRPXFxUcSyTof_wgjErPhZ7wokdGEDY9SnCvdw@mail.gmail.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMhViv_D6GKYf3x02LGqthwEsfkUFWBdG7pCQqD2MGsEew@mail.gmail.com>
 <CY1PR02MB2138254CC5B1C2B2D41AB725B8040@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMgqjGEXzRPXFxUcSyTof_wgjErPhZ7wokdGEDY9SnCvdw@mail.gmail.com>
Message-ID: <CY1PR02MB213831731FA01F46D2713875B8170@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

> -----Original Message-----
> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Sunday, September 23, 2018 6:11 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; ard.biesheuvel at linaro.org; Ingo
> Molnar <mingo@kernel.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; Kees Cook <keescook@chromium.org>; Dmitry
> Torokhov <dmitry.torokhov@gmail.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>; Michal
> Simek <michals@xilinx.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; linux-clk <linux-clk@vger.kernel.org>; Rajan Vaja
> <RAJANV@xilinx.com>; Linux ARM Mailing List <linux-arm-
> kernel at lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>; DTML <devicetree@vger.kernel.org>
> Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
> device control
> 
> Hi,
> 
> Apologies for the slow responses here, I meant to follow up on this sooner.
> 
> On Tue, Sep 11, 2018 at 8:20 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> > Hi Sudeep and Olof,
> >
> > Clock driver from same patch set uses ioctl API along with other clock eemi
> APIs. As clock patches' final review is pending by Stephen, Michal only created
> pull request for rest of the patches and that doesn't require ioctl api. I will
> remove it and submit new patch set.
> >
> > For future patches which requires ioctl api, would like to understand your
> suggestion so I can make required changes. For zynqmp, EEMI interface allows
> clock, reset, power etc management through firmware but apart from those
> there are some operations which needs secure access through firmware.
> Examples are accessing some storage registers for inter agent communication,
> configuring another agent(RPU) mode, setting PLL parameters, boot device
> configuration etc. Those operations are covered as ioctls as they are very
> platform specific. Do you suggest to handle them with individual EEMI APIs
> instead of ioctl API?
> 
> I'm personally less worried about whether the calls are through an ioctl API or an
> EEMI one, but if it is through ioctl, I'd prefer if it wasn't wide-open pass-through.
> I.e. that the ioctls you actually use are documented, and only those who are
> whitelisted are passed through (and not in general exported to userspace).
> 
> Does that make sense?
> 

Sounds perfect. I will make required changes in next incremental patchset.

Thanks,
Jolly Shah


> 
> -Olof
