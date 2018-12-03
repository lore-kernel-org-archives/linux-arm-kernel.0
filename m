Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89005C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:33:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5985020850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="se5bUTCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5985020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wl0qHLkBrsUY7Xwg84qlwAkCT1edA14zP7nJFfw/VlU=; b=se5bUTCsoN/ITH
	IKT9LinfrfLRSV8E8XYayJJAgv5FEOV9N3OvuO9L6cpSKOQ2Bf1lcbddw6a3M3cMoAra+c/X8ncNq
	3p6TdX0qD12bjJ0Eq58DrCVh9wjbRd9v/+6oWLPt79Putz/DJ5SmdUcp+62UhW7dLgBRwylWGXYDj
	fVwFnGhnqGEiqAwAmEAwiEpxCPf9D/QJBMmJKd3mGsD5kbMLUNuFS/VFB0GVSrpRvp1T21ogrYYUj
	+Fb2mDbSn+HzQHfvHosQ1eN6prVwJ+q3bnxlV75E2aAmyU8lL6F8ENsJIMD+Irlypcnfr2Qalmwt2
	WNxtGrA3a41T0phgA0NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToLX-00068A-NR; Mon, 03 Dec 2018 13:33:11 +0000
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToLU-00066D-0x; Mon, 03 Dec 2018 13:33:09 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 66E5E402; Mon,  3 Dec 2018 14:32:47 +0100 (CET)
Date: Mon, 3 Dec 2018 14:32:45 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2 0/9] iommu: clean up/remove modular stuff from
 non-modules.
Message-ID: <20181203133245.cqwrdjbobop7x36y@8bytes.org>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_053308_250588_0F13930E 
X-CRM114-Status: UNSURE (   7.00  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
 Daniel Kurtz <djkurtz@chromium.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexandre Courbot <gnurou@gmail.com>, Simon Xue <xxm@rock-chips.com>,
 Rob Clark <robdclark@gmail.com>, linux-rockchip@lists.infradead.org,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 Jeffy Chen <jeffy.chen@rock-chips.com>, linux-mediatek@lists.infradead.org,
 Stepan Moskovchenko <stepanm@codeaurora.org>,
 Honghui Zhang <honghui.zhang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Nate Watterson <nwatters@codeaurora.org>, Hiroshi Doyu <hdoyu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 01, 2018 at 02:19:08PM -0500, Paul Gortmaker wrote:
> Paul Gortmaker (9):
>   iommu: audit and remove any unnecessary uses of module.h
>   iommu/rockchip: Make it explicitly non-modular
>   iommu/msm: Make it explicitly non-modular
>   iommu/mediatek: Make it explicitly non-modular
>   iommu/ipmmu-vmsa: Make it explicitly non-modular
>   iommu/qcom: Make it explicitly non-modular
>   iommu/tegra: Make it explicitly non-modular
>   iommu/arm-smmu: Make arm-smmu explicitly non-modular
>   iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

Applied all, thanks Paul.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
