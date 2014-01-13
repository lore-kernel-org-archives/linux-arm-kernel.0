From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Mon, 13 Jan 2014 14:47:19 +0900
Subject: [PATCH 0/6] mmc: sdhci-s3c: Fix base clock source management
In-Reply-To: <1704043.sYrCOYas4N@phil>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
 <1704043.sYrCOYas4N@phil>
Message-ID: <52D37DE7.1000407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All.

On 01/13/2014 06:18 AM, Heiko St?bner wrote:
> Am Samstag, 11. Januar 2014, 22:39:00 schrieb Tomasz Figa:
>> Tested on S3C6410-based Mini6410 board, with following performance
>> figures:
>>
>> * Before this series (133 MHz HCLK always selected, leading to at most
>>   33 MHz card clock):
>>
>> root at tiny6410:~# hdparm -t /dev/mmcblk0
>>
>> /dev/mmcblk0:
>>  Timing buffered disk reads:  42 MB in  3.10 seconds =  13.54 MB/sec
> 
> # hdparm -t /dev/mmcblk0
> 
> /dev/mmcblk0:
>  Timing buffered disk reads: 44 MB in  3.12 seconds =  14.11 MB/sec

/dev/mmcblk0:
 Timing buffered disk reads:  38 MB in  3.14 seconds =  12.12 MB/sec
> 
> 
>> * After this series (48 MHz EPLL clock selected, leading to 48 MHz card
>>   clock):
>>
>> root at tiny6410:~# hdparm -t /dev/mmcblk0
>>
>> /dev/mmcblk0:
>>  Timing buffered disk reads:  56 MB in  3.04 seconds =  18.41 MB/sec
> 
> # hdparm -t /dev/mmcblk0
> 
> /dev/mmcblk0:
>  Timing buffered disk reads: 48 MB in  3.01 seconds =  15.94 MB/sec

 /dev/mmcblk0:
 Timing buffered disk reads:  56 MB in  3.05 seconds =  18.35 MB/sec
> 
> 
> So on a s3c2416:
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Tested with exynos4 board.

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by; Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> 
> Thanks for the added bandwidth :-)
> Heiko
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
