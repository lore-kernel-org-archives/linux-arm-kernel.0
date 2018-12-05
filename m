Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFE02082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qFn7P0a6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+MN+WYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFE02082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AaJbtgNXJ42SQ/xCYoiH4CsDPYxhR3WokkyoR7l2Kd0=; b=qFn7P0a621cc0p
	msE98buky4iH6eSzyg+8kWanBo+bI+Zp+e8DWqVB/ign8FRUXCoryEcSlQLoxd+XE4t3h7KaVQBAv
	39/3PlfpvQxfSO0JAMyk36BqAWWYSAhdkNbXD644MO+RVQz9TTVDUFjYMYUqN9uVXfjJxaB4mg309
	I2s5U5ZKggpv99fm9PBRtSdTTqg8atB/EUf0wO7tR7hIc3O/QU2WNMp0fEd9VGQeDV4rb1wVpBKzp
	Mksn1gNBr59qe7eG1rdJ7aZhJC36pR7Y35GDcizr4PafJPs5zZgUMuAOKj8pCZ9cbXaJvVANBJ+3I
	1WCXxQLsW27kJsKPfCDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTKh-00027s-9M; Wed, 05 Dec 2018 09:19:03 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTKd-00026V-52
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:19:00 +0000
Received: by mail-ed1-x543.google.com with SMTP id b3so16398664ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=k4x4HIua/ebWA4ICeAcRKBy/h5TWt5GAp0PQqy5ul3Y=;
 b=M+MN+WYPfm4NNV7wX75sanY6/CZSWnWn8H81lBGRO5Bo7XhoaVGvXqaFkNmZStyyNG
 n9r7FfxZ8QJHvyJhIv0AZbF8hcofPrKxOK12Pov2Zr7ZXM2Zj5wc0Ewdh5v7e+oh1irY
 tIzD9masPGRs0AeZt5H4pPC201rZttbIFVlz9mqmVzSj/DfDryV1Yu7VrPQigK6g9zQi
 02F1uKFtNsO810mU+AqnuB8oZKTmqRyFFBg8lX2pufsq52v6rho1E8diZPqX8m2FnOfh
 4fBGdDLWaeHt5sPOg7ZksSmsNiSA0fLU9oPxYDdsih8f/4Q2khYXjeGSEdRWFyfnrBih
 kXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=k4x4HIua/ebWA4ICeAcRKBy/h5TWt5GAp0PQqy5ul3Y=;
 b=FBaCYCuVE6e2y23Rj3dLVr4a9cU+GLzVGF6OIwIig+RKT5KIl4HnQaP91hNrdjJWnP
 PEVBoZN/ZoYImEelQeQriOsGx3dNomnJ7uqk2C6JywP5zqCimHbb7IMFgl0PVD709TN5
 Ni8ot3V/R1veCU5G3fnOM2uoXakG/2O21c6UfhgW1iUiriaUusFpmQ3RbzSGOgZphhrm
 QqtIooGEjEguY/1jeJyIgmVBLgdgGeF9oNuozlCrN51weCM4lKlUd2ghRPk0IBMMb29n
 djbzn0N7Sn1kvHekUMcABgVKZeatW7jJGhiF6wyhRX70T2OGuAP3Pd02ZJL5WXtRqINX
 qMbQ==
X-Gm-Message-State: AA+aEWYnyBj+0EJKGFwybnR34K64A90awed4s/LzXSZBEO0Frymasmr4
 H8Ay1ssyBAQ+UnNHlAXUKNM=
X-Google-Smtp-Source: AFSGD/WP/4fZapI4uzPRzqSCK1Qzo2f4xKVolkgPjiHXvOzIci6PHtUSW/nnssSVcEoJuIb4L72Q6g==
X-Received: by 2002:a17:906:81cc:: with SMTP id
 e12-v6mr18708661ejx.138.1544001527273; 
 Wed, 05 Dec 2018 01:18:47 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id v20sm5349833edm.29.2018.12.05.01.18.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 01:18:46 -0800 (PST)
Date: Wed, 5 Dec 2018 09:18:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
Message-ID: <20181205091845.kfro65nu7v4g6esa@master>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
 <20181205072528.l7blg6y24ggblh4m@master>
 <CANMq1KCi-k_4-66pMfvByzsjpf1H6_bvC82Ow0b_jEH6B3LHwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANMq1KCi-k_4-66pMfvByzsjpf1H6_bvC82Ow0b_jEH6B3LHwA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_011859_197918_2AFC99AD 
X-CRM114-Status: GOOD (  21.26  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 richard.weiyang@gmail.com, Levin Alexander <Alexander.Levin@microsoft.com>,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 Huaisheng Ye <yehs1@lenovo.com>, Matthew Wilcox <willy@infradead.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 03:39:51PM +0800, Nicolas Boichat wrote:
>On Wed, Dec 5, 2018 at 3:25 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Wed, Dec 05, 2018 at 01:48:27PM +0800, Nicolas Boichat wrote:
>> >In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
>> >data structures smaller than a page with GFP_DMA32 flag.
>> >
>> >This change makes it possible to create a custom cache in DMA32 zone
>> >using kmem_cache_create, then allocate memory using kmem_cache_alloc.
>> >
>> >We do not create a DMA32 kmalloc cache array, as there are currently
>> >no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
>> >ensures that such calls still fail (as they do before this change).
>> >
>> >Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
>> >Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>> >---
>> >
>> >Changes since v2:
>> > - Clarified commit message
>> > - Add entry in sysfs-kernel-slab to document the new sysfs file
>> >
>> >(v3 used the page_frag approach)
>> >
>> >Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
>> > include/linux/slab.h                        |  2 ++
>> > mm/internal.h                               |  8 ++++++--
>> > mm/slab.c                                   |  4 +++-
>> > mm/slab.h                                   |  3 ++-
>> > mm/slab_common.c                            |  2 +-
>> > mm/slub.c                                   | 18 +++++++++++++++++-
>> > 7 files changed, 40 insertions(+), 6 deletions(-)
>> >
>> >diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
>> >index 29601d93a1c2ea..d742c6cfdffbe9 100644
>> >--- a/Documentation/ABI/testing/sysfs-kernel-slab
>> >+++ b/Documentation/ABI/testing/sysfs-kernel-slab
>> >@@ -106,6 +106,15 @@ Description:
>> >               are from ZONE_DMA.
>> >               Available when CONFIG_ZONE_DMA is enabled.
>> >
>> >+What:         /sys/kernel/slab/cache/cache_dma32
>> >+Date:         December 2018
>> >+KernelVersion:        4.21
>> >+Contact:      Nicolas Boichat <drinkcat@chromium.org>
>> >+Description:
>> >+              The cache_dma32 file is read-only and specifies whether objects
>> >+              are from ZONE_DMA32.
>> >+              Available when CONFIG_ZONE_DMA32 is enabled.
>> >+
>> > What:         /sys/kernel/slab/cache/cpu_slabs
>> > Date:         May 2007
>> > KernelVersion:        2.6.22
>> >diff --git a/include/linux/slab.h b/include/linux/slab.h
>> >index 11b45f7ae4057c..9449b19c5f107a 100644
>> >--- a/include/linux/slab.h
>> >+++ b/include/linux/slab.h
>> >@@ -32,6 +32,8 @@
>> > #define SLAB_HWCACHE_ALIGN    ((slab_flags_t __force)0x00002000U)
>> > /* Use GFP_DMA memory */
>> > #define SLAB_CACHE_DMA                ((slab_flags_t __force)0x00004000U)
>> >+/* Use GFP_DMA32 memory */
>> >+#define SLAB_CACHE_DMA32      ((slab_flags_t __force)0x00008000U)
>> > /* DEBUG: Store the last owner for bug hunting */
>> > #define SLAB_STORE_USER               ((slab_flags_t __force)0x00010000U)
>> > /* Panic if kmem_cache_create() fails */
>> >diff --git a/mm/internal.h b/mm/internal.h
>> >index a2ee82a0cd44ae..fd244ad716eaf8 100644
>> >--- a/mm/internal.h
>> >+++ b/mm/internal.h
>> >@@ -14,6 +14,7 @@
>> > #include <linux/fs.h>
>> > #include <linux/mm.h>
>> > #include <linux/pagemap.h>
>> >+#include <linux/slab.h>
>> > #include <linux/tracepoint-defs.h>
>> >
>> > /*
>> >@@ -34,9 +35,12 @@
>> > #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
>> >
>> > /* Check for flags that must not be used with a slab allocator */
>> >-static inline gfp_t check_slab_flags(gfp_t flags)
>> >+static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
>> > {
>> >-      gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
>> >+      gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
>> >+
>> >+      if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
>> >+              bug_mask |= __GFP_DMA32;
>>
>> The original version doesn't check CONFIG_ZONE_DMA32.
>>
>> Do we need to add this condition here?
>> Could we just decide the bug_mask based on slab_flags?
>
>We can. The reason I did it this way is that when we don't have
>CONFIG_ZONE_DMA32, the compiler should be able to simplify to:
>
>bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
>if (true || ..) => if (true)
>   bug_mask |= __GFP_DMA32;
>
>Then just
>bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK | __GFP_DMA32;
>
>And since the function is inline, slab_flags would not even need to be
>accessed at all.
>

Thanks for explanation. This make sense to me.

-- 
Wei Yang
Help you, Help me

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
