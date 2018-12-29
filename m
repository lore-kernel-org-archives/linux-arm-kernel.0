Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3242087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jsBBEDrG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="rD8OjdYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3242087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ncentric.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3znynMyvEV44KmtuvusiWN/H0IuQbaLgcpTY8ZK10OM=; b=jsBBEDrGxYm0P65Lqqc+aU7Ay
	oJiQrFCg4hWzn1CfGwOHgZ704Dt9rp18Z6xzs8oSghj41dZZb8cusyJy46lRGecT9NYlHVIflMwoT
	zYCQy78e0O2d2+xY2kJ41AoF6sfRgxlDKp3wJ7tzZBLi3Gi43S+zHX7eTYcm0l45SMKehkJWkYZwA
	TGo0kh3524YikbLYZVi0G/Hn2iLFXU/7s027g1Q6h65veSajXzwaizltArtelclMVHzfmLXbEqqKm
	W4MUKUnuHq/XJPxfIwH2Q+wkMSrHNu4G77vsey55MA53JKIqlg5ygBDmQeKEcVv7P8EOph51/hUU6
	LyVkaTIFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdFn6-0005kj-BY; Sat, 29 Dec 2018 14:40:40 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdFn1-0005hq-Nz
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 14:40:37 +0000
Received: by mail-ed1-x536.google.com with SMTP id y56so19506675edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 29 Dec 2018 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncentric-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ala7Rt+LtVEx78kWCeECbFD9AI3coVtu3/jNlxNQQpE=;
 b=rD8OjdYQs5380Ca7Mc3w/SygyhOJlUYKSnzhaplR00tR2mjAaKpAdRq4jsa2DsKG/u
 GONjGNud9j2f8XrXoEis/3M8Mel4hz4jla8woG8QC7fYYBYAWYRfXcu+yFHozY9ImEEC
 sBuMezuoS6gKrlyBQGuYgpfPKP4BpeNVNVdpLhDSTrMIbJa70wg8PDM8LaOgEUod4iEp
 BULxcZfJtay3YW5fRwCWcENuWTsrH5NDl05Pd0R93pzwrmzTHfMDOPjK/mOiPEhjs9O4
 hLLm8+4/jI+dGgizBv/B8vs93cabvpDNjcwV0xDdai8XfXSwgrAbG7lLqtgEmsfyJfji
 MYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ala7Rt+LtVEx78kWCeECbFD9AI3coVtu3/jNlxNQQpE=;
 b=DabISKOUtcuHjFHh+FH7zeqSfsNr3WUjG+z2XbWaeCoNOtFHZctd0K9ZAlleXjdeEy
 6Ol5qpIctUebcrJzep7DM6L3OybFGKgWVG1XSxU9FFNUV5l0AV3zoSEAfhyejKnHk30Z
 Fu6YAlhL3ICBjsPLd1K7J7gaftwzEOzLFzHhmfuj1T15DZKGwTbgni2gnriFrdtcExws
 iQrfjHcDyIR8Y8LkslkYV/LZ3UvZwpdVQ7Da49PdHmWaq+4xThz+99L6jeL0qX/x1JpH
 GPNVERfdv++Q9VQWyazLWkuIsGG540Sj7Nt/y/kZbAEQHWTSRJdfsQB7RddsuF+SVVN3
 03jA==
X-Gm-Message-State: AA+aEWb/DUEh9sj95BLlNN4lXEPbTOUUC0lynF/g0c0A9FElFzP8SO26
 ovf0lGUgAxJI1SsSPFXHaIcR3g==
X-Google-Smtp-Source: AFSGD/VDpti7qZmfnWNe+0qisv4CrHZgEtP7gklFZD3QdwGyQRUlwx3w5LoGrPJ7czt06GKsA50rGw==
X-Received: by 2002:a50:a982:: with SMTP id n2mr25498535edc.236.1546094414727; 
 Sat, 29 Dec 2018 06:40:14 -0800 (PST)
Received: from [192.168.5.254] (178-116-164-128.access.telenet.be.
 [178.116.164.128])
 by smtp.gmail.com with ESMTPSA id w31sm15438303edw.82.2018.12.29.06.40.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 06:40:14 -0800 (PST)
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
To: linux-arm-kernel@lists.infradead.org
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <73cf6822-1657-f3bd-6a86-fd9474693dcc@ncentric.com>
Date: Sat, 29 Dec 2018 15:40:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_064036_243554_769C4284 
X-CRM114-Status: GOOD (  11.82  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Robin Leblon <robin.leblon@ncentric.com>,
 Olof Johansson <olof@lixom.net>, Krzysztof Halasa <khalasa@piap.pl>,
 Bjorn Helgaas <bhelgaas@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Friendly ping :)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
