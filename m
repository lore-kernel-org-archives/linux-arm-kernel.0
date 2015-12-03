From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 3 Dec 2015 21:14:41 +0300
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151203174708.GO10747@e104818-lin.cambridge.arm.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel> <20151201212904.GA14442@yury-N73SV>
 <20151203174708.GO10747@e104818-lin.cambridge.arm.com>
Message-ID: <20151203181441.GA16808@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 05:47:08PM +0000, Catalin Marinas wrote:
> On Wed, Dec 02, 2015 at 12:29:04AM +0300, Yury Norov wrote:
> > My question. Why aarch64 defines COMPAT_SHMLBA as 0x4000?
> 
> This was done to match the arch/arm value of 4 * 4K. The historical
> 32-bit reason for 4 pages is to cope with aliasing VIPT caches (see
> https://git.kernel.org/cgit/linux/kernel/git/tglx/history.git/commit?id=4197692eef113eeb8e3e413cc70993a5e667e5b8)
> 
> > If there's
> > no specific reason for it, it looks like a bug, and we should
> > define it like in arch/arm:
> >         #define SHMLBA  (4 * PAGE_SIZE)          /* attach addr a multiple of this */
> 
> I guess you meant COMPAT_SHMLBA.

I citated arm code here. In aarch64 it's COMPAT_SHMLBA, of course.

> I'm not sure there is much value in
> keeping 4*PAGE_SIZE for larger page sizes but I agree that the current
> 16K value doesn't work well with 64K pages.

Arnd told there will be a workaround for arm v6 caches. Than this
header will not be needed at all. Until that, this is simpliest
fix as it doesn't affect userspace.

> 
> -- 
> Catalin
