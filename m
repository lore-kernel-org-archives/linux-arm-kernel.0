Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC593C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:22:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7938320815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eWOAeCyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7938320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ioJHicVtfzw/81hR57qkWvnGUg4hPdb83vbVZiuZTFo=; b=eWOAeCyjGIroM+
	8e4hTlkiJ76GXTj+aJmFVTx9636AgYSTDL82bmoQ0mbEJ8XVXAaokTp+HGuqdS106qm3u89NIg+/c
	AAKs0RnWV5IqqBZb4WedFJkgnOqM3QVLr0mw3PPQqk+GWQFzANQthDzkIDJuYmbUKyfX2/SJfu8se
	ba8FB7GkA37Qail1FbuUZT4pEvuKvjLimyVvx0gvnTDEibIFdYRe+KN8fFw/Yiw930G+1hdh3vzQT
	jY9UQREDTyOu73zihp9atoy0yb/y/TL2j8G9osLnaKckmQizlkYkpeiEUEL+5jJCMzrZasWTcAKXa
	btL+STA0WvIuhtr1KmZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8Z4-0005tN-DE; Thu, 03 Jan 2019 19:21:58 +0000
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8Yy-0005sw-G3; Thu, 03 Jan 2019 19:21:56 +0000
Received: by mail-io1-f65.google.com with SMTP id b23so6916436ios.10;
 Thu, 03 Jan 2019 11:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dHR6P0IOq33ugUcuj7ppH3uYwROyKm6XyyQ9fiGwcTQ=;
 b=C0lEB50QJY4nkpOKWwoS71c+1IZzaj9NgJCkkWkwP+v30fsuvdOhibDX11WCjqNtdp
 kYj1N8RJSf3xePS8gk7gB89fsPns841D+W9d0fCF8hudFxXMrZPRFA2MP5/ZktNPwpHi
 dKqTRUFGOsdf9YvI+rd9RZyVDRbzhj6TNMwlrn2UtGkG54/H/O02X4DteuM/H5UuYn9D
 hvxqW36JgC8K7Km22f3Gg7hgbfKVTWUgaDUZwK6E/FptU2V0B1xuH9uvhYiZ5vNGa7eP
 aP9oZpv1+ZrHHpP0zruo5YG64UAo86UhF2LDE3v2nKwqEeNyhWLJyWlR6iZ4/BqLDcI+
 tKpA==
X-Gm-Message-State: AJcUukdaOuhQDGt/caxUSAWosa/tYvxswkmB2c4Vmbzvzjqd7IIHnCTo
 xCa1usaTKgFEcrJWWXxHjw==
X-Google-Smtp-Source: ALg8bN7be7bB/VxUgl8TszBC4rV4CMEArpP/+mYFjJAU4vVIDJPgTcZgLyFjPIPCgoBUMnWJBuTqtg==
X-Received: by 2002:a6b:1604:: with SMTP id 4mr32388753iow.29.1546543311444;
 Thu, 03 Jan 2019 11:21:51 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id m10sm11883234ioq.25.2019.01.03.11.21.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 11:21:50 -0800 (PST)
Date: Thu, 3 Jan 2019 13:21:50 -0600
From: Rob Herring <robh@kernel.org>
To: qii wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 1/6] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Message-ID: <20190103192150.GA16529@bogus>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
 <1545397111-24183-2-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545397111-24183-2-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_112152_530625_32D7FA14 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, wsa@the-dreams.de, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 21 Dec 2018 20:58:26 +0800, qii wang wrote:
> Add MT7629 i2c binding to binding file.
> 
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
