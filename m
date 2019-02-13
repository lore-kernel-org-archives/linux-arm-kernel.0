Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF0C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:11:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242352147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqlLsWft";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3AwXGVw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HPPT7vjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242352147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kBy2HQHc51ojK1Nxpm9GPD051zuHItwJxCm7C/pWXZ0=; b=iqlLsWftXX4AyA
	eYUOH98L59MKRx5xeljOIYOXtRCeOfhrZEyu95+S7CQh3/oe3HeMPlJPrGpUJhF9GJpoIxjGtIo20
	CGH/2XhKO5rK9KPxcFUxxs+jg0hI0f2F1l4CWTJ4bxjoNgeDtQX5m6nXqWt8AxcrS6VzTUtapzh/F
	3E8EQQD41otAy9GYBuZRKrH14VrNLxhvhwTQKSGvczlV4PeUkjDuebjnRVG30QswFr0LAPvx633AV
	uTt1/+rJuwa9UDdhtLgTLEuhnzTNc09QTeHbqanR/twVs/7qmYPHIYaXLJ28bFAmETq4IMng1c3Pj
	DQ6fklrHWFc5gO9ABiQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrVR-0007zl-1J; Wed, 13 Feb 2019 10:11:05 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrV9-0007b0-Ba
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 10:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1XQZ/VjQrY+aMh72K1PfMUQ0MhDPMW3XRCQoy/ywj6w=; b=k3AwXGVwMkzE7hzykyXa+tEvRM
 fEDfRYdlMPoZXxpGFQDNHGe/yNsNbLNVhNEBMk0+KmWIR04y2uvfBqoxnqz577GHsi/or4f71Ld/Y
 3f1IHyjdafJZ7FOkqgJfc5ZT7QdkWeNXhk54vAqZ6J9sGzzDIjoJS0g0JwVnTtneF6SNIjqOM4rhr
 uZ59Ku0MDGjU342JL/SFAmzk+nvGo8YPqaBI8c+NAHyJS1dlXMgHJKsb74Fg+hX85h+lXlZhRgwWO
 4rveS/2Y0J5QzxxCsRxY97xHNtua11FTecmaFPOVsKri8oOpv3/e5xpZ6/dkD5DAFqEJ8MeNL7ggU
 ZydVCmCg==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqPS-0003o5-6E
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:00:51 +0000
Received: by mail-wm1-x343.google.com with SMTP id j125so1504773wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1XQZ/VjQrY+aMh72K1PfMUQ0MhDPMW3XRCQoy/ywj6w=;
 b=HPPT7vjlAZNLk7wzhfQiccsS+JSi6P7zFmUNOHdhtqjQJ1x5pDVnMV3Lnc2LDcjUK+
 nbckdcSiMcyncdw7w5e+5oR1F9HtNiMu0jskwOcvkLpJHAgpKshE+s5ixDPbZHAjntLM
 7EnL4UyDy98NvKY5N+6HeXxgJoynAZa8wGnO4jv2SNspm2txWGF4+sMt1YWDRq6GuSVs
 lAlguytEEe0+FtqeQIDDxY41kbKrd3hr6cY1LglP48/k/rT3bFMOBDKhPSLk74BvRr1E
 VUXlYVGi3jqc+xnfPV6JbrhT7EFABemdOEzL6/t70GEwWPS3sj4YgH4AJSIWnX4eB026
 k8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1XQZ/VjQrY+aMh72K1PfMUQ0MhDPMW3XRCQoy/ywj6w=;
 b=l0BXlrxRLjeYiIaExay04cHOXEm+6g+HgshMh7K81RlOKEbB7Ll81mCljz2niDpD/t
 FNdmseYRWihzMMmtXXY5Bq32ojMpcMCJUkgSKK9qgl8sBtAitjo9a1CxGsY4giyHXHSY
 Ms1bGe6tEF2QCle5TgGmyuGhyZmIJUCdckU4g6o4/T7tjUs5dmvg01CCnIB/A9Mpo98j
 iNf6BO24mVDXvjgYBen4b1EOG4SGOiVkk9uDWZAjY2W4PY/n5bEnVURG0RjlhlMDbw6y
 6gH2wWlvystyc0MnExZRWF4+hdnwQiCXBG487A07K7AESNR7DexlynNoOVLHDqq41jCu
 5iVw==
X-Gm-Message-State: AHQUAuaVsVnmH8qtZbO+swveT38L3ci5Y0Kv+q/5Ms8WFKu3Cfw5TQHR
 TEkc/dvxIjL4AzAHFFqyIVWdKg==
X-Google-Smtp-Source: AHgI3IbweqEWGRXZarmGba97uYiVkSqWwP3h1Pv1bws2Vc5SbdZlYVupOOXOWhlRJEEojW6kgZrmJw==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr2604180wmj.100.1550048448141; 
 Wed, 13 Feb 2019 01:00:48 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id b14sm27320448wrx.36.2019.02.13.01.00.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 01:00:47 -0800 (PST)
Subject: Re: [RESEND PATCH v2 0/2] clk: meson8b: fix typo "ABP" -> "APB"
To: Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20190210222603.6404-1-martin.blumenstingl@googlemail.com>
 <fc50a3a7f1efc8d2f6054a944848897ed8baf536.camel@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <de075384-8a64-b77f-6ae1-5fe174998d18@baylibre.com>
Date: Wed, 13 Feb 2019 10:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fc50a3a7f1efc8d2f6054a944848897ed8baf536.camel@baylibre.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_040050_280378_2BAEDC13 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: sboyd@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/02/2019 09:40, Jerome Brunet wrote:
> On Sun, 2019-02-10 at 23:26 +0100, Martin Blumenstingl wrote:
>> It turns out that I'm not good at spelling "APB". Unfortunately an ABP
>> (instead of APB) typo snug into two clocks in v5.0.
>>
>> Currently there are no users of that clock yet, so fix it now
>> before it's too late (meaning before it's used by <something>).
>>
>> I decided to go the "normal" route where we can have separate
>> branches for the dt-bindings and the drivers in the clk-meson
>> repo. This means:
>> - new (typo-free) clock #define
>> - change the clock controller to use the new #define
>> - (next development cycle) drop the old #define
>>
>> resend - changes since v2 at [1]:
>> - include the device-tree maintainers / mailing list
>>
>> Changes since v1 at [0]:
>> - split into a dt-bindings and clock controller driver patch
>>
>>
>> [0] https://patchwork.kernel.org/cover/10742001/
>> [1] https://patchwork.kernel.org/cover/10772199/
>>
>>
>> Martin Blumenstingl (2):
>>   dt-bindings: clock: meson8b: add APB clock definition
>>   clk: meson: meson8b: fix the naming of the APB clocks
>>
>>  drivers/clk/meson/meson8b.c              | 26 ++++++++++++------------
>>  drivers/clk/meson/meson8b.h              |  2 +-
>>  include/dt-bindings/clock/meson8b-clkc.h |  1 +
>>  3 files changed, 15 insertions(+), 14 deletions(-)
>>
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Applied to next/drivers for Linux 5.1-rc1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
