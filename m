From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jul 2015 08:55:57 +0200
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <20150701062352.GA3739@lst.de>
References: <20150622081028.35954.89885.stgit@dwillia2-desk3.jf.intel.com>
 <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
 <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
 <20150701062352.GA3739@lst.de>
Message-ID: <CAMuHMdUO4uSWH1Qc0SfDTLuXbiG2N9fq8Tf6j+3RoqVKdPugbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 1, 2015 at 8:23 AM, Christoph Hellwig <hch@lst.de> wrote:
>> One useful feature of the ifdef mess as implemented in the patch is
>> that you could test for whether ioremap_cache() is actually
>> implemented or falls back to default ioremap().  I think for
>> completeness archs should publish an ioremap type capabilities mask
>> for drivers that care... (I can imagine pmem caring), or default to
>> being permissive if something like IOREMAP_STRICT is not set.  There's
>> also the wrinkle of archs that can only support certain types of
>> mappings at a given alignment.
>
> I think doing this at runtime might be a better idea.  E.g. a
> ioremap_flags with the CACHED argument will return -EOPNOTSUP unless
> actually implemented.  On various architectures different CPUs or
> boards will have different capabilities in this area.

So it would be the responsibility of the caller to fall back from
ioremap(..., CACHED) to ioremap(..., UNCACHED)?
I.e. all drivers using it should be changed...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
