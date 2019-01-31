Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A867DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:11:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845CD2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="awfbiZoV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="koMMPUOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845CD2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fX/UA/C6fsD3Cry9HpghTIFd/YBTRcqDHbiGAdMvt3s=; b=awfbiZoV5MKzNseOxaBxn3tjT
	X4Yz8ShR+HQRj6gZ5DRIK+EIbrrHVPVpGGdM6rIJ6kJWS2Z5SBI1QdGLCW2pa8kncCaRQGik+3ilf
	AnmJXVJuL0pPLg+I74v5st1TL+06hbDBHcPn8Rjyf3iBoHY+rs6iEeQxQ4xXm7aj2IaXdM3aRAvJC
	Qxh5fk/zwtZwwRtPB96M6VH461Wf2nukO7m3DJRXhVUZ2FNwgnSgl0irhTObhAl5bZWHnHE29uvDE
	kbu4NVO/8IkF3qgrDQ2KoiLM9zHEMv9aNbOrwOQJU3nB1iTQ0hcvkdr3hKHVNraKfLwkGfTbAe46t
	UCP0bV4+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8Nn-0008ML-JK; Thu, 31 Jan 2019 09:11:39 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8M8-0005tu-B5
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:10:40 +0000
Received: by mail-wr1-x443.google.com with SMTP id z5so2338617wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p7g2oiiMuH9TCi0rtrHnCkxhA/O1w9HJBCPx/mBRROU=;
 b=koMMPUOPjakYYN8cqkDDEtvcwewqQugA2RTHF8bkoznj8SN2p6X9PE7VukZjtyLp1P
 78ENy+MQgd5r3cF06fBQ/NKDDIMJahr1ThnqVWIuqZY4pzcI1m/g7xffyx4kUB44DdDG
 y/9lLUgJM4U5Aaqsdp2GRX6ui8l7aLHfAS8oMgsCCzp0qf1elirCPtuehshI1HzZ4N/u
 c1LnEmQqhP+INU0wEm1amBbRSyPb1ZY4j869B954iaarOoFoFNI/5G4YK+5yWBcSKcvX
 nIJDq5lInEPisvyuCVJ/4gY4xhNLWCXs6pWVmKZOkGv6azJy3Y/9tPd7vmbIZbP4IuVU
 SVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p7g2oiiMuH9TCi0rtrHnCkxhA/O1w9HJBCPx/mBRROU=;
 b=rYQKdcXdFl6SjfsL+AumeFiM3lRvODCGPilr7FnvuTEGabYw+Z6g1FUPsJPtKyh3pB
 Liu9InLulT7Mz7DJ5YeV+RoV6QcqePGjd7nhVmqcmS7wq96PBy72yma9YpsUGwicA2Sm
 J1tIGmUoxW8K6nHXSy4u3Rv/f+AdllFlptrAWuy9N/D9JCsdd+Fx3nbGyqZexneT5xKD
 g2cBz7ndjsi6y2Cwzg6iksPsqOAOFVsISXuFdmr4fG0GzcPZ5DSqdct6Isc4Lo6hB7Nd
 ShulpefOkFWwC5GUfvdnJkZWuJWllAz4OyM2E+nAx++S93lUE9r06R1Z5zBNrmUmM5lM
 HEFw==
X-Gm-Message-State: AJcUukeDZVB5PCYkYxvk1AaGk4iLivAiq23ia7EDJrCVQjElHBtPRaWa
 OSlF5m2RBB15vlEWFNtcGY1U5Q==
X-Google-Smtp-Source: ALg8bN5vJCMbiBxtTau90dYL84RIZwPTpRPWtnfA6tD/qhTWhOn4vtLiLhKyAIosqeLCR1KkewBgdg==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr36493053wru.154.1548925794574; 
 Thu, 31 Jan 2019 01:09:54 -0800 (PST)
Received: from ?IPv6:2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6?
 ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id l20sm9519547wrb.93.2019.01.31.01.09.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 01:09:53 -0800 (PST)
Subject: Re: [PATCH] clk: imx8mq: Add missing M4 clocks
To: Fabio Estevam <festevam@gmail.com>
References: <20190130201725.18961-1-ccaione@baylibre.com>
 <CAOMZO5AU8y1mf1DCMcJ6Y_AN_rP47jx1uVhj9pLRtgL6P70ksw@mail.gmail.com>
From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <0590fb7b-4934-9ef8-dce1-6fd251864522@baylibre.com>
Date: Thu, 31 Jan 2019 09:09:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5AU8y1mf1DCMcJ6Y_AN_rP47jx1uVhj9pLRtgL6P70ksw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_010956_583984_4D4EA71B 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30/01/2019 22:46, Fabio Estevam wrote:
> On Wed, Jan 30, 2019 at 6:17 PM Carlo Caione <ccaione@baylibre.com> wrote:
>>
>> The clocks list is missing the clocks for the the M4 core.
> 
> There is a repeated "the" in this phrase.

Ouch! Can I count on the maintainer to fix this while merging? ;)

Thanks,

--
Carlo Caione

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
