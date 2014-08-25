From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 25 Aug 2014 10:11:37 +0200
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
In-Reply-To: <7hbnrc6px3.fsf@paris.lan>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
 <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
 <53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
 <7hbnrc6px3.fsf@paris.lan>
Message-ID: <1408954297.31096.7.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Fri, 2014-08-22 at 16:54 -0700, Kevin Hilman wrote:
> Tomasz Figa <tomasz.figa@gmail.com> writes:
> 
> > Kukjin,
> >
> > On 31.07.2014 20:32, Kukjin Kim wrote:
> >> On 07/30/14 17:07, Thomas Abraham wrote:
> >>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
> >>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
> >>> which did not have CPUfreq driver support, enable the use of generic
> >>> CPUfreq driver.
> >>>
> >>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
> >>> Cc: Kukjin Kim<kgene.kim@samsung.com>
> >> 
> >> Looks good to me,
> >> 
> >> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> >> 
> >> BTW, who will handle this series? I hope see this series in 3.17.
> >
> > This series consists mostly of clock changes and it likely depends on
> > patches already in my for-next, so I would be inclined toward taking it
> > through samsung-clk tree. 
> 
> So has this series been picked up anywhere?  I don't see it in your
> samsung-clk tree, nor in Kukjin's for-next.
> 
> Also, I'm curious whether or how this is has been tested on big.LITTLE
> SoCs.  
> 
> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
> testing along with CPUidle, so there may be some untested interactions
> there as it seems a bit more stable without CPUidle enabled.
> 
> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
> together big.LITTLE 5420/5800, with or without the switcher.
> 
> Also, the patch below[2] is needed for 5800.

For reference, I had the same patch in a kernel tree we recently used
for a demo on the chromebook 2 13" (Exynos 5800). We didn't see any
stability issues due to this without CPUidle (using the ondemand
govenor). The kernel we ended up using had CONFIG_BL_SWITCHER disabled,
but i don't remember seeing stability issues when i did a testrun with
that enabled.  


-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/e02aa78e/attachment.bin>
