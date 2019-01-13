Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 05:12:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DDD2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 05:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5yywBrC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpIL+yjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DDD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZVPbKDReIKml5CXDUF7Zw68s3CQUKSrXR8bqnw/UJV8=; b=U5yywBrCAFkl9d
	LMuH6Dl94WcMwINXTJ/tiiYV6wcB9SBeMgoxIdt9bP+UgM1dfaPQis2W6LNO5iG43Vqql2bNg4xES
	RKsCb3+JinM45qx+/Z0q0eKlUjitj2/iQDL2Mweaml2g0JstprCyeaiZizTidQoGKOfGb+lCtqGGF
	SyGddK9KE0P09kVuSBZoz1jRamUOBJkGqA5Wmai8QVPVoCVeJSJAXT/f0yVB4dP/Uj/4G8YRneb0I
	nzAGWsovTON1qb7sulPWfFEtvrPKKVvW9xkfJtHSjtLMmgdV3WxITHMgk0ETitvpEGXS8+CDa3+FP
	NEOFpHfXMFdXvO7+APzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giY4A-00037z-AG; Sun, 13 Jan 2019 05:12:10 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giY46-00037c-8w; Sun, 13 Jan 2019 05:12:08 +0000
Received: by mail-oi1-x244.google.com with SMTP id y1so15408642oie.12;
 Sat, 12 Jan 2019 21:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:in-reply-to:references:mime-version:content-transfer-encoding
 :autocrypt:subject:to:cc:from:message-id;
 bh=T+yLIJ4zF+KVhxL5Waqss53ifeYQXkMIORoTJnVoX4s=;
 b=GpIL+yjVkPQmgzNV0dnOzokJo/vEZmvvuGZO/ZVHYZyAIaiDVVVq3E82TyWlsYfTv+
 tchLmmHcEgtuRrxmPsrZbHrQAW0aERGVKibMB6ylPSpROyO4AErYqduP1t83IB7By/BM
 m29/zEYAolRht4mlFiQxj3LvhVXegUZNdI9VygQr9CegilV/NnYmJ3DVChUI0DIn8cbj
 uTfCB1v9d/TLKAW9yWrCcuIn6Uy+sYNP/clUO0vWUA8Xop8S49FZ+b9GzZpEQ+8Fabnb
 IzoTGg9jZJLcH83dzDzyecAxHyg7tnkZ9WXUMdfldXClLLLj3asfJbgzMQyw28649i5x
 gOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:references:mime-version
 :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
 bh=T+yLIJ4zF+KVhxL5Waqss53ifeYQXkMIORoTJnVoX4s=;
 b=Ahm60gI3P9JPvSx5ugrFpCKOiQOspDJZRyV/XjM1WgjQwIsZxrkOFLbRXsKHt53OMQ
 g12hjcO3RuJE+uarFtrz7Bi2cpdUdb5FfFml6Re/DyOeWbmvOPmdczWOLkSJgV1TZ4sb
 pRP/p4ReL73SeOMGfCEDmQ0CkxWFgiFZDTzZIh7xs61Jaq547x92DQc8XGkByzFp6CGw
 c4J1PLhGVR7Nr8T9ItM2PuvuHQhA4uKuMjMcgDO5/E0Rd++vPP/GBGWBsS71rWS2pe8J
 3Oh6RFA8RMgGay+ABGKUfiYyKFnI53nXMHYFHMGEyYCWLh5xKwYbipa266n89kDMkIcY
 4ogA==
X-Gm-Message-State: AJcUukfbIY3e38TXTcePFeNyStOUzU1wXt9qxUyLjemKv0XC4aZA2OFk
 1uubAS0Bzj3TfKHdIA4g8Uc=
X-Google-Smtp-Source: ALg8bN6txq5E/U6AdNLn39Zef0heBQfjQL2Nnr1v1BzakC0hYFjUCegjjya8Bbb+0Iw+NGYdP5SHzw==
X-Received: by 2002:aca:2ecf:: with SMTP id
 u198mr13420527oiu.338.1547356323189; 
 Sat, 12 Jan 2019 21:12:03 -0800 (PST)
Received: from localhost (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id g138sm79302230oib.26.2019.01.12.21.12.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 21:12:02 -0800 (PST)
Date: Sat, 12 Jan 2019 21:11:56 -0800
In-Reply-To: <20190113002255.15310-1-timotej.lazar@araneo.si>
References: <20190113002255.15310-1-timotej.lazar@araneo.si>
MIME-Version: 1.0
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
Subject: Re: [PATCH net] net: phy: meson-gxl: Use the genphy_soft_reset
 callback
To: Timotej Lazar <timotej.lazar@araneo.si>,
 "David S. Miller" <davem@davemloft.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <024ED7A3-A9D3-433C-BDB8-1F85301300F3@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_211206_612224_424B0A35 
X-CRM114-Status: UNSURE (   4.70  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On January 12, 2019 4:22:55 PM PST, Timotej Lazar <timotej.lazar@araneo.si> wrote:
>Since the referenced commit, Ethernet fails to come up at boot on the
>board meson-gxl-s905x-libretech-cc. Fix this by re-enabling the
>genphy_soft_reset callback for the Amlogic Meson GXL PHY driver.
>
>Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
>Signed-off-by: Timotej Lazar <timotej.lazar@araneo.si>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
