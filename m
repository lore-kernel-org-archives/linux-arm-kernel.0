Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CCDC0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E1C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cY9dXtMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E1C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=89LGDgmSF62nzy5kQyK7a3XmNafXVuhTeCOu5dcSpX4=; b=cY9dXtMvxQs+nx
	zYF5oGDd1pNTkBf1jO4+QuyAYycyOoFzoq4TIYrlTovtpOR4OUOyjQDtJznUdBSr1yv3UFOeVNp1b
	xYQDgzqsW+8MGwNmaBsEU5zrjrI6KaSgWXysWI9EFz1wWv9tnJPH30YLG2IImMj3Hntofl+4h7sIg
	lI66hcVg+PRAsRabGrPFSVBTX6PmNorwSgIpviL889Rx4givTpwpj34jFNwME1BvGB2wju28OTS4a
	MZFlWT+1QrPi5x4KbNfzxQftyEAYD5X8l6YWRpHbiF8G9KEkHrSbEJRH0JlEAB3bi+0qXetXSoHeo
	QPWxXFf4jBr5ik8IsrYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu10P-0003hC-CS; Wed, 13 Feb 2019 20:19:41 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu10J-0003em-RF; Wed, 13 Feb 2019 20:19:37 +0000
Received: by mail-ot1-f66.google.com with SMTP id u16so6535270otk.8;
 Wed, 13 Feb 2019 12:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cMay0Ox/p5VpcfWrb8jUlU02Ws2oh2aG5VLfXXUBtUc=;
 b=hKddYXlP9OZTC2KoQAHHZ7hRjV9o1uqlrQAhuU9FEC0RD0+DUOveL/l0feDlbnnbOF
 dZ8B7ih1CJLWYb9DINjXXTqhej5VcHnDzdfgQYibF3CY94OLK117tFX2Ncezw76rGwFH
 DYEDfo6JD69uTuheEJVArtDvJ0MlH/PhQzUvOhy7IM3GBMfbZT3GRAMuffSX++vC0PJ4
 Gt0Zfrb57gq4XYrkvz3XBalvOKad0RuL5GF39a+uKzxOvZ0NZ+r9rG5WlPAOv2I7k0tn
 N0EM3eFYqrRB3OAaLAd9Rii4s6I1epO/7L53cl9CtBjdHW4USdSkLlOYl7eOWBtW0fyr
 6fXA==
X-Gm-Message-State: AHQUAubGNFR7eGP+BgyMRs7F+O+nr1Pt9J49ny+GTc6Yxkhox82lb4Ku
 inPpK35ZSQhLlcmIw5hoOQ==
X-Google-Smtp-Source: AHgI3IY2dzipQ5Pm7yoX3MTUlIdOsHxQvSOMiPydfe0aO9TXQm3hVkVZztXRV/INtTeG0WDNRbNJGA==
X-Received: by 2002:aca:f08b:: with SMTP id o133mr1316195oih.32.1550089173784; 
 Wed, 13 Feb 2019 12:19:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n126sm111842oif.19.2019.02.13.12.19.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 12:19:33 -0800 (PST)
Date: Wed, 13 Feb 2019 14:19:29 -0600
From: Rob Herring <robh@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190213201929.GA21948@bogus>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_121935_881672_D10C9BC3 
X-CRM114-Status: GOOD (  12.14  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:09:27PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> v4:
> Use standard names for reset-gpios and gnss-fix-gpios
> s/an/a UART
> 
> v3:
> Removed the I2C and SPI interfaces references.
> Removed the "mediatek,mt3339" compatible line.
> Added the optional propertied (reset, fix)
> Added the pin names for the optional properties.
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
