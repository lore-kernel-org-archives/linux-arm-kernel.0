From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Feb 2013 16:20:31 +0000
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <CACRpkdZNpCJwp-uaH6feTcaPesNouwpHt-hO-M9v52G=Ux+Hqw@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-3-git-send-email-arnd@arndb.de>
 <1359445794.31148.34.camel@smile> <201301291313.03511.arnd@arndb.de>
 <CACRpkdZNpCJwp-uaH6feTcaPesNouwpHt-hO-M9v52G=Ux+Hqw@mail.gmail.com>
Message-ID: <20130208162031.GX17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 07:29:17PM +0100, Linus Walleij wrote:
> Actually I once read about a feature where the kernel provides
> a static page full of zeroes or something like this, that would be
> ideal to use in cases like this, then all of this dummy page
> allocation and freeing can be deleted.

I think you're thinking of empty_zero_page which is used to provide the
initial BSS pages for user apps.
