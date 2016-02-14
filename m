From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 14 Feb 2016 14:15:11 +0100
Subject: [PATCH v4 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <1454540539.11389.14.camel@toradex.com>
References: <1453675703-31594-1-git-send-email-marcel.ziswiler@toradex.com>
 <1453675703-31594-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160201132916.GF10671@tiger>
 <1454540116.11389.11.camel@toradex.com>
 <1454540539.11389.14.camel@toradex.com>
Message-ID: <CACRpkdb7dY3f2CWoo3bTkOA1p9dFerp_F_O0Vsg0Pmk7t1YGxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 12:02 AM, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
> On Wed, 2016-02-03 at 23:55 +0100, Marcel Ziswiler wrote:
>> On Mon, 2016-02-01 at 21:29 +0800, Shawn Guo wrote:
>>
>> [snip]
>>
>> > +   /* STMPE811 touch screen controller */
>> > > + stmpe811 at 41 {
>> > > +         compatible = "st,stmpe811";
>> >
>> > The compatible seems to be used by kernel without a binding
>> > document.
>>
>> Indeed and looking at git logs Linus himself introduced it (;-p):
>>
>> commit 5a826feedc331a2d5ced2afd832199a70b3af891
>> Author: Linus Walleij <linus.walleij@linaro.org>
>> Date:   Wed Apr 23 23:35:58 2014 +0200
>> Subject: mfd: stmpe: Probe properly from the Device Tree
>
> Looking more closely there is actually a proper binding document which
> got added by Lee Jones:
>
> commit 84e6de813b2d1bdb127943d3c8edf1c1afaa90da
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Mon Nov 5 16:10:34 2012 +0100
> Subject: Documentation: Describe bindings for STMPE Multi-Functional
> Device driver
>
> Documentation/devicetree/bindings/mfd/stmpe.txt
>
> Required properties:
>  - compatible                   : "st,stmpe[811|1601|2401|2403]"
>
> Sorry for the noise.

Yeah the STMPE driver was a common work between Rabin and
Luotao Fu who pitched in the 811 with touchscreen support.

Then Lee added the device tree stuff.

I know it's a bit confusing that the DT bindings for the whole shebang
is in bindings/mfd but it is also confusing to split them up, don't know
what is best really :(

Yours,
Linus Walleij
