Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9F420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NI2YiSGl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/8+YP8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9F420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IXjUeRuvtXU+/iEloLs8fjaY+SxEyWd4YsrpmhT89Ss=; b=NI2YiSGlyoX1I5
	j2CDs+GvoLmvfKud6lJALxPeAOlwVo6QPPONij6Z5FAyKafLbrM6/e4iYzog43nCOKbSL+F6rIdpC
	Eh4+ckflQAaAfZxmBVMLcIgFAG3J34iJM0M+h4YTryV0d35Cdst8ON9x16jFYLD0E/4dmO4oW5vMf
	yXQC9R7WTR9nFZg20ZRy7OzjLjD+EpWoci9Rsi/qTDZYxrR8mOz3s9kE1FvbsvlVkZGm6WcLbKUa9
	MrqSafX5Gb0DeQYNkh5gUBnv1ud3bP5lC9hZwcU3DTsD6MGl6uvyLNWYWR44R0SSOsd/jjTWuCBYU
	Cubjl1dMRtGbjiwHyQ7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goubS-00044H-CN; Wed, 30 Jan 2019 18:28:50 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goubN-00042U-Md
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:28:47 +0000
Received: by mail-lf1-x143.google.com with SMTP id u18so360061lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QkOMpoKed0oV+8zD2WIVrhcLu4xsQ8yP+/TMONcyXe8=;
 b=A/8+YP8D8pjnZNNbInaO+adNXxNU+SfT4FM9uAVLAJo4PX/1mvE1WkaoSpAQgfYJZb
 yefaN3OWn3hUjoRl1aZh1jN05QQoIEW9VfbkLqX62I/AP568c3kWIiXf6GBABJkGqKPG
 k3Bnmtgqwpp+V8Ha3eirOmG7MKSmybtGaynCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QkOMpoKed0oV+8zD2WIVrhcLu4xsQ8yP+/TMONcyXe8=;
 b=LrdNobBo7AwBLa/BHs1lpKUq2NNl7fgb3wyC9lTRthTkwX2uSCvXxyMeO02/uTYHvn
 JpBOpAEZ+nb23+iPMGCMn+In98L7Qax6sycHKw7VwkiFVJhnPtJhXrr4O4LhktVxNg6v
 UhdmMYCogJjFLl3sLlaf/XXmbfWAHXbEXBfqNIMIX2oiExmlbVnkW/cOOEN35hVNFdY+
 nexGaS5HBD7V0pXhhZBv6Iadwmc/e4SzQ4YB2EilflLKG/RW0j7eAH6w0i+3SbRp3ukr
 ay/4DZ4G+MGDfdZneSc1EKqlE5pw8fyAPa9Egkjuzo51oU0W6sk9UYcDqTZ4fXezhxim
 DOYA==
X-Gm-Message-State: AJcUukdWM6XQu3DMCk0xuJ2Np6KEmlVDawNVmrtqhhSYBBrv3wMLGshB
 Cho44/CLeALpQWJDDULmatssM0WZitk=
X-Google-Smtp-Source: ALg8bN4gKz5e2XXaWE9+Ja5yQUHLq5y3am9NwsM+5/3GP//Db2TV1nsf8jrm53Juv+jgOdlWsyQEHw==
X-Received: by 2002:a19:26ce:: with SMTP id m197mr24317754lfm.23.1548872923491; 
 Wed, 30 Jan 2019 10:28:43 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com.
 [209.85.167.42])
 by smtp.gmail.com with ESMTPSA id b81-v6sm404699ljb.7.2019.01.30.10.28.41
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:28:42 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a8so386565lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:28:41 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id
 k123mr24303527lfg.101.1548872921418; 
 Wed, 30 Jan 2019 10:28:41 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-5-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-5-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:28:04 -0800
X-Gmail-Original-Message-ID: <CAE=gft5hkfwhKoxH0vZo54MqkF85-f7eKxY-DxkR29CBuBMJCw@mail.gmail.com>
Message-ID: <CAE=gft5hkfwhKoxH0vZo54MqkF85-f7eKxY-DxkR29CBuBMJCw@mail.gmail.com>
Subject: Re: [PATCH v5 04/20] memory: mtk-smi: Use a struct for the platform
 data for smi-common
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102845_742977_25F1775D 
X-CRM114-Status: GOOD (  12.65  )
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

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Use a struct as the platform special data instead of the enumeration.
>
> Also there is a minor change that moving the position of
> "enum mtk_smi_gen" definition, this is because we expect define
> "struct mtk_smi_common_plat" before it is referred.
>
> This is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
