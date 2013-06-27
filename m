From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 27 Jun 2013 18:14:09 +0800
Subject: [PATCH] include/asm-generic/pci.h: include generic
 "pci-dma-compat.h"
In-Reply-To: <20130627082920.GA14335@darko.cambridge.arm.com>
References: <51CBB98D.3040304@asianux.com>
 <20130627082920.GA14335@darko.cambridge.arm.com>
Message-ID: <51CC1071.5040802@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2013 04:29 PM, Catalin Marinas wrote:
> On Thu, Jun 27, 2013 at 05:03:25AM +0100, Chen Gang wrote:
>> > If an architecture need "generic pci.h", it also need generic "pci-dma-
>> > compat.h",  so recommend to include it in asm-generic directly.
>> > 
>> > And now, for arm64 and m32r, may cause compiling error about it.
>> > 
>> > The related error (with allmodconfig):
>> > 
>> >   drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_exit?:
>> >   drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit declaration of function ?pci_free_consistent? [-Werror=implicit-function-declaration]
>> >   drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_init?:
>> >   drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit declaration of function ?pci_alloc_consistent? [-Werror=implicit-function-declaration]
>> >   drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment makes pointer from integer without a cast [enabled by default]
>> >   cc1: some warnings being treated as errors
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> From the arm64 perspective:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Thanks.

> (but make sure it doesn't break other archs)

I will try to check all related archs with allmodconfig (which can also
find more another patches, and can let me familiar the compiler step by
step).  ;-)


Thanks.
-- 
Chen Gang
