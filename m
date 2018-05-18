From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 18 May 2018 10:15:22 +0200
Subject: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
In-Reply-To: <CAJeuY79ObkssY_=SLG==7xZri10P3yWFhXC3=CUVrdQ+7cBoHA@mail.gmail.com>
References: <20180225135308.GA14561@arx-s1>
 <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
 <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
 <20180515111711.l2g4vgsal7yr6dbr@flea>
 <CAJeuY79ObkssY_=SLG==7xZri10P3yWFhXC3=CUVrdQ+7cBoHA@mail.gmail.com>
Message-ID: <20180518081522.eiwlqy2c2twc72qs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 10:48:58PM +0800, Hao Zhang wrote:
> 2018-05-15 19:17 GMT+08:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> > Hi,
> >
> > On Mon, May 14, 2018 at 10:45:44PM +0800, Hao Zhang wrote:
> >> 2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> >> > Thanks for respinning this serie. It looks mostly good, but you still
> >> > have a quite significant number of checkpatch (--strict) warnings that
> >> > you should address.
> >>
> >> Thanks for reviews :) ,i'm sorry for that, it will be fixed next
> >> time.  and, besides, in what situation were the checkpatch warning
> >> can be ignore?
> >
> > The only one that can be reasonably be ignored is the long line
> > warning, and only if complying to the limit would make it less easy to
> > understand.
> >
> >> >
> >> > On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
> >> >> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
> >> >> +#define CFIE(ch)     BIT(ch << 1 + 1)
> >> >> +#define CRIE(ch)     BIT(ch << 1)
> >> >
> >> > You should also put your argument between parentheses here (and in all
> >> > your other macros).
> >>
> >> Do you mean like this ?
> >> #define CFIE(ch)     BIT((ch) << 1 + 1)
> >> #define CRIE(ch)     BIT((ch) << 1)
> >
> > Yep, exactly. Otherwise, if you do something like CRIE(1 + 1), the
> > result will be BIT(1 + 1 << 1), which will expand to 3, instead of 4.
> >
> > Also, CFIE looks a bit weird here, is it the offset that is
> > incremented, or the value? You should probably have parentheses to
> > make it explicit.
> 
> The vallue,
> BIT(((ch) << 1) + 1) It seem not very nice...
> 
> uhmm...
> In CAPTURE_IRQ_ENABLE_REG odd number is CFIE, even number is CRIE
> each channel has one CFIE and CRIE.
> 
> we can also describe like this:
> #define CFIE(ch)     BIT((ch) * 2 + 1)
> #define CRIE(ch)     BIT((ch) * 2)

That works for me.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/83300190/attachment.sig>
