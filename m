From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:47:20 -0800
Subject: [GIT PULL 1/4] Samsung devel for v3.4
In-Reply-To: <CAOesGMgec=KVBQJjVs3p3B2GGj9q9mwC2XCdxLNvvJL61u+f8g@mail.gmail.com>
References: <4F5B7C71.2090303@samsung.com>
 <CAOesGMgec=KVBQJjVs3p3B2GGj9q9mwC2XCdxLNvvJL61u+f8g@mail.gmail.com>
Message-ID: <4F5C6698.2030904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/12 10:20, Olof Johansson wrote:
> On Sat, Mar 10, 2012 at 8:08 AM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>> Hi Arnd, Olof,
>>
>> This is various develop regarding Samsung stuff for v3.4.
>> Please pull following:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> next/devel-samsung
>>
>> I think, you can pull this cleanly without any conflicts.
>> If any problems, please kindly let me know.
>
>
> Thanks, pulled into next/soc.
>
Olof, thanks.

And as a note, will happen merge conflict between this and 
cleanup-exynos-clock. Here is resolution.

diff --git a/arch/arm/mach-exynos/clock-exynos4.c 
b/arch/arm/mach-exynos/clock-exynos4.c
index 31b59e6..060dde7 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -471,6 +471,11 @@ static struct clk exynos4_init_clocks_off[] = {
  		.enable		= exynos4_clk_ip_cam_ctrl,
  		.ctrlbit	= (1 << 5),
  	}, {
+		.name		= "jpeg",
+		.id		= 0,
+		.enable		= exynos4_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 6),
+	}, {
  		.name		= "fimc",
  		.devname	= "exynos4-fimc.0",
  		.enable		= exynos4_clk_ip_cam_ctrl,


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
