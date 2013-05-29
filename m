From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 May 2013 11:05:51 +0900
Subject: build failure: linux-next: ARM/SH-mobile defconfigs: kota2, marzen
In-Reply-To: <87txlmaf2a.fsf@linaro.org>
References: <87txlmaf2a.fsf@linaro.org>
Message-ID: <20130529020550.GC16836@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 03:57:01PM -0700, Kevin Hilman wrote:
> Hello,
> 
> Both kota2_defconfig and marzen_defconfig started failing in the most
> recnet linux-next (next-20130527) but were successful in the previous
> build (next-20130523).
> 
> Both fail wit this error:
> 
> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> /work/kernel/next/drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to `shdma_chan_filter'
> make[1]: *** [vmlinux] Error 1
> make[1]: Target `_all' not remade because of errors.
> 
> Full build logs are available here:
> 
>   https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=kota2_defconfig,label=kernel_cloud/54/console
>   https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=marzen_defconfig,label=kernel_cloud/54/console
> 
> Kevin

Hi Kevin,

thanks for bringing that to my attention.
I'll fix it up.
