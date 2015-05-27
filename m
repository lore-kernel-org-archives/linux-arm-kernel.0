From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 27 May 2015 09:30:48 -0500
Subject: [PATCH v2 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <20150527115418.GG16165@dragon>
References: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
 <20150525081928.GK3264@dragon>
 <CAHrpEqS1ESjTdAq-ncm597kAt3D6GbmTSAtNchu-aTwFatKpdg@mail.gmail.com>
 <20150527115418.GG16165@dragon>
Message-ID: <CAHrpEqSg1KLVDZ9OeM5Y_sapDDPFQ5yf68c6HE1Bd7EFbFR1aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 6:54 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, May 26, 2015 at 10:01:00AM -0500, Zhi Li wrote:
>> what's name do you prefer?
>
> If we have to create a new driver, I prefer to name it after imx7.
>
>> Totally difference.
>>
>> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/mach-imx/gpcv2.c?h=imx_3.14.28_7d_alpha&id=a34e259cc0a4e86ccb993c947991d2823d81eb14
>>
>> Only simular part is that GPC irq mask, which only bit possition and
>> register offfset change.
>
> So at least GPC needs to be initialized as stacked IRQ domain.  Please
> check out commit b923ff6af0d5 (ARM: imx6: convert GPC to stacked
> domains) for how it should be done.

Yes!. Shenwei is working this.

Stacked IRQ is mainly for suspend/resume.
Plan move to irqchip. Register define also changed.

ARM power ON/OFF should be like regulator. but I have not any other
platform use regulator interface to control
ARM core power.

>
> Shawn
