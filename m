Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A70C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:04:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C105620661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gEMykzA2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Tmtf+qdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C105620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=poyx8Q02i7s5JRCwDcwnx1uEFp0azbB05cFlUFgDisc=; b=gEMykzA2YlaaOF
	jXcybgLqPOQVwzNcIUyUeXCo7y4ReIzt5CtIrbPL8DYnnmjWNMWpcLionBHiZq8PkSbh7Wa2w1Ux5
	jWPW5mAxim1WAgOYoZUQJ6Wp7397o418Ctzy2XoeTHZMDBb4QDppyT//leuILULnGAZjJDanGNMOq
	y7Ai4guXOTe9o7i8NkloWR7rWluXpIRMf0EF4DlwwhfIesvsnZzxCChetObVN/lGI0guxGtuKDpDi
	Wo9qUQJQwZXs9qLyxebON9dEiAOhSi9lIybISzzx2PIPb1NC4GXTX7/VQYi9tQNh3svBAU/rybJ8R
	0K4HYeQCMmOO2jHuclDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzp6-0003Ho-W1; Wed, 27 Feb 2019 14:04:36 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzp2-0003H7-Ce
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:04:35 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c7698eb0000>; Wed, 27 Feb 2019 06:04:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 27 Feb 2019 06:04:31 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 27 Feb 2019 06:04:31 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Feb
 2019 14:04:28 +0000
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
To: Nicolin Chen <nicoleotsuka@gmail.com>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <tony@atomide.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a3ebd508-04a3-6ad2-5cd4-332282f21a8a@nvidia.com>
Date: Wed, 27 Feb 2019 14:04:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1551276267; bh=gdJ8RMK9ENcJHzVUsV3yX4Fpjhmb5e41IiZKYpgS1Ik=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Tmtf+qdR3hUmQpM7q7v/5ufTkVCgFo8FHRtlMSf1Bw+T7+f8kNa0PFRhQ47MOnKUc
 vW8wDscIPlX0FDFCoQNKWzrD6Wqp4NS4c8FiOfeyMVDHbhE/MdoTRkLJ62AcBMFLIC
 7JSP/tO/gxarxJswfztjN4gqdpAzS4VlqObE9ipkYMoAIa5nz4MpQwlIUwKFWt4Z0V
 QppdXfeQZUUY97ULT5R0AmHCBPMlM5A9H4bbqkUikb9+kv/R+Ty75XRqztar22bGZ8
 XPy+p/RkJNV9vBicKEUuiC4HgG2G9vIlw8HLEZGSgDeLCBwT0tE7nAZoUwAHd3JOq9
 hU16KeQBs29aQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_060432_438259_AE354F90 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, sre@kernel.org, tomi.valkeinen@ti.com,
 laurent.pinchart@ideasonboard.com, linux-tegra <linux-tegra@vger.kernel.org>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 26/02/2019 20:23, Nicolin Chen wrote:
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> 
> The original change breaks omap dss:
>     omapdss_dispc 58001000.dispc:
>         dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Let's revert it first and then find a safer solution instead.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
> 	
> Would you please test and verify? Thanks!

This also fixes various memory allocation failures we have seen on
32-bit Tegra as well.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
