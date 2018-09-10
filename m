From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 10 Sep 2018 19:17:45 +0000
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
Message-ID: <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Adding more clarification on top of what Michal said:
Here ioctl is not a system ioctl and just a eemi API like other interface APIs. It cannot be called from userspace. Only Linux drivers can use this API for defined ioctl operations. This API is meant for any platform specific operations which needs to be managed by firmware. Firmware will always validate the request for action being performed.
Debugfs interface is just for debugging during development. We can remove debugfs support for ioctl API if you suggest.

Thanks,
Jolly Shah


> -----Original Message-----
> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Saturday, September 08, 2018 6:19 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; Ingo Molnar <mingo@kernel.org>; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; matt at codeblueprint.co.uk; Sudeep
> Holla <sudeep.holla@arm.com>; hkallweit1 at gmail.com; Kees Cook
> <keescook@chromium.org>; Dmitry Torokhov <dmitry.torokhov@gmail.com>;
> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@codeaurora.org>; Michal Simek <michals@xilinx.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-clk
> <linux-clk@vger.kernel.org>; Rajan Vaja <RAJANV@xilinx.com>; Linux ARM
> Mailing List <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; DTML <devicetree@vger.kernel.org>; Jolly
> Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
> device control
> 
> Hi,
> 
> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> > From: Rajan Vaja <rajanv@xilinx.com>
> >
> > Add ZynqMP firmware IOCTL API to control and configure devices like
> > PLLs, SD, Gem, etc.
> >
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> 
> This patch worries me somewhat. It's a transparent pass-through ioctl driver. Is
> there a spec available for what the implemented IOCTLs are?
> 
> Should some of them be proper drivers instead of an opaque pass-through like
> this? Could some of them have stability impact on the platform such that there
> are security concerns and the list of arguments should somehow be sanitized?
> 
> What's the intended usecase anyway? Just a debug tool during development, or
> something that you expect heavy use of by some userspace middleware?
> 
> 
> -Olof
