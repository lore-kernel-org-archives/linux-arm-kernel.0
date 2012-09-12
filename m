From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 12 Sep 2012 19:52:02 +0000 (UTC)
Subject: [PATCHv7 10/12] ARM: OMAP4: HWMOD: add support for
 lostcontext_mask
In-Reply-To: <1342704392-23657-11-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-11-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1209121951450.17903@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jul 2012, Tero Kristo wrote:

> Currently hwmod only provides the offset for the context lose register,
> and if we attempt to share the same register between two or more hwmods,
> the resulting context loss counts get wrong. Thus, we need a way to
> specify which bits are used for the context loss information for each.
> This is accomplished by adding a new field to the omap4 prcm struct,
> 'lostcontext_mask', which specifies a bit-mask to use for filtering
> the register. Only the specified bits are read and cleared by the
> context lose counter update code. If a hwmod doesn't specify
> 'lostcontext_mask' (default behavior), the whole contents of the
> context register are used without any filtering.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued for 3.7.


- Paul
