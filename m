From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Sep 2012 10:15:29 +0200
Subject: [PATCH v2 4/5] ARM: EXYNOS: Increase maximum possible memory bank
 size to 512MiB
In-Reply-To: <24dc01cd8d6b$7426cf50$5c746df0$%kim@samsung.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1346748609-11115-5-git-send-email-t.figa@samsung.com>
 <24dc01cd8d6b$7426cf50$5c746df0$%kim@samsung.com>
Message-ID: <1796354.EpclCk5CFg@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Saturday 08 of September 2012 11:41:31 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Some boards have larger memory banks than 256MiB. This patch increses
> > maximum bank size for Exynos-based boards to 512MiB.
> 
> Well...the meaning of SECTION_SIZE_BITS is a little bit different you
> know.
> 
> Please refer to following thread.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/020184.ht
> ml

Well, I agree, but the effect of this patch is that it is possible to have 
first bank (or rather section) up to 512MiB, in case of CONFIG_SPARSEMEM.

Still, we could go the other way and just define more smaller sections 
instead and simply drop this patch. (Assuming that the correspondence of 
sections and memory banks is irrelevant.)

--
Best regards,
Tomasz Figa
