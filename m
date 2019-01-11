Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FEEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A74F2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nZm4KaAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A74F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OpOusfWiQb9/7UjRi6xL9t2ppPtyaBkxuZ16QjO+/cQ=; b=nZm4KaAw+43w0a
	KiF9gALGKCrsuBYPgOwFTDBDSiFC7cRGDeaJNx8OR8f5o2jLLf2fFSJiiLcypvTtaNkQyBCOs2vJm
	96be4aZ2nYfgjuoB8JZdeDowbaEd3Z3slvEgRKksdoYIWyy1a9VLUlu4UoAAyz13ja/GBStvZ8CuG
	14Hwqg+kYPfqAEvbUUbWoOIRFOLYEoAxfb6NQOWcZejUYkCMN50ixjV6Bn4hZBCE8yH7mGZoXq/Br
	kPrjVIWPwDsk4AB46tlwNn95x0mvlSYcxm8PXmkSkxsz9TmMgQbmUhQFOSnm+HdMw214FRM0SKRFj
	Che2n9VOSkmmB1lSo+xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi5Ep-0001T4-HC; Fri, 11 Jan 2019 22:25:15 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi5Em-0001SX-RV; Fri, 11 Jan 2019 22:25:14 +0000
Received: by mail-ot1-f68.google.com with SMTP id n8so14527431otl.6;
 Fri, 11 Jan 2019 14:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jhAkMNvb6M5SiqQtcjhe3QeygTMXC9GQ3+0Ij0ePi7c=;
 b=WVagf0mbWJYN6fEurl/8jlZ2g8t5NtG7mM5vQN9pH4lw7ErlMnoY1y8Uil+XCdtqzN
 d9y65G4usaQOI6OwlbP9qvUdh/5TOPdmBly1/MQHwzB1el0npV812dwjtTE4Gbd+2qtx
 Rr3SgQOTJ0wpvZ/GNFd6VGzM5mhdB+o/V9Nx/Rz6fQy9FtVS2DxnKFtuj2uqxrXJ8os0
 X//7+beelpNGgzG+P8ZydQ1CEZ2zRj4Wu69IkqpPwUcqswMQtUvlDtI/l1DtVhxn9OWC
 zVw1XxLngg3IA5rTIk/dySYuf7ESEsfHRKTUdMH9hCyKf6Ra+7ZRISA6hMwq8XLkwe0s
 Wzkw==
X-Gm-Message-State: AJcUukcIt23oHcgAoEUYgQl3ASTZYfnDyG2X7wKBUslzLZPY61E4JP+D
 UryWyYlnvGBvDS/cmAZQNw==
X-Google-Smtp-Source: ALg8bN42FkcADg+ATt56j+6pLQyeQuUD3BIMjoBtp+CLidNGIqImusOfsS67y1cdxQ4BUNk9pgJWYg==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr11176024otg.139.1547245511131; 
 Fri, 11 Jan 2019 14:25:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b12sm33599027otp.75.2019.01.11.14.25.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 14:25:10 -0800 (PST)
Date: Fri, 11 Jan 2019 16:25:09 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Jourdan <mjourdan@baylibre.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: meson: add specific simplefb bindings
Message-ID: <20190111222509.GA14462@bogus>
References: <20190107095307.15233-1-mjourdan@baylibre.com>
 <20190107095307.15233-2-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107095307.15233-2-mjourdan@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_142512_889349_F646E01B 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 10:53:06AM +0100, Maxime Jourdan wrote:
> Similar to simple-framebuffer-sunxi, we support different display pipelines
> that the firmware is free to choose from.
> 
> This documents the "amlogic,simple-framebuffer" compatible and the
> "amlogic,pipeline" extension.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++

Use the compatible string for the file name: 
amlogic,simple-framebuffer.txt

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
