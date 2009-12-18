From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 08:12:08 +0000
Subject: ARMv6 build error in v2.6.33-rc1
In-Reply-To: <005801ca7fb5$787b11e0$697135a0$%yang@samsung.com>
References: <005801ca7fb5$787b11e0$697135a0$%yang@samsung.com>
Message-ID: <20091218081208.GA28704@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 04:41:11PM +0900, Jinsung Yang wrote:
> Hi,
> I've been facing a build problem with ARMv6 architecture such as s3c64xx series.
> The logs are shown as below:
> --
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
> <stdin>:1523: warning: #warning syscall recvmmsg not implemented
>   CHK     include/generated/compile.h
>   CC      arch/arm/mm/copypage-v6.o
> arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> make[1]: *** [arch/arm/mm/copypage-v6.o] Error 1
> make: *** [arch/arm/mm] Error 2
> 
> 
> How we handle this?

__cpuc_flush_dcache_page became __cpuc_flush_dcache_area and gained a
length argument - which should be PAGE_SIZE for all existing users.
