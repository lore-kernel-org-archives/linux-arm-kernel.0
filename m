Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46273C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:48:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1523B2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRfi/PWx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R8tCoaNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1523B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=20jBCAlluIR+gXbfvF/G+peQVwq4ZEuDzF8GIVtTE6w=; b=mRfi/PWxnq4XB8
	0bVUKVTMqrx1rsk7tNBhpXF3v60+wNLwvLo134wAZyDd/+R6ySpqmsxMZ7cQP+oQRVHgXKRvNvH9C
	x061160ATaTz/ZEIbMGDwcWqMqmFI7NkG6VgTsgUkZJoKFR5LE0rc+3R0195XpyJ9t98fryI7dgvV
	9VZkYM2Cjti0rs7VCQPjIjv7zWv16c5dQedvWSAz5XppaFyJ+rOJ2JXFYMErL5wQzW1ZY7zFUVeLY
	o5S7VYVqsf6XIyxiK89QyiZTVPZKGRWw71oDAhkYUEV8GZdoWqwNbNpzHLVt6dNG4PnoJvtQVJrWY
	ft2C2tVB82YMdJdRGrfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFWA-00061n-Uh; Thu, 31 Jan 2019 16:48:46 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFW5-0005zf-2Z
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:48:44 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so4059333wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=w6FVcV3nFK2dlvJ3W01cGC+s0mLeqhU73MKDw/PbrDQ=;
 b=R8tCoaNaEqJlGEUK2sMKEwXnw1Hp/uxgb/2CCh/dMgM7L0JfarUyS1359PnhrXwRzp
 1PsxPbRlcXbf4A8rtg0KKo5HzptkKPn50q3ferNNX5doGsWlQFcSD1RJ7UNjNRbDoHJb
 C/wfKML90yShH8ToUFsWlTWgi97XGqsZ3TgUzxJNJgLlBHmS3hu/xwwHs1SHfN1ory8Z
 V6Jq73YbdF0LCU9xYwREXb9c6O6jZQOTCV+ytw6Ls4TrOgc+8JSKv30A69iPZNlwBdHG
 58SbaF6J7FK5GOEfrAoolBOOlkzhgUu2GESQLugDYb33hbGN48EdFgjvGPGUBdtl213+
 PXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=w6FVcV3nFK2dlvJ3W01cGC+s0mLeqhU73MKDw/PbrDQ=;
 b=k4ukyNOEX3Ugy3kiiQL3cprZOYJo8ntbNuqq1Tyfbt+5bhkjbCm847xyaSNGbSgEMh
 0WgID2UmFdxEqs0gYKMT1mPNd5JBv1JKK3msSbdY2X3OOqCd8uKu678foHIWZQIOtJlh
 sPQgvf87nMD6CqNGjn6z4mEy2Fyo9696gU/JFoFJ8jweGWkYIojQ/dsqTY47tF2mJfEO
 dhEIjq83GVSJqUJ5ouprifec9E+ymTwMfJpBrXwcPVpd+YJfCGb6cB5W8SiKMsf8bA+V
 P1iYWmMeOMr1/kJfTaf16K6ZjnWDdkHFi1FKIb1LrbsP2ESAEteJbwzgSf4IPS/dT397
 BKMA==
X-Gm-Message-State: AJcUukcEo/5Y6rdJqM615bwu1+m66amy8T+ur0F/PQpQ0zwQFo9CiUBW
 d2CFGjFNE5JK8cdYcCG/CXhVLQ==
X-Google-Smtp-Source: ALg8bN5KZu9Unk/gMbjGpk2J3Tm9U+D5nyRtA8d/1on2RpmNFFcpzoGzVFEzamN1x3cmga3WWEvxhQ==
X-Received: by 2002:adf:d243:: with SMTP id o3mr36351558wri.66.1548953319074; 
 Thu, 31 Jan 2019 08:48:39 -0800 (PST)
Received: from localhost (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr.
 [90.86.125.223])
 by smtp.googlemail.com with ESMTPSA id g188sm6229880wmf.32.2019.01.31.08.48.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 08:48:38 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: add g12a x96 max board
In-Reply-To: <4d1ae3a6-874a-f032-a873-a715a67a3992@baylibre.com>
References: <20181219233519.35287-1-khilman@baylibre.com>
 <20181219233519.35287-2-khilman@baylibre.com>
 <4d1ae3a6-874a-f032-a873-a715a67a3992@baylibre.com>
Date: Thu, 31 Jan 2019 17:48:37 +0100
Message-ID: <7h36p8hixm.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084841_114637_288BDCCA 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Kevin,
>
> On 20/12/2018 00:35, Kevin Hilman wrote:
>> Add the G12a (S905X2) based X96 Max board[1].
>> 
>> There is no branding for the manufacturer anywhere on the product, so it
>> took some digging to find the manufacturer.  But since there's nothing
>> about the maker on the product I've left it out of the DT name because
>> 1) nobody will know that name and 2) keeps the DT filename shorter.
>> 
>> [1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
>
> Just found out you forgot to update the Makefile !!

D'oh, fixing for v3.

Kevin


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
