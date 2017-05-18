From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 May 2017 14:43:27 +0200
Subject: [PATCH 7/8] clocksource/drivers/fttmr010: Merge Moxa into FTTMR010
In-Reply-To: <CACPK8XdRe8Khnj3YFoQYKpKHM-5PHTqkP8Nt+jZ=eo-FThN-aw@mail.gmail.com>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
 <20170517140542.20016-8-linus.walleij@linaro.org>
 <CACPK8XdRe8Khnj3YFoQYKpKHM-5PHTqkP8Nt+jZ=eo-FThN-aw@mail.gmail.com>
Message-ID: <CACRpkdaWoGYh4D3D0+3mzVDTy78O2idyDmg9+U5zJc_mfn+WLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 9:22 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Wed, May 17, 2017 at 10:05 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> This merges the Moxa Art timer driver into the Faraday FTTMR010
>> driver and replaces all Kconfig symbols to use the Faraday
>> driver instead. We are now so similar that the drivers can
>> be merged by just adding a few lines to the Faraday timer.
>
> Nice work!
>
> I gave this a spin on hardware and it didn't work :(

How typical.

> Thanks for the rework! Unfortunately the Aspeed IP does not have bits
> to control the direction of counting, and the timers only count down.
> Bits 3, 7 and 11 are marked reserved in the data sheet. Can you rework
> the patch to count down?

How unintuitive.

I guess I will just make it handle the Aspeed separately, so we
count up on Gemini and Moxa and down on Aspeed if that is all
it can do.

> As an aside, we have a pretty decent model for the Aspeed SoCs in
> Qemu. If you want to use it to smoketest your rework:
>
>  $ qemu-system-arm -m 512 -M ast2500-evb -nodefaults -nographic
> -serial stdio -kernel arch/arm/boot/zImage -dtb
> arch/arm/boot/dts/aspeed-ast2500-evb.dtb
>
> I tested with Ubuntu's qemu v2.8. It looks like we have a bug when the
> kernel tries to use the clock the way your driver works, so we will
> look at that. It does function properly for the current upstream code.

Oh that's sweet! I'll test it if I can get it working like this.

Yours,
Linus Walleij
