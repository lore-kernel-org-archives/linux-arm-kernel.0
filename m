From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 10 Aug 2012 08:36:02 -0500
Subject: [PATCH] efikamx: reintroduce Genesi Efika MX Smarttop via device
 tree
In-Reply-To: <20120810014119.GD19617@S2101-09.ap.freescale.net>
References: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
 <20120808151555.GE14718@S2101-09.ap.freescale.net>
 <CAKGA1bkbp8_z+HSr97cp_jeCrdTHkQxuZPFu0QPWwnXphWVdZA@mail.gmail.com>
 <CAOMZO5DOEfV4wTSNW8ABaUhGwa_KG3Bkt0o-rs8k-cZk4P-=+A@mail.gmail.com>
 <CAKGA1bkOo=En2P18FaBpq_KAZ88kisikXhNTabvnDknQ-EwFjA@mail.gmail.com>
 <20120810014119.GD19617@S2101-09.ap.freescale.net>
Message-ID: <CAKGA1bmd-53G=59F7Nsd3Sx2eEQgvcahnt3g5zxJAGawtc-gWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 8:41 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Aug 09, 2012 at 09:29:39AM -0500, Matt Sealey wrote:
>> The reason the new kernel depends on the new U-Boot is we're trying to
>> do all pinmux configuration in U-Boot (and we do in-house, and it
>> works). No pinctrl stuff in the kernel or device tree is required at
>> this point. The Old Kernel will remux a few things redundantly or
>> change drive strengths or whatever or add hysteresis to the UART port
>> which is not board-burning but is not really necessary, but it will
>> work. The new kernel will just be able to do what it does out of the
>> box, which is how it should be (hence why I object to adding pinctrl
>> setup...)
>
> Then I will have to refuse to accept your patch, because I'm working on
> a series to remove pinctrl_provide_dummies() from imx51_dt_init().

Requiring it breaks the entire concept of the device tree to describe running
hardware. It is not a configuration script. pinctrl should be optional
- built in
always, but not necessary to turn a board on if it's already configured.

What would happen if a board were designed that only used the default ALT
settings on i.MX53 or so? You'd have to redefine every default IOMUX pad
just to get it to boot. That's intolerable.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
