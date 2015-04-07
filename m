From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Apr 2015 08:16:18 +0100
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <CAOesGMhz6WPweQFXfPhTO6Pz5L4Z1Si6YGiCRCiFD9B5qB9tVw@mail.gmail.com>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
 <CAOesGMhz6WPweQFXfPhTO6Pz5L4Z1Si6YGiCRCiFD9B5qB9tVw@mail.gmail.com>
Message-ID: <20150407071618.GE3461@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 Apr 2015, Olof Johansson wrote:

> Hi,
> 
> I understand this is bikeshedding to some extent, but I'd also like to
> avoid needless variation in binding formats:
> 
> On Tue, Mar 3, 2015 at 1:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > +
> > +foo at 1000 {
> > +               compatible = "syscon", "simple-mfd";
> > +               reg = <0x010000 0x1000>;
> > +
> > +               led at 08.0 {
> 
> This doesn't seem to be a typo, you're using a period in the unit
> address. I've never seen that done before, usually commas are used
> instead.
> 
> Was there a reason for going with period?

LEDs have always done it [1].  I guess Bryan would be the best person
to answer the 'why'.

git grep "led.*@[0-9]*[.,][0-9]*" -- Documentation/devicetree/ arch/arm/boot/dts/

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
