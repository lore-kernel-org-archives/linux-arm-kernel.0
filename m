Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD80217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="awPPcSsu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PQUfPwrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD80217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uyIy+a1A+XgjFenahQjUWrJAR8IBFwSz5Id9tWUpuzA=; b=awPPcSsuwXU6A9
	cxCAR4NEzrnJuhvQXF+HdUe64kY1R+E6SiGFzrX9DAr0iWbhCcQXrQH5A4BCtr1AtDw+Lx5lft6KU
	93WJ+nOHBjyiDDddFyRx4vAo0Hk5ir/3e4T5YRFALoFMX14cgR5VoTxfLfwFsTErHL6t1IdboURc/
	HCe/QKQNgQj7nG+zlYYnl6UGI3fmKsLGYymwXjZ3IyKI7GjyQ8Kagb17+FtnVqsv3CX8yGCEHPrZR
	8aSIXnoiL8zHs4dr9WI7MXwH58ckcmzlLps5njRlvTL57tLtZiLugRndvLe1vFvF2fdWwiD7yxt94
	P0zN+IjThQClLCLGHTnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQCW-00044C-55; Tue, 26 Feb 2019 00:02:24 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQCS-00043c-7w
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:02:21 +0000
Received: by mail-lf1-x143.google.com with SMTP id g2so8246617lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BBBvJ5O1lizmSG/RcyRUvgsbHkA/R9Bv19K+pXXW6dc=;
 b=PQUfPwrHQX+Q5XqDAUVTooJpkVnxbAm0WClBt2lGerOGUm5e5PmWfkcbOyWTSnw4Go
 goAOdRvVF716J6oWY9S6DT4TKVWy/QUQBCzZ+Z3TwUPTmFSytAXu2VA6zcb21UYvdtMU
 fDt2I6QYCFDFF+McYhuoYtpdiw/s5i03jrbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BBBvJ5O1lizmSG/RcyRUvgsbHkA/R9Bv19K+pXXW6dc=;
 b=YzT4u5zmMAaRUYhLk8GKT5BNkham3CxDi1Xsw6dTyr1OekutGPHg+qSqSRYZuShVcT
 jYy6oVSlAJrXJVwTtN9TPwpELX/hc+VkEmA4yw+fv0lq0Oi9xtumYydttvW5sCuXggGW
 YxOPDADCUl1nk4ojgo4RFARacorogM7uHPuh5NczNfeqF1W38kfq5kvA6GHJAcuMwFZq
 YQC9SR/pVUGjSpfSeNWdHXoU6UBTt3AZc9vrYuJXaMVFTABDIXjgRQpoIAMnUg4DAfjt
 ODtukhUTGEILsIcCt0Sb8gZdrvM5fdwChO/Osmx+ibd7C/6sWk6Fs/zWpKm36w56rkXe
 WeSg==
X-Gm-Message-State: AHQUAuaJL0pvwbAtsxNq5TEYm1JRL0yT+T6johl5OmcOP+3aB4rW+6uO
 G3YU/ze/GBY/sKnAWvgM8DfxBdLh+VY=
X-Google-Smtp-Source: AHgI3IZor0Jmkb2qkRD1ydbTx/h659VEqjCmZ7dNA+s/O6slQFuDmYSQayY8zegTwZ1Wp6VRoxsshw==
X-Received: by 2002:a19:d1c7:: with SMTP id
 i190mr11631327lfg.149.1551139338376; 
 Mon, 25 Feb 2019 16:02:18 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id p10-v6sm2476593ljh.59.2019.02.25.16.02.18
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:02:18 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id d24so8831111ljc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:02:18 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr11648555ljj.30.1551138951645; 
 Mon, 25 Feb 2019 15:55:51 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-8-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-8-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:55:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft7VtbN2kQ=sxcdtCSB=hc-AEFqSWK3WfipzoaZb3i0sag@mail.gmail.com>
Message-ID: <CAE=gft7VtbN2kQ=sxcdtCSB=hc-AEFqSWK3WfipzoaZb3i0sag@mail.gmail.com>
Subject: Re: [PATCH 07/13] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_160220_285314_6A51D839 
X-CRM114-Status: GOOD (  10.54  )
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
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Arnd Bergmann <arnd@arndb.de>,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
