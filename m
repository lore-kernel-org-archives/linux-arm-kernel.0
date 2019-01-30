Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088AEC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B226C2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uhe8AFWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B226C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MAEvkY4ZMn+irP6A75fDXxDmFuQJ07x9FKVLWF/PNa8=; b=Uhe8AFWV9NRQcC
	mOoXedE1Q5S+c6bX90YGAATqV9ReyObwaKrWWfR28FWkEtE3C1pPzBU/ycSwyx+hlf4jgADyHfALq
	osQBk7VHYQmaJm//sk8uNSzF24Sb8LOWYMTCLoeVrsHp3lVmEjqrHB4tNLBbbY9YETmoPV0R1HAR1
	+emtiMB756ziDbTUhzfANXUj5JbfOKWBbNDooL/nqVOQjPiCB05v5mvWrSxOBduYhwXDDOK1vlupj
	H1ujFHxOUDJLxgBhq0fBnWBQ5zD2CfxNNb1BLylsx7D9Xezv0I4GYz+U6O9TXsCd+kfTnY9Yln1Y4
	BzgqSP2A5czjLPQPJoLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gos6o-0003NF-Av; Wed, 30 Jan 2019 15:49:02 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gos6i-0003Je-Nh; Wed, 30 Jan 2019 15:48:58 +0000
Received: by mail-oi1-f196.google.com with SMTP id y23so19588965oia.4;
 Wed, 30 Jan 2019 07:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TIvFbso9rnJrc5OUL5DT5uU7me/DauI6rCgSdMwHq74=;
 b=HcwbhHRUKoZRcp3pXCaW5kdEcAwlloQlWmEg5NWmCsFP68u7qkwm29XemJDAvVDvIq
 nS0F6lOQlkwuPd96mMc5st8D9xL4DQjfVMuuyGGHCG2Rdeaz78NKIVo8AyLuPdRwN6kL
 IwVyXdpw3qLbAjdqogKZQaShTa6AvDtNQClitO4F8B2TNmlh8bFyaw/ZJ/4EGZp2auek
 2AE5XkiRk+TEx05XGVOYrwH/zKnrN+UuV0rxOBhbfGPXrkbumwT8yiC/4VfwCyfgVsVb
 JL2iKshgBzIiBob/rem+X1bPiYNuECM8zwerI6tDY46/BSrTiFbxkBM2f5Zd7xdfs4mB
 wKqA==
X-Gm-Message-State: AJcUukcqcNjg4fedefPmrV+Olcyx6yT/vv4uFYs2Pxnw43ZB9KA+1vva
 Q9Lf8xnlnaYcj9nuk1u9jQ==
X-Google-Smtp-Source: ALg8bN6BdpW1svsWz+hMd4KSbH83B5V9J2pCHmbjB3JwtmmpCQKlFv75L8YHhL0y+4eyWKqfb3sSUg==
X-Received: by 2002:aca:2ecf:: with SMTP id
 u198mr13048124oiu.338.1548863333031; 
 Wed, 30 Jan 2019 07:48:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g138sm831598oib.26.2019.01.30.07.48.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 07:48:52 -0800 (PST)
Date: Wed, 30 Jan 2019 09:48:51 -0600
From: Rob Herring <robh@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Message-ID: <20190130154851.GA25794@bogus>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_074856_770448_1CC1AABA 
X-CRM114-Status: GOOD (  11.05  )
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
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 17:37:58 +0100, Loys Ollivier wrote:
> Add globaltop vendor definition.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v3: No changes
> 
> v2: Alphabetical order
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
