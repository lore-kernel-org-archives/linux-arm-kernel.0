From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Wed, 2 Dec 2015 02:21:59 +0100
Subject: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
In-Reply-To: <20151202004623.GX23396@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-11-git-send-email-tony@atomide.com>
 <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
 <20151202004623.GX23396@atomide.com>
Message-ID: <CAALWOA_=k=Z4m=1fC4jXJf9-a33OQuhHoEYJ7B8dXR9e4eF9fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2015 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> We should probably have separate PIN_INPUT_3V3 and PIN_OUTPUT_3V3
> dts macros that ensure that?

I'm in general no fan of such macros: it feels really awkward to have
to make that distinction in dts when doing pin config.

Note that if you're feeling really enthausiastic about putting in
effort to allow inputs to be disabled while staying clear of the
erratum, I think you can detect at runtime which I/O supplies are 3.3V
by inspecting this register:

#define CTRL_CQDETECT_STATUS    0x48140e00

Matthijs
