Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:40:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85CF21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uzkgtcdS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt9RhMqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85CF21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SmAQEBuf7XI015cBLRGZhu47WqlFa3iHt/dLc+viECA=; b=uzkgtcdSPt0f22
	pgX3MVMYVlKO43h1Ptkve40Tkd6s1YkFE3UrXpVlVhpilXRHexvE2Ra3ZH1N+235hyEE6CpKgk/kX
	pN/43pM6TRQG/CL1Y/4u3OpXb0VMr2hg0og7HtxGRYXiUjjeHO4+OqwWBCTX9oCsx8xS3tu76ir/1
	nOtUAlogvi8eHa/agp/rLaUknO7m6fkkEhIDnRItdEenJtsldR4icQtAtWHBeCwhB6TJXyLgqqo4X
	WXIM2K2afx0hPxWgINzB+GuRXEZ1I2XuuGHB+s9Q0I12C40wO0HCmC12hWIgFY4pvOU6RjxwZdq0l
	pmGh6iNbfpH60GqNuUBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEzo-00014w-7T; Tue, 19 Feb 2019 23:40:16 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEzk-00014A-RN
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:40:14 +0000
Received: by mail-lj1-x244.google.com with SMTP id z20so18119081ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Avlfot9LMftj+Z5hvyEovLVV6ww6QQJZ+gLb7fH0KpA=;
 b=Qt9RhMqo4o6locL1K2fzZy2LXcthbZYosRedyplsjLg+cgzKdPJyIiLN73x1f3V9f8
 n4qybe+oRccViti//ykwCSY/JNY+fFC1Sym31lDRuXGLgdH0nqTDhW+qao41VuY0rdZN
 niM6C6fqtTwXlD3bfrROu1YXKjdQz8jXqAvfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Avlfot9LMftj+Z5hvyEovLVV6ww6QQJZ+gLb7fH0KpA=;
 b=Y+8grd8rEBozSO1nsuZLfCmgywv8pkKSfebSpaNi07Rm2mIQdLegN7YUTzbttI8nLf
 JZpDtBCp4aeee1yk95rthjk5HnKKxebQ0QezfWNnl+0cYZovxcmrS8ugyOUuggC3/KZU
 o1ms5lpG/ojih+MOsLmRnCJzs7mWC0ftXZ21SyGyqTtSwr/bW0BQ6rMobKcm3XQ5/fuv
 wytjyzAKVGuGRbaYK9xHgSy3ICL9F3ObDeP6nZKTN6TfSuwHq//fw+5HWQhuF69yh7vp
 0PR6Al5+L/bS5bgMH0MWbpSmJAXpKRGrAh0One/xhrUHbgLvb9qYjM7i3P/XGhrBTRKR
 Vk8A==
X-Gm-Message-State: AHQUAubFTOfid/kOcSOfOEvvhbL3T4KYwRoTA7unVbKpxFKUsEdPxlJZ
 o+UEHTTqwhX8TYTYe4bISS8emonPm8U=
X-Google-Smtp-Source: AHgI3Ia0Bi2llXFpWJzmhTnWaRF/LtFe2Cf3/sjku8ttJxLgPTZg4YvjmeAQ5gC8V8Y86KMvZ5L9lg==
X-Received: by 2002:a2e:240a:: with SMTP id k10mr10390314ljk.31.1550619611044; 
 Tue, 19 Feb 2019 15:40:11 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50])
 by smtp.gmail.com with ESMTPSA id d26sm4320472ljc.15.2019.02.19.15.40.10
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:40:10 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id q12so16191395lfm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:40:10 -0800 (PST)
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr19485118lfa.27.1550619118494; 
 Tue, 19 Feb 2019 15:31:58 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-14-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:31:22 -0800
X-Gmail-Original-Message-ID: <CAE=gft4_PwC03FkzHysQiX-+aGEyOxDUxpHitwc26+_4qRoK3w@mail.gmail.com>
Message-ID: <CAE=gft4_PwC03FkzHysQiX-+aGEyOxDUxpHitwc26+_4qRoK3w@mail.gmail.com>
Subject: Re: [PATCH v6 13/22] iommu/mediatek: Add mt8183 IOMMU support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_154012_889029_698805C4 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
>
> Here list main differences between mt8183 and mt8173/mt2712:
> 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> 6) mt8183 need reset_axi like mt8173.
> 7) the larb-id in smi-common is remapped. M4U should add its larbid_remap.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
