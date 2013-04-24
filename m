From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Apr 2013 08:52:12 +0100
Subject: [PATCH] ARM: ux500: Supply a DTS file for the u8540 platform
In-Reply-To: <CACRpkdZWuw9O3-wr=g1AehZqmBR1YJ353w9ANfBTHhr5mRiwiw@mail.gmail.com>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdafSvT5Xb=7sqnkRHcc4UKkVzr8jzThMgWn6459RDmKGw@mail.gmail.com>
 <20130404072907.GB3004@gmail.com>
 <CACRpkdZWuw9O3-wr=g1AehZqmBR1YJ353w9ANfBTHhr5mRiwiw@mail.gmail.com>
Message-ID: <20130424075212.GE17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 4, 2013 at 9:29 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This is a skeleton DTS file which only enables serial. Just using
> > this simple file yields a terminal when booting u8540.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Now, wait... this doesn't work.

This is very strange and not what I see in my branch.

> > +/ {
> > +  model = "ST-Ericsson U8540 platform with Device Tree";
> > +  compatible = "st-ericsson,u8540";
> > +
> > +       memory {
> > +              reg = <0x00000000 0x20000000>;
> > +              };
> 
> Funny whitespace. Use tabs ...

This a single tab in my branch/editor.

> > +       soc-u9500 {
> 
> Please rename this not just "soc"

Done.

> > +                 uart at 80120000 {
> > +                                       status = "okay";
> > +                                              };
> > +
> > +               uart at 80121000 {
> > +                               status = "okay";
> > +                                      };
> > +
> > +               uart at 80007000 {
> > +                               status = "okay";
> > +                                      };
> > +                                      };
> > +};
> 
> The whitespace looks a bit funny compared to the
> old patch, what happened here?
> 
> It also has the side effect that patch 5/9 does not
> apply... By the way, since I already applied 4/9, please
> squash 5/9 into this patch to avoid problems.

It's quite common for issues to occur when patches are taken
out-of-order. As I work with topic branches, my preference would
normally be to fix issues with the patch-set as a whole until Acks are
obtained for all of the patches, then either send a pull-request or to
have all of the patches taken from the MLs in order.

> Finally, please patch arch/arm/boot/dts/Makefile
> in the obvious way so that the DTB gets compiled.

Ah  yes. Good spot.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
