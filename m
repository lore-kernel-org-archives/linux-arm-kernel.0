From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jul 2015 09:19:29 +0200
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <20150701065948.GA4355@lst.de>
References: <20150622081028.35954.89885.stgit@dwillia2-desk3.jf.intel.com>
 <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
 <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
 <20150701062352.GA3739@lst.de>
 <CAMuHMdUO4uSWH1Qc0SfDTLuXbiG2N9fq8Tf6j+3RoqVKdPugbA@mail.gmail.com>
 <20150701065948.GA4355@lst.de>
Message-ID: <CAMuHMdXqjmo2T3V=msZySVSu2j4YjyE7FnVXWTjySEyfYLSg1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 1, 2015 at 8:59 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jul 01, 2015 at 08:55:57AM +0200, Geert Uytterhoeven wrote:
>> >
>> > I think doing this at runtime might be a better idea.  E.g. a
>> > ioremap_flags with the CACHED argument will return -EOPNOTSUP unless
>> > actually implemented.  On various architectures different CPUs or
>> > boards will have different capabilities in this area.
>>
>> So it would be the responsibility of the caller to fall back from
>> ioremap(..., CACHED) to ioremap(..., UNCACHED)?
>> I.e. all drivers using it should be changed...
>
> All of the zero users we currently have will need to be changed, yes.

Good. Less work to convert all of these ;-)

> Note that I propose to leave ioremap(), aka ioremap_flags(..., 0) as
> a default that always has to work, -EOPNOTSUP is only a valid return
> value for non-default flaga.

OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
