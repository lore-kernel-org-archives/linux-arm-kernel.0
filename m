From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Mar 2011 11:36:38 +0100
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <4D6DFE67.3020801@stericsson.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>
	<20110216115729.GA29817@besouro.research.nokia.com>
	<4D6B78BF.1020102@stericsson.com> <4D6C7B56.9060109@codeaurora.org>
	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org> <4D6DFE67.3020801@stericsson.com>
Message-ID: <AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2011 at 9:23 AM, Maxime Coquelin
<maxime.coquelin-nonst@stericsson.com> wrote:

> I think we should have a tree like this :
>
> /sys/devices/system/soc/
> /sys/devices/system/soc/unique_id<- Unified way to export an ID for all machs

Arbitrary number of bits? Some will have a 64-bit ID, some will have 32-bit
etc.

Should we say it's a hex string of 64 bits?

> /sys/devices/system/soc/mach/
> /sys/devices/system/soc/mach/name<- Name of the mach
> /sys/devices/system/soc/mach/foo_id
> /sys/devices/system/soc/mach/bar_id<- Vendors may have several/different IDs
> to export (IDCODE for OMAP, Production ID...)

For Ux500 we can export the stuff we print today in mach-ux500/id.c,
put in place earlier by Rabin, I'd prefer if you hook in the new ID stuff
there as well, since it's so little platform code, and a logical place to
have it in.

> Linus, do you agree?

Yeah, sounds good.

Yours,
Linus Walleij
