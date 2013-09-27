From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Sep 2013 20:28:16 +0800
Subject: device tree binding documentation outdated
In-Reply-To: <20130927084504.GW12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
 <20130927025116.GG25146@S2101-09.ap.freescale.net>
 <20130927084504.GW12758@n2100.arm.linux.org.uk>
Message-ID: <20130927122814.GK25146@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:45:04AM +0100, Russell King - ARM Linux wrote:
> To me, encountering this for the first time, the documentation is
> _wrong_ no two ways about it - as I said in my initial email.  Please
> fix it, or delete it.  Don't leave it in its current crap state.  Bad
> or misleading documentation is worse than no documentation.

Ok, I will fix it.

> I am a "user" of this crap, and it is _very_ confusing that the
> documentation is wrong, and the fact that I sent my initial email in
> this thread is proof that your statement above is wrong.
> 
> For instance, "two integers array" is a lie, plain and simple.  Yes, it
> may be true that what users care about is a macro and a number but that
> is not a "two integers array".

Indeed.  I forgot killing this "two integers array" thing while I was
updating the document to expands PIN_FUNC_ID as <mux_reg conf_reg
input_reg mux_val input_val>.

> It would be helpful here to explain that
> PIN_FUNC refers to a macro in the imx*-pinfunc.h header file, which
> expands to four or five integers.

Ok.

> Bit 31 (or even bit 30) in the config number are not documented
> either.

They are documented in fsl,imx-pinctrl.txt.

> All the numbers come into play when you're trying to port a platform,
> because when you encounter something like this:
> 
> +       IOMUX_PAD(0x05E0, 0x0210, 3, 0x0790, 1,

These numbers have been taken care of by the macros in imx*-pinfunc.h.
You only need to find the corresponding macro for it from the header.

>                 PAD_CTL_PKE | PAD_CTL_PUE | \
> +               PAD_CTL_PUS_100K_DOWN | PAD_CTL_SPEED_LOW |     \
> +               PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS),

The CONFIG number has nothing to do with imx*-pinfunc.h.  You will need
to translate the setting here into the last number of fsl,pins entry.

> you need to be able to find out which of these C macros that corresponds
> to for the pinfunc.h mess.
> 
> As it is, sorting out the pinmuxing on IMX is a nightmare - I've so far
> spent almost 8 hours on this problem trying to work out what the right
> way to describe this stuff is in DT, and its far from what I'd call fun.
> And I've still more to do on this.
> 
> Please fix the documentation.

Yes, will do.

Shawn
