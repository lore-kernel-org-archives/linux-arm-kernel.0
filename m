From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 15 Oct 2012 14:28:17 -0000
Subject: [PATCH] ARM: dts: exynos4210-trats: Split memory into 4 sections
In-Reply-To: <10e301cdaadf$ef547150$cdfd53f0$%kim@samsung.com>
References: <1349779199-30665-1-git-send-email-t.figa@samsung.com>
 <10e301cdaadf$ef547150$cdfd53f0$%kim@samsung.com>
Message-ID: <90045168.E2LIzQYnbL@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Monday 15 of October 2012 23:18:23 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Since the maximum section size on mach-exynos is set to 256MiB, boards
> > with memory configuration defined using sections bigger than 256MiB
> > will fail to boot with a kernel panic.
> 
> I don't think so and it works fine in my side. Probably, the reason of
> kernel panic you said is not a maximum sections size?

I have tested on arm-soc/for-next with exynos4_defconfig on Trats with DT 
and it does not work without this patch. Applying this patch makes it 
work.

> > This patch modifies the dts file of Samsung Trats board to define four
> > sections of 256MiB instead of two of 512MiB to fix the boot problem.
> 
> BTW, if this patch can fix the problem, OK, I will apply this for now.

Yes, please.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121015/f3c038e7/attachment-0001.html>
