From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 1 Feb 2017 10:33:17 +0000
Subject: [PATCH v3 0/3] ARM: !MMU: v7-A support, dynamic vectors base
 handling
In-Reply-To: <20170131192438.GB27312@n2100.armlinux.org.uk>
References: <20170131130446.5829-1-afzal.mohd.ma@gmail.com>
 <20170131192438.GB27312@n2100.armlinux.org.uk>
Message-ID: <0ffdd659-9c6d-900b-44d6-646c50730110@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/17 19:24, Russell King - ARM Linux wrote:
> On Tue, Jan 31, 2017 at 06:34:46PM +0530, afzal mohammed wrote:
>> Hi,
>>
>> ARM core changes to support !MMU Kernel on v7-A MMU processors.
>>
>> Based on the feedback from Russell, it was decided to handle vector
>> base dynamically in C for no-MMU & work towards the the goal of
>> removing VECTORS_BASE from Kconfig.
> 
> Looks good from my perspective.  If Vladimir can reply about patch 2,
> then I think we'll be good to go with these.  Thanks.
> 

My R-class and M-class setups continue to work with this series applied on
top of next-20170201 plus following fixup for PATCH 2/3

 -#define VECTORS_BASE          UL(0xffff0000)
 -
- /*
-  * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
-  * locations
+ #ifdef CONFIG_XIP_KERNEL
+ #define KERNEL_START          _sdata
+ #else

FWIW: Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks!
Vladimir
