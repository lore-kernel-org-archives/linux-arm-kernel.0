From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Feb 2013 19:29:17 +0100
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <201301291313.03511.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-3-git-send-email-arnd@arndb.de>
 <1359445794.31148.34.camel@smile>
 <201301291313.03511.arnd@arndb.de>
Message-ID: <CACRpkdZNpCJwp-uaH6feTcaPesNouwpHt-hO-M9v52G=Ux+Hqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 2:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 January 2013, Andy Shevchenko wrote:

>> > +   pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
>>
>> Where this memory will be freed?
>> In dependence of the answer could you consider to use
>> devm_kmalloc or __get_free_page?
>
> There is another function like this called pl022_dma_probe()
> that has the same allocation, and it gets freed in the same place.
>
> It's probably worth changing this into something different, but
> I felt that it didn't belong into this patch. I was also not
> sure if the best option would be dmam_alloc_coherent, dev_kzalloc,
> or __get_free_page.

Actually I once read about a feature where the kernel provides
a static page full of zeroes or something like this, that would be
ideal to use in cases like this, then all of this dummy page
allocation and freeing can be deleted.

Yours,
Linus Walleij
