Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9666F205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JxM6DZXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9666F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gvRKCXb0wSkpoHTsJ5a8pSKFY9KA2BfkulBv72Cgdrc=; b=JxM6DZXQ3jqC9l
	BHyZN2qOfaJWOqBJnqoxI0i3VYMo52S+BZ3QP6ON6Wf9WwMbviOLu6IJ4CQmkI6CJv2beAH90KuSX
	O9zKcqL9kJy1fBoCScEZ7YxgOPPMOLqkw7Ep0E6L7OL65pKD2Cw7HQDqZOWf5CffcSisiaoiXYzDC
	43K7Ss0iGqWQUSytZadeFnzUXF2lSvLdOeVXAR4m4FW67pOAPTjwCWPkTeNVpRWaX04ZHkK32lnJd
	A8o0ASNBNurXoDPTQNicqX3+bGGNwIarIxovYUkqEa5VOaj0Cctpsu1ANDNOWgX8+bjGpq/pqmtiH
	jbEoMfHt15HYr0yrWvhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8jv-00030d-AI; Thu, 17 Jan 2019 14:33:51 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8js-000309-7x; Thu, 17 Jan 2019 14:33:49 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id E80C98119;
 Thu, 17 Jan 2019 14:33:52 +0000 (UTC)
Date: Thu, 17 Jan 2019 06:33:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: min.guo@mediatek.com
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb controller
Message-ID: <20190117143342.GS5544@atomide.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_063348_318978_3327C6E7 
X-CRM114-Status: UNSURE (   6.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yonglong Wu <yonglong.wu@mediatek.com>, hdegoede@redhat.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> There are some quirk of MediaTek musb controller, such as:
>  -W1C interrupt status registers
>  -Private data toggle registers
>  -No dedicated DMA interrupt line

Can you please separate the musb generic changes listed above
into separate individual patches in preparation for adding
support for new hardware?

Otherwise we'll have hard time finding out with git bisect what
exactly breaks things if we run into trouble.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
