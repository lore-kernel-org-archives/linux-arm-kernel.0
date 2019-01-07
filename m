Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC85206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nlmGXIHC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ErKD6PQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC85206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6M0ZhtlDtjSvEfsuiQG5qLfOJ84mdMkyyuWxto6NbE=; b=nlmGXIHCml1KyO
	PxGoBE+Pr4ejMYQ1fEtBLwmtfd2qY02OEE2S4iRggKonqAKqcptKdhi4TktVbXIwL2LSCpt5S8Kmf
	3sfmZzhqIQHVmWYuCcviUzO1aytc5WDoYV3XshTU0nUlo4KuxTaQlLbbHnPOPOHJ3cZplAUBKgeqZ
	XzoXJJQTpUGp6h/Y4UvPLPHoEd9gKhWREfAjg6bMgnngm1Fw79IzMtxpt+2Bbk21L9WGWMLvrGSIw
	ThrGiy1y1wUFNQxVwVJMYNc/a6FrDUfMzUEeQqIvhOATAt0P/h8nsbwxhxvPFOOUWgcC0OEoMKVjT
	ijADR61Fkfq9KFQTl6pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggVWv-0006fI-2e; Mon, 07 Jan 2019 14:05:25 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggVWr-0006eR-QS
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 14:05:24 +0000
Received: by mail-ed1-x542.google.com with SMTP id o10so946870edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 06:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=W/2RBvXjOJQ952z/CyP4hTtFtFtTcbe06r2ruHrpECU=;
 b=ErKD6PQzmDOuMMgrMYYAyad8DrMFH6BJXeK9KQJzAcRiMc3fu4CWfdKgKytETlkK+c
 puMOTrf4qIWSjHqElJEdYkuUeixb+JC5tzmMLUdRwLIzRaCwHXwx6uvWwAuKTNdZadMr
 ifcZ2aAKAw0vdjlXqT5XY4MC2p0cbZSHPu5GSisEvYuVwbCKZS+Jicu+BG5UfwCzzECf
 PeYGDAs0NLeXCn6CGO9JANyupBE4+CevxjbqCAm7XoMXIGsQOVtpkqVmUA1Dj9yLZSy1
 xdItU8y8VUyB49qpFWXDgbVIbqqy3tYEr7p4YS5m/tJTAbv09gOyN9yUjATz0sBfqZoJ
 yTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=W/2RBvXjOJQ952z/CyP4hTtFtFtTcbe06r2ruHrpECU=;
 b=sLWIwsJq6eMywUN0tSC3IPgGQz+NYBEHfjDtLZDMG7IjN/nYdVGvnzPK9m/N1R3Uuj
 YxRpBR9Vo6oVXVtVKWWCSzENdhEH81bHOEICiLHy8J02Th2VnQrLGkvoWHxtBRl75Nlz
 AI+Nu4T48k+n79wt+1EACLux6KZOLC1L581RNx7cdBwHxTZFRiBPVuFvCBR7Di5yY6tl
 TxPbhdM4EvTbz02IYt9EkH3rMZDq1ZL1ZCYluhVqJABhdT3Dllx3ovuSNaeAzk18Adfs
 UAuleFahuels3QkHe7SyheglpBsutTJJMtCKJTwS6m7XVOkNw80KV56jmAHjw6E++6RU
 ZUkg==
X-Gm-Message-State: AJcUuke4ecz4XRNSs0TfiK2P0G42qwQkO0YufFOUuu8ilVjOS9en1jaF
 tResUUP4qHthVFu/pKt4t9E46g==
X-Google-Smtp-Source: ALg8bN5z1IL+BHXTtVhNiCTkWGW8dsqCGok3DpycWh3r1VE1WmepCdiThSjEeTkTu0iH5CkWiUgpEw==
X-Received: by 2002:a50:8ad9:: with SMTP id k25mr11054301edk.189.1546869919451; 
 Mon, 07 Jan 2019 06:05:19 -0800 (PST)
Received: from boomer.baylibre.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id a38sm35436997edd.44.2019.01.07.06.05.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 06:05:18 -0800 (PST)
Message-ID: <6770759de6ed04ecabaa163eb550769d43dfc901.camel@baylibre.com>
Subject: Re: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound
 card
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 07 Jan 2019 15:05:17 +0100
In-Reply-To: <7hmusmvw6z.fsf@baylibre.com>
References: <20180828122735.28919-1-jbrunet@baylibre.com>
 <7hmusmvw6z.fsf@baylibre.com>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_060521_935101_7FB6BA24 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2018-09-12 at 21:49 -0700, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
> > Compile the necessary drivers as modules, including codecs, for the
> > s400 sound card.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> Applied to v4.20/defconfig.

Hi Kevin,

This patch was supposed to be merged for v4.20 but I'm still not seing it in
the 5.0-rc1

Could you tell me if there is a problem with it ?

Cheers
Jerome

> 
> Thanks,
> 
> Kevin



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
