Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 02:17:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F4F20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 02:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u23hPJmq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nlbo2XAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F4F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o36rQeBaC8RbD56ROKJz1rlbRAiIAQXGEFq1rHrZP7o=; b=u23hPJmqUkECEm
	pBq9fcn5A4E+LXg06Bi8Vb3zZu+VpylKM48VOR3tTuiEiwjt1fGD4UNI/0Mw6XqxEr3wVKFdLBsaT
	QaQCXOnvLnl/LHwyt7LhUn8sHY9XumEPXlKxqzBpnEo9G+VhqJ4zZfukJiCrDUP9ZyirK2gBK+ko8
	zKHwnB/gzIc//BcOnVBuyBIK3r1Ct3X/yhcpGAx9MZiltXA/HcsnE+AD68cXTeu8x3oYAv7yK7/AX
	dIlkTHWO5KTnPHJQN/QiUH9iESkVOo6R4/we6jpYSMvxwFWp2p561VX1NH1t5mLAIsLcscwKUAd2z
	emaL7aCGas6e9I3GBa7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsICn-00025d-DD; Sat, 09 Feb 2019 02:17:21 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsICk-00025K-D3
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 02:17:20 +0000
Received: by mail-qk1-x734.google.com with SMTP id m9so3339657qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 18:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WI9FXIZHc0w7+/QjGej42lgyR+YrOy8EMvOhQbjH4Qs=;
 b=nlbo2XAFTfoNs5KyXR6TfbWtLUMHX6Hcu9RdVsycwVo5Jt/5wVuisHShw3vrIaAYQ5
 MiI+ty1L3SW4EryEGA/qDERwsR4yiEMRHLz3SfHTq9gE7B011fRAcGk2NKQsngydq2Ky
 +ygWeR4DtqtvENbKOOIQKm0Q9E3/eSaF2KHwmOpyIiV5vuagFhgY9O0lmMEoDFAieZzz
 Y9+mYj55vCzvHvk2cnGAbW7XG2TetlsJEEluH47ey33Wv/NGS/ZBS3urPuaJmHEeHOxr
 l6h7GDhPgttMgFmXY14ADgV/MMwmpMtGeR/6BYMuYQCgPSsBZKI7ZNW4nSClzGK3Mk0x
 2ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WI9FXIZHc0w7+/QjGej42lgyR+YrOy8EMvOhQbjH4Qs=;
 b=ZyGeh4PjTw2/NP2oQ/dWZQvp6PrV5KUUofZlCoTVelTgDpCwf+LAlxUBbdAObOSipK
 U+O/d03XL4hhm/OMY+C07vTPlHfPG9HyvDm7aNSZ9jiOAgNapBD8QnAxr7j7tv+8giIt
 e5Dqls+7uoz9RpK3nO8qjCvYSdc7sZrktF6GumYIs6u3I1vqjuRrSmg4JvXUqktA35Y4
 kzuhEkc4rXjvHB4IXuVsbA0v5ZBCTbjdAv0UNeL/q/cLQG8tg5zJ7uHrx5WD20Wz1JYG
 v2ClrHd3lNke3HHSoBDfelhhl2xmh53nYXNZiDC9VPBnmo2MemApjv04IhUfz4Pr5Ok/
 kE+w==
X-Gm-Message-State: AHQUAuaJirRRD+wHIVTsnVDg8retx4oROomGrCyzA7azXu6TxsPhmZWz
 d6kAzTLlkaxjMSp6xmjrrObpTw==
X-Google-Smtp-Source: AHgI3IbRu/Eb7OCV5IafR8R9EUYmOuKWbynRlLse1KB3hhqvHvj9Vwuo4KDPGGCru6HK/FygXbaHKg==
X-Received: by 2002:a37:a546:: with SMTP id o67mr7348379qke.42.1549678636100; 
 Fri, 08 Feb 2019 18:17:16 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id w123sm9658999qkw.80.2019.02.08.18.17.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 18:17:15 -0800 (PST)
Subject: Re: CONFIG_KASAN_SW_TAGS=y not play well with kmemleak
To: Andrey Konovalov <andreyknvl@google.com>
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
 <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
 <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
 <d8cdc634-0f7d-446e-805a-c5d54e84323a@lca.pw>
 <59db8d6b-4224-2ec9-09de-909c4338b67a@lca.pw>
 <CAAeHK+wsULxYXnGJnQXx9HjZMiU-5jb5ZKC+TuGQihc9L386Xg@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <cb64bf1f-9291-23f6-75bc-baae844d057c@lca.pw>
Date: Fri, 8 Feb 2019 21:17:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wsULxYXnGJnQXx9HjZMiU-5jb5ZKC+TuGQihc9L386Xg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_181718_496937_2F219810 
X-CRM114-Status: GOOD (  10.87  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/8/19 12:15 PM, Andrey Konovalov wrote:
> Yeah, the issue is that kmemleak performs a bunch of pointer
> comparisons that break when pointers are tagged. Try the attached
> patch, it should fix the issue. I don't like the way this patch does
> it though, I'll see if I can come up with something better.

The patch works great!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
