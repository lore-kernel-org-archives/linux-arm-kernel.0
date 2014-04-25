From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Apr 2014 22:16:30 +0200
Subject: [PATCH] ARM: dts: Remove vmmc-supply for mmc@12220000 on
 arndale-octa board
In-Reply-To: <1398456672-3936-1-git-send-email-javi.merino@arm.com>
References: <1398456672-3936-1-git-send-email-javi.merino@arm.com>
Message-ID: <535AC29E.8010905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javi,

On 25.04.2014 22:11, Javi Merino wrote:
> d726ca2d3316 (ARM: dts: Add vmmc-supply to MMC on arndale-octa board)
> added the vmmc-supply to nodes mmc at 12200000 and mmc at 12220000 of the
> DT.  However, this makes the kernel fail to boot on the arndale-octa
> spews:
>
> [    5.060000] dwmmc_exynos 12200000.mmc: num-slots property not found, assuming 1 slot is available
> [    5.065000] platform 12200000.mmc: Driver dwmmc_exynos requests probe deferral
> [    5.075000] dwmmc_exynos 12220000.mmc: num-slots property not found, assuming 1 slot is available
> [    5.085000] platform 12220000.mmc: Driver dwmmc_exynos requests probe deferral
>
> And eventually hangs.  Without the vmmc-supply property in the
> mmc at 12220000 node, the kernel boots again.
>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>
> Hi,
>
> Note that I don't know *why* removing the property works, all I know
> is that 3.15-rc2 fails to boot on my Arndale Octa unless I apply this
> patch.

Are you sure you have the required PMIC driver enabled in your kernel 
config?

Best regards,
Tomasz
