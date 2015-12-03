From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Dec 2015 21:42:20 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151203181441.GA16808@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <20151203174708.GO10747@e104818-lin.cambridge.arm.com>
 <20151203181441.GA16808@yury-N73SV>
Message-ID: <3415450.VSgEm2gPbU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 December 2015 21:14:41 Yury Norov wrote:
> 
> > I'm not sure there is much value in
> > keeping 4*PAGE_SIZE for larger page sizes but I agree that the current
> > 16K value doesn't work well with 64K pages.
> 
> Arnd told there will be a workaround for arm v6 caches. Than this
> header will not be needed at all. Until that, this is simpliest
> fix as it doesn't affect userspace.

I think we should do whatever matches user space: There is no harm
in going to 256KB instead of 64KB if current glibc already uses
4*getpagetsize() for a kernel with native 64K pages.

	Arnd
