From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Thu, 16 Feb 2012 08:43:46 +0100
Subject: [PATCH] ARM: S3C24XX: Fix restart on S3C2442
In-Reply-To: <201202121459.54568.heiko@sntech.de>
References: <1329051929-8303-1-git-send-email-GNUtoo@no-log.org>
 <201202121457.18632.heiko@sntech.de> <201202121459.54568.heiko@sntech.de>
Message-ID: <201202160843.48203.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

Am Sonntag, 12. Februar 2012, 14:59:54 schrieb Heiko St?bner:
> Commit b27b072791dc (ARM: 7265/1: restart: S3C24XX: use new restart hook)
> introduced the new restart hook also for the S3C244x cpus, but it
> was only defined in the S3C2440 scope, i.e. when CPU_S3C2440 was
> selected. Devices using the S3C2442 like the GTA02 normally don't select
> this CPU which leads to compilation errors like:
>     LD      .tmp_vmlinux1
>   arch/arm/mach-s3c2440/built-in.o:(.arch.info.init+0x3c): undefined
> reference to `s3c2440_restart' make: *** [.tmp_vmlinux1] Error 1
> 
> Therefore move the s3c2440_restart function to s3c244x.c which is
> common to both cpus and also fix the naming to reflect this.
> 
> Reported-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
could you take a look at this patch and possibly pick it up as fix for the 
current -rcs.


Thanks
Heiko
