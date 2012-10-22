From: p.paneri@samsung.com (Praveen Paneri)
Date: Mon, 22 Oct 2012 11:13:42 +0530
Subject: [PATCH] usb: phy: samsung: Introducing usb phy driver for hsotg
In-Reply-To: <20121020191919.GA555@elf.ucw.cz>
References: <1349256393-11741-1-git-send-email-p.paneri@samsung.com>
 <1350036934-6051-1-git-send-email-p.paneri@samsung.com>
 <20121015132836.GT24333@arwen.pp.htv.fi>
 <20121020191919.GA555@elf.ucw.cz>
Message-ID: <CAD6zSYOfasOuQX=N-YuMxvB-3zW=dERqfmX7yRtGLfg5HiiZvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 21, 2012 at 12:49 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > +#define S3C_PHYPWR                         (0x00)
> ...
>> > +#define S3C_PHYCLK                         (0x04)
>> > +
>> > +#define S3C_PHYCLK_MODE_SERIAL                     (1 << 6)
>> > +#define S3C_PHYCLK_EXT_OSC                 (1 << 5)
>> > +#define S3C_PHYCLK_COMMON_ON_N                     (1 << 4)
>> > +#define S3C_PHYCLK_ID_PULL                 (1 << 2)
>> > +#define S3C_PHYCLK_CLKSEL_MASK                     (0x3 << 0)
>> > +#define S3C_PHYCLK_CLKSEL_SHIFT                    (0)
>> > +#define S3C_PHYCLK_CLKSEL_48M                      (0x0 << 0)
>> > +#define S3C_PHYCLK_CLKSEL_12M                      (0x2 << 0)
>> > +#define S3C_PHYCLK_CLKSEL_24M                      (0x3 << 0)
>
> I believe these 0x 's should be removed. Ouch and << 0 is interesting,
> too, just remove it.
Yes it makes sense to maintain a uniform pattern across all the
definition. How about maintaining hex values everywhere instead of
dropping 0x's? It will make it easier to add big values to the
definitions tomorrow, if needed.
About "<< 0", IMHO people must have started using it to maintain a
parallelism with other definitions. I do not mind changing it if you
still feel that it's very much needed
thanks :)

Praveen
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
