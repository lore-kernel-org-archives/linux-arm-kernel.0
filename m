From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 14:13:15 +0200
Subject: [PATCH v6 03/15] irq: gic: support hip04 gic
In-Reply-To: <CAMJs5B82awFv7SV9RBu__t4_42PhR95VGPjS3LzWa2saDQReZg@mail.gmail.com>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <4785954.cZxbGoHV0t@wuerfel>
 <CAMJs5B82awFv7SV9RBu__t4_42PhR95VGPjS3LzWa2saDQReZg@mail.gmail.com>
Message-ID: <5771380.iAICUqpnKg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 13:08:17 Christoffer Dall wrote:
> On 15 May 2014 12:14, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 15 May 2014 10:34:35 Marc Zyngier wrote:
> >> > +static inline bool gic_is_standard(struct gic_chip_data *gic)
> >>
> >> Please loose all of the inlines. The compiler can do this by itself.
> >>
> >> > +{
> >> > +       return (gic->nr_cpu_if == 8);
> >> > +}
> >> > +
> >
> > I think it's actually the common style to spell out the 'inline'
> > for trivial helpers like this. The compiler doesn't need it, but
> > it also doesn't hurt and most people write it.
> >
> Only in header files, no?
> 
> I've been chastised previously for putting this in .c files.

It's crazy to make it a hard rule for C files one way or the other,
given that the compiler doesn't care.

I normally spell out the the inline part in my code because I find
that clearer to read.

	Arnd
