From: marex@denx.de (Marek Vasut)
Date: Sun, 28 Oct 2012 23:43:28 +0100
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
Message-ID: <201210282343.28460.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vasily Khoruzhick,

[...]

> > We really should work on the DT here.
> 
> Any volunteers? :)

Daniel, did you get anywhere with migrating PXA to DT please?

> It requires huge amount of work, and right now my goal
> is to get every piece of Z2 HW working with vanilla kernel, before those
> changes are lost in my github repo.

Good, but next time please focus on DT instead. It will need a massive amount of 
work, indeed, but then it will also weed out some legacy code.

> I see no advantages in moving Z2 to DT
> except self-education.

One less platform file after the platform is fully DT, that's always good. 
Besides, the legacy binding code is really annoying.

> I'm OK with DT, but it needs some time. Let's get
> non-DT version working properly first.

While I'm not saying I'm NAKing these, such attitude usually leads to people 
abandoning the DT idea and running away right after the patches are applied. 
Just my $0.02.

[...]

> >> +     z2_udc_init();
> > 
> > This patch adds _host_ ? So why do you have udc in here ?
> 
> Both, host and device.

UDC == usb device controller.

[...]

Best regards,
Marek Vasut
