From: bahadir@l4dev.org (Bahadir Balban)
Date: Tue, 19 Jan 2010 13:04:04 +0200
Subject: Kernel Start-up Time
In-Reply-To: <201001181010.01975.caglarakyuz@gmail.com>
References: <201001181010.01975.caglarakyuz@gmail.com>
Message-ID: <4B5591A4.2050807@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caglar Akyuz wrote:
> Hello,
> 
> While measuring Linux start-up time, I see that printing version string in 
> "start_kernel" takes ~1.3 seconds. I guess this is the time between from 
> "bootloader jumping to uImage" and "printing version string in generic 
> start_kernel code".

> Thanks,
> Caglar
> 
> _____________________________________________________________________ 
>                                                                                                                                                                   
> [    4.700896] Starting kernel ...                                                                                                                                                  
> [    4.702971]                                                                                                                                                                      
> [    5.966039] [    0.000000] Linux version 2.6.30-davinci1-06079-g4e73fae-

Hi Caglar,

This sounds like the kernel decompression is taking time. Have you tried
booting an uncompressed kernel? See if you can print on physical uart
address from files under arch/arm/boot/compressed

Thanks,

-- 
Bahadir
