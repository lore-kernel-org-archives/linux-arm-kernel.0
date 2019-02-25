Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099FEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:01:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7A5217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TkmDFAQj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbJJWEWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7A5217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U/oY92V6QTzkSkvuxRS71ej8sr5ZT/YEExKtiXtogD4=; b=TkmDFAQjGNpc/s
	gpA6LZ0/XjYStlm2A5KJFMcNK+jXsDpx0L1CEFf+KfbzYNaI61Ir9HmPa+CTEN4K1RN/lTqbJ21Mm
	4u35ZNCyM9qv7FXCw8STvK0YXhtshgOkPclx9gVyqd8hcW8Btsr33K5VGs7kJOSo3alogufmbBVAE
	BFwpW0cAe9u8QB0yiTQj75prkA68ncLK/fbdPQCUCuOQSut8yu2t9JnRqWJJNMVyB3oVhyLx1lMTy
	4lu8g7oSixrCjm6+zwCNKA9rQNetEM0dAdomLUJ68aCUsp01S2nAPpDrshzGrZkcnC6VKBlb+jcFK
	W9XcRmdcOav0qwGcYhfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQBQ-0003lH-6C; Tue, 26 Feb 2019 00:01:16 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQBM-0003jm-Qo
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:01:14 +0000
Received: by mail-lf1-x143.google.com with SMTP id j1so8245964lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6at03+IfyftJOZ611UYmfrhKENe4hC81JDgP6PclobI=;
 b=jbJJWEWM6eF9oCP1NMpk8Yukinjlq9+t7gv/7a84CBFGDZukcP4flP8NA4wUzECL6d
 gQaSHzdMtqzdPFVijtcmq0cBgXks4jXI9RK/EKomvMbxjXgGjI1RV6koI7ViM0LSMXZQ
 Z65IfBARVH9OVaof5/TgeXzwxyg84u4pxKBrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6at03+IfyftJOZ611UYmfrhKENe4hC81JDgP6PclobI=;
 b=nK8NecMD7Tb0pgLavazoxp6QB5fbOvs57t+TMe3ZdFvoHdS2vIW1RS6p1Ax6OzjJ9R
 PF1ndet8nZFunkI5GkzKq5oqu1iIL8LME5UiTrQgm1k53gaweJg7v5ojAa/E3FlkvRvA
 NrmWMK76qETddh1ZcIOto1jCm+4BzX7GLJbaHyZZ68Ch0Or2sOi3vPArtAwryPvxhB2F
 N1VFy8dqhT1pm+mwxXpeQTw773OTDQfkXZtS+wFurVxJOmj3grTVxb7VkAu1E80FTrk3
 R9M0pjPnmcGkszXEEz+wG61CPPELqJ6YP3HAJy59N6w0nMq9S4cOSFHglo1axMhRKsDR
 0/hA==
X-Gm-Message-State: AHQUAuY/HeJo1pv271mGxv6r+U3agePUbqCVaHWiLo2VE4BjB6X+WuC5
 hqOlfS/nSkdOCBoWGBEJQ+Euq9Re530=
X-Google-Smtp-Source: AHgI3IY6hQ1eR3gFG4YQCa9VTbITI2Zvaz5ptfk85KStQanYH8GewxearCTP6nbfVQ/jpYQFEOLaVw==
X-Received: by 2002:a19:7018:: with SMTP id h24mr11158198lfc.68.1551139268726; 
 Mon, 25 Feb 2019 16:01:08 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com.
 [209.85.208.179])
 by smtp.gmail.com with ESMTPSA id t11sm1850741ljj.92.2019.02.25.16.01.08
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:01:08 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id d24so8828825ljc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:01:08 -0800 (PST)
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr11069375lje.126.1551138938131; 
 Mon, 25 Feb 2019 15:55:38 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-7-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-7-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:55:01 -0800
X-Gmail-Original-Message-ID: <CAE=gft76=+Jv-zxZiftt5F=m4wTY2yyWJ5cjxuG9jLP49CqAZQ@mail.gmail.com>
Message-ID: <CAE=gft76=+Jv-zxZiftt5F=m4wTY2yyWJ5cjxuG9jLP49CqAZQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_160112_871330_CEB98C16 
X-CRM114-Status: GOOD (  10.47  )
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
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Rick Chang <rick.chang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added device_link between the consumer
> and smi-larb device. If the jpg device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Rick Chang <rick.chang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
