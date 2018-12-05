Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19401C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFFD2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dslt4gla";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RzfK8pdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFFD2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NhGNxGN4KjDxo31we/FLG1sqTjO+9OOQnxE8oHiiBIc=; b=dslt4gla6vhlUI
	vuqmSu+HOm3OU9XVuuwWbl5cSAWDtJMFYAidW0pF0/ceWftP2QYywHrA6OOHpcy2XcREpBVJwg2D8
	lVZrOT5ASeEdt/y7Z2eVSMmzqLrjM76kHIxUHQ+04/FgDKRw84QZyzXLUm56QsH0hm1+VYZtIFWgd
	CVX9j/iWwVOTYWe5xReECJ97+wg093GdVI0urWt+upmXYVAKpfP4P3zHrD+xhHnM33IZoKQTV9vBC
	4pGi9zXF8Tr+dm354+T2HuwLZJAbtKdvFQJC4yCSGL17aSapZBJPAeb0m22xy3OXKZxt4m+/sdKXJ
	Ri71lGU6NTcUtc9nQe3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULZ9-0006XR-KA; Wed, 05 Dec 2018 01:01:27 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULZ5-0006WF-TZ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:01:25 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so8196575pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=VJ4Xggx/M5TuF1a8xLngAs7VDg7Kg/bcesHAhVDONtY=;
 b=RzfK8pdFyLksbusmB8e3SXki8e8zPkdYAZia4U+Tfeln+wY1bkAbPX4QFzku5ofR0Z
 LRAeQft8ftzAr+g0BBTfKC2aWvMEk9rXQU/AYN9hwdmvi9R7rkggzbslm5r7fJzn5WKM
 4T/iz9GtYAkwZY3iFlD3lgTgmkv+4RbZzRPfugFpSXAmsvtp5DW8t04rYfE5SECxCua6
 z3DldOYh4Y3mZgcUQDboEHQu7sXT0BwfCjk8M4frTt/A4/8Gjiy5j9SwA7A/VsnfVZSH
 Yzu5eMgUlqXbYXPc/jy6Er3rBV1nBNTE+AyuqJFRsOeDpwKNPOedbeVKxpoeAdoYcwyb
 5zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=VJ4Xggx/M5TuF1a8xLngAs7VDg7Kg/bcesHAhVDONtY=;
 b=FNRaJ/DITMakyAWD60JO27U6BuqjIa2G49P06h2ACf0nwfzxM89l/OOaezgWPzJclS
 Y6puh2vJrMJigSFy8lqxG1wj7vt72C7Vi5FfZq4AaidLinwukXkAgTfrEVyNjU1lIktV
 zfQ3VwRoe/jvB4R5TgwawVrxx91R9NE3igNxrVbuqebuilg/fyJZFFSEkuzx8Af2ttHu
 Kn1hLrJCpqka1R5/GyaVSv+bZa1MY2c0QbWX0BZuCSiPYExySGuX/TL7ECFnCKROj/Q5
 pMjZEBmeBXtbKTcU65TKLy7h/ezj8I9e9j+VKuekeDrcVGCbN+8boUgkmXZVuxUShsxH
 suCg==
X-Gm-Message-State: AA+aEWaDC0gYVwD0bbxwChPHYhW3HPuHLeOTnKam2A2JvqHjwXvjy7zc
 n6l/Lu4Bl0LxqjOJknpq9AfY0g==
X-Google-Smtp-Source: AFSGD/XucL5NZBkNTnqI9hosWyuzrKRTkweZcEuw0ajmO8GnUu/pgA/O0jxAl3OIKVAVP93NXQy9/w==
X-Received: by 2002:a63:f658:: with SMTP id u24mr18745008pgj.267.1543971672921; 
 Tue, 04 Dec 2018 17:01:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 e128sm25594123pfe.67.2018.12.04.17.01.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 17:01:12 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move 'amlogic,
 meson-gx-ao-secure' binding to its own file
In-Reply-To: <20181203213223.16986-14-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-14-robh@kernel.org>
Date: Tue, 04 Dec 2018 17:01:11 -0800
Message-ID: <7hr2ewbxd4.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_170124_019333_D5E79359 
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> It is best practice to have 1 binding per file, so board level bindings
> should be separate for various misc SoC bindings.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
>  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
>  2 files changed, 28 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt

Acked-by: Kevin Hilman <khilman@baylibre.com>

But this isn't really related to the schema series is it?  If you
prefer, I can just queue this one separately via my tree.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
