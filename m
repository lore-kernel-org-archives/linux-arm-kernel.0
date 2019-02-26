Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6316C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61202147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nmTxg+G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61202147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G3JbXIMWNWcb+QA44Jf0uwTHBHhSL9UoOEh2If4vv0Q=; b=nmTxg+G/VLgmWt
	E6Tm9KuUpZHTxl+MFY61zg9Dihw7dHtxH9VR55qKdXHH+9vEwkbAzp7G9cSWyTlUIp1hNdsez7jdd
	PBsL7CY1ZQMPkpLbarQwGbyON6mm7AsCWVGcypbXvolHEfZN6jSuBZBbNR87f25b5JypitKzP1snM
	QEbotsEDABGKGZW3a4h1ZZYz/7Q4FrenEfFENLGWMtD3lFy6dZ/YWV/PQbEjZJ7Qn1POvIdquubi2
	RsZgmx2PeGHLKKfml+fbleDWOiOph3cPKiGoCmW9a6q5KKoeE6KTDV0ArU8abPx7yAEz0yqzpwSJe
	pHIBYKAUpC8eJFLIIZUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfo3-00010X-FW; Tue, 26 Feb 2019 16:42:11 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfnp-0000qx-SZ; Tue, 26 Feb 2019 16:41:59 +0000
Received: by mail-ot1-f67.google.com with SMTP id 32so11591738ota.12;
 Tue, 26 Feb 2019 08:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zXdBWEtVZVITl36Yawq8ekbRUcZSxtesapL4HUq7wjY=;
 b=oGXGg+VvuJKSm1Fb1sXFH0glF5g4QcWFf5kjt8DdEErDsZK/nIX0JtwtX9Mkj2NMtR
 LrYRa4G59hHpLWQQyLrjFZrTTtSr5/fOADINgAb7KFFNUoMrCqcoTIP2uKd3BfrWsd/q
 GsbNu9y6MGg9O8co4aLYQbs0iZoGCNzQuEdEzpocB2u/JnlEWG3dIZMXK2f8kO5k3AOb
 rHiS52htyRrHqw0zR16dQSnReD7b5SeKi/USAojHf53sAVLrYITmghWG2iPoeTqDDngZ
 RJkmp/W60kLxmGXQTYtj782fED0sTW/090vBMk8p1LPZIhjvMysBC6jiYCsjiQt1bFPN
 XDlg==
X-Gm-Message-State: AHQUAubSbIB6J873JDUTtOTood5KwAxuRRENLNn13dVtSb+cCIB1Fv2e
 6y00+p9HJhX5H8syb5KFCQ==
X-Google-Smtp-Source: AHgI3IYBJl28mYWIdst9a15OgS4FLz58Jl8Bi6t3ANluCWUUCa579wa+1s1U5giKH31upaW3DWM5tg==
X-Received: by 2002:a9d:6a09:: with SMTP id g9mr16085183otn.162.1551199315150; 
 Tue, 26 Feb 2019 08:41:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q5sm5317238otf.73.2019.02.26.08.41.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 08:41:54 -0800 (PST)
Date: Tue, 26 Feb 2019 10:41:53 -0600
From: Rob Herring <robh@kernel.org>
To: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190226164153.GA10352@bogus>
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
 <1551186660-16902-3-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551186660-16902-3-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_084157_951480_6FCE4A4B 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, wsa@the-dreams.de,
 leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 09:10:57PM +0800, Qii Wang wrote:
> Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> controller, MT8183 has different registers, offsets, and clock.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
