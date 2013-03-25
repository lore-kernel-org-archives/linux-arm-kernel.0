From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Mar 2013 15:10:04 +0100
Subject: [PATCH 5/6] ARM: ux500: move PRCMU functions into the CPUidle
 driver
In-Reply-To: <51505816.1020302@linaro.org>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-6-git-send-email-linus.walleij@stericsson.com>
 <514AF99F.7040100@stericsson.com> <514AFD67.20205@linaro.org>
 <CACRpkdZa1NMRjatD5W7zcYZC=QWu6f7L4oqn48PWR0j5AqSmPw@mail.gmail.com>
 <51505816.1020302@linaro.org>
Message-ID: <CACRpkdab+iT4m5gDtuH2vYpRQRgTyOho4=s+zj0cEDfxE5g_FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 2:58 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 03/25/2013 02:44 PM, Linus Walleij wrote:

>> Shall I put it in <linux/platform_data/arm-ux500-pm.h> or so,
>> with the implementation in arch/arm/mach-ux500/pm.c
>> or so?
>
> Wouldn't <asm/pm.h> be better ? So we can have the same header name for
> all the drivers, no ?

I don't think that works with multiplatform. When building multiple
systems our approach is to not let any two header files have the same
name.

What we did for debug macro for example was to create the <debug/*>
namespace, so the old <mach/debug-macro.S> is now <debug/imx.S>,
<debug/vt8500.h>, <debug/ux500.h> ... etc.

So what would be needed would then rather be <pm/*> in
arch/arm/include/pm and under this we would create
<pm/ux500.h>.

But that require Russell and Arnds/Olofs consent I think,
what do you guys say? Other recommendations?

Yours,
Linus Walleij
