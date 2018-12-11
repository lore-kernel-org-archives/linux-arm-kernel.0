Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678FC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:42:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC25F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qHD/qh7Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DbZQIeBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC25F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cm08XSIhvblornjMyLlNIJQ5+QRDD8L7+WiBBUsfNkM=; b=qHD/qh7Y4oOq6F
	fmdm7Dts2hiAZsv8qWan+ezO0joWRUuj0HMHx81LHXgX4upRe/Ky6bnGfFkysCW3+nUm9BHXst45i
	H7DVwusKIedz22jh+1Ok/FpB6uL5c4lDRs7uu0YFYhBNVabTvTfx+zomFe09vB9kaYSnSDDfqfaB+
	pfLyLp2pZAmAGTvQjqxzwL/dvRn0JLF6Wze2BNm1+ODORFAvCYlgT27+aL1cc3wftFmPbk/3sWKKQ
	zjPnDqSeGlKj2iGMnZvTwtVpIEcpgZGN40DFSI+9kNq/oURt/eaximYGK4NjDeyjSVSq4syUFBUrp
	BcWYKVSDIOuyYvLeAKGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWpms-0006eY-1C; Tue, 11 Dec 2018 21:41:54 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWpmc-0006LK-Ah
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:41:43 +0000
Received: by mail-pg1-x544.google.com with SMTP id 80so7262686pge.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=wLmfRRpGm8OQwzZMpIjCWXzWNSEb0sSFR83YS20A7ZU=;
 b=DbZQIeBI4bKM/Eqg5O8yvEv/qlQidA73+LIb5KiqyaFvU3k4eUvOf1ulljmvquESph
 zaSQapj6dvFTIeF3w96X1j2y6hO0lNCQZp5JdTkv6JoBqEHzeOZKqiMRUUk2hwGtUBlE
 6oOllnl1wqyYAr+mAWO/ehPo8xJu1Je6Z5mrE2Q6k0pfAR8sjGb1598/CM+2ZnEDYcPp
 ikukw1u1UZUHP9r0GZ9sGHr8iTVxMlk2OdP/M5YpNhm5BxBjc7fRLHvWhIZ6WLA+WmVz
 vPle+/qB8CY6qYBFsbz5uSzcrwqHZ/8g3bzK1HwFQ3/IPR/9S87CoVk+KD5uW+d5/hKY
 Eryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=wLmfRRpGm8OQwzZMpIjCWXzWNSEb0sSFR83YS20A7ZU=;
 b=j5ZIOav3E3xhpn0RH4D7ALJ4XaDlqDgmQW7rtvGrF8qsnq9esQOX0OcAnz1eYg1m1X
 T0LIqPFEXGZiEh/9zKuU3SBFzemueRCXPMAj97iI/25KHF6ijmOhDd/DQpxMlULSwcYv
 19V09L52FYmDuKc8/Olb+YOdZkMrfqStWsItQ4LRpgHdQs6N090TA5XhY05nC631hTo6
 eJ+GHMHPa+/518H5mcRImziczZCPa71yzXRP8zIO1WNxvSPsg/G+NnnbwgYt38Y/Y1s1
 lNdgY3e8hJeVBjavSe2rxWGf21YYzJSD6On52lQO8+f/z3tTPk8YYYNfLpLJ2xUtgWb8
 3qIw==
X-Gm-Message-State: AA+aEWZUcnmDz4cK1RxQF4GwlDfrzxnAFG27bAXxq0TbrcMH/K2WSh3o
 3gNwUJsts6Pwv5RyU5nhk2peTQ==
X-Google-Smtp-Source: AFSGD/X6fCwrJ1Kh7+GgtXBy0eyCgJgbd8l0hcVMS0AaBoLGN6q/G75KWd93FvwlDcct51dMiJniIg==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr16393089pgi.434.1544564486767; 
 Tue, 11 Dec 2018 13:41:26 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id d21sm17066002pgv.37.2018.12.11.13.41.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 13:41:25 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Wolfram Sang <wsa@the-dreams.de>, Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
In-Reply-To: <20181211203652.rogajl4ajwu7cs6f@ninjato>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
 <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
 <20181211203652.rogajl4ajwu7cs6f@ninjato>
Date: Tue, 11 Dec 2018 13:41:25 -0800
Message-ID: <7hsgz3u4fu.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_134139_285843_748F7183 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Hanjie Lin <hanjie.lin@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-i2c@vger.kernel.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

>> I am okay if it is reasonable below in file
>> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just uses
>> axg's compatible.
>> 
>> 			i2c0: i2c@1f000 {
>> 				compatible = "amlogic,meson-axg-i2c";
>
> Actually, you should have
>
> 	compatible = "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";
>
> in the DT to have support for future SoC specific additions. And then,
> patch 1 is needed.
>
> Or do you handle this differently? I'd think this is DT standard.

It's a DT standard *if* there are actual hardware differences.  In this
case, the IP block is identical, so there are no driver changes.

We prefer to add a new compatible if and when there are actual
driver/hardware changes.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
