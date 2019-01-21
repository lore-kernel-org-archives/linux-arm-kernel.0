Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32214C2F3D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0478820861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ukQdImZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0478820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CQE/udSvB06GSeGOW3lil/tpmYx9pdoPa2EL/FTuGVA=; b=ukQdImZdXjBdK2
	AabYh9PJTUBLYsqJsw3DLephp3Y6cnAh/JSmDEK42Hzbtxm9IgGsif8xE8dJEKX/+v8yeJv8HwTFM
	BfZlh++Pxm/LhogLtjVXLv9YKfj8EBy8TMeCPjsmU+dnbx03t9LH+t5GKJ2P+iAzDrQO4ZWgMaJeZ
	hd6FlbzX09rBTATb3DDTHHWIwkHYSUwn/Jy3K630yRJ2eJCf+TgkrWhSjcZ3+SAMMEg0kMoeXhHEs
	4jRtVC7Sx3CeLo1uQaa6kRP0xzm6Fr1HwyyxVVSrvA1JR3TtihTKDNidS3gIVhXmgehXqg40UF3Nw
	yi9O5Afyttcu8kGhmMqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glaPB-0006EI-BO; Mon, 21 Jan 2019 14:18:25 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glaP6-0006DF-RZ; Mon, 21 Jan 2019 14:18:24 +0000
Received: by mail-oi1-f195.google.com with SMTP id m6so14618144oig.11;
 Mon, 21 Jan 2019 06:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OvUHUMbMfZNovD6rICuVB0Zp+DaCsmoZ/tqxPoP4GMg=;
 b=lifsnWhM6ezIM1IItu70y21L7tj9D+Z2tIngE7oBJyQmOmzrZZFp0kpvkPyP7pDIGM
 C7KyAhB0rPudDPH/gXpHMUCfFCJILPzutxP+Z9AipZCcGPVauOYTvjqxHwQqzgkh/1t6
 9uVo/JCt6tTgexJdAr++MFCMh8eHJtmf1QuV7evkbEIXMzy2bjZ9L+koApdX/NqhnHp2
 IyGwxcLqOox8OrhiriuxXnXKkZB4Pze7lyBaMwKiGLO1cBxG/LFMbtL5+ahj11HhbUEz
 eUgusoWfXv2H3PUY3lrcjzPhGb5WNS9+CQ07qliCYguHxWYzsF9y11590eXZPCovcSMv
 K1kw==
X-Gm-Message-State: AJcUukfwuaHzAoSOmz2OUam/WNrZq9rJJsvQ9V5KaH7xci+qUfx5Rk6p
 V/U+DUcqDIfdtmdQcr2IEA==
X-Google-Smtp-Source: ALg8bN72treqidZ7nfLMCjoeyZCbGvMfwPXQqxDxN4DSHCZSwSlZAbKwMPwb0lC/QHp3gUhB+9Udgw==
X-Received: by 2002:aca:e386:: with SMTP id a128mr5477048oih.79.1548080297415; 
 Mon, 21 Jan 2019 06:18:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b128sm6378833oif.7.2019.01.21.06.18.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 06:18:16 -0800 (PST)
Date: Mon, 21 Jan 2019 08:18:16 -0600
From: Rob Herring <robh@kernel.org>
To: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v10 3/3] dt-bindings: dma: uart: rename binding
Message-ID: <20190121141816.GA18109@bogus>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_061820_890208_3E4A4E20 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sean Wang <sean.wang@kernel.org>,
 Zhenbao Liu <zhenbao.liu@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Long Cheng <long.cheng@mediatek.com>,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 YT Shen <yt.shen@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 dmaengine@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 18 Jan 2019 11:10:16 +0800, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 --------------------
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   33 ++++++++++++++++++++
>  2 files changed, 33 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
