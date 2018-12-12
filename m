Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25957C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96DF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fmvytwGZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="q4yKF9vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96DF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=weBo/RrTiSpnZGQcwIyxmT9pASC6MZXcOwCeJhV4AGo=; b=fmvytwGZE/M7qm
	WldX/JLwV9/x2RIkSD/8NsMNkNgCwzGJX5pkDuSSxr8WvAxT+QPoLzQ4EMqhdmoHblXOJEHlx4w0x
	hrGDqhUVX7XhdPgJyM8shHPd1MkiTyn2iG7xzsHGaiup1YyqaWzflY3FrMqs7m/arSppdfU5LqzTK
	HMbBdBEDDt9MNy1w6bGcmfityOA1cU+kcKnvySAiR3HFP6/acL5vYgHvkqSTqyxHcMB+EaDl7mXvC
	JooHXJ1ti7dgF30pizkpKdTco+EdYU8/EB5KbE4IxyAmkj4d2D956Fp9HAJUS5RYXnhoSsrA3t/se
	Gomt0B6Zm1kS8FFnyicA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWvbu-00046y-7l; Wed, 12 Dec 2018 03:54:58 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWvbq-00045s-OB
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 03:54:56 +0000
Received: by mail-qk1-x741.google.com with SMTP id q1so9961364qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 19:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=om3HVc6pjUbCI7961bkoT5XS78zOdIdclaAUd3I6+vU=;
 b=q4yKF9vqDdGLcNOB7/JfXVNMWNLwPVQOD6406S+mDgQ/6whX3j5sjNkkkpeez4EYMs
 AbIw7IegfWXqomtyg1OPdRsVpXx36NVhA3u+8DfNhCNzZBKCSt/KMh5Ig0cJwl8UgiT6
 Gskiu1ZkNHjFJXc0zpVCtXxXUolF4sF5MsQtgdkQpUIjOS3Pd+7XfOcPGNPG+JUEL9Ja
 n6qiWG6EsgdohJ1Iq4zvHqxp5rSkp7C13mS3TOS6cvFQt2Fa/e7zmIbMXL9qAQLR3OuG
 6nLoMDkxfMvpPis5rc1XT8gpcWpq+jeiPQTCS6EoZy3x2T9rnS20Dyl0FL8tGiBsPAxd
 Y7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=om3HVc6pjUbCI7961bkoT5XS78zOdIdclaAUd3I6+vU=;
 b=ra/C2yyS5tH2t2CEzCr6csW5gWTafntv/dIQdS55Ep5JBjPryy0TuFATVVNOR8NrNv
 vgDDUXr+s+z0FVlQrQy8CPORGNXgZYQO/ysr3IAxZr9JjO1XQieJ2kmKRNeIkqYgAES1
 CDpN5EQhQfsLkoGxGVPVmtNaQKRb+Lei8qLg3yleXA/w5zBzWtVgvj4rIw2cRGf5lH/7
 MaZhAy6dD3w0qpgdXqEBh6BfplDrWXuhmIQzs2s43LSwcesgbklXNgp+0vCmV7JCYRrb
 iZbPCcOJPQ4c8H230gaQlMfq4pdIEchskd4E5VEiC35QnocdOsBnRtb+vg1cGKO9F3t8
 sG7A==
X-Gm-Message-State: AA+aEWbv2CxAo5h0an2OxhDwmJKo8eEhxG2DxdxapRN31nKiC/xesXQT
 8ucBExwqGhSOjxfWlXLVOy5s8w==
X-Google-Smtp-Source: AFSGD/Xo4z31X9dF8RETJ+IsP3Eko+70mfc+SDRP4bzmb/KjU1ev5CFYLnFjKbqvYL+XLkiYG0MqHw==
X-Received: by 2002:a37:6155:: with SMTP id v82mr16360390qkb.72.1544586879679; 
 Tue, 11 Dec 2018 19:54:39 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id 195sm8762104qki.76.2018.12.11.19.54.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 19:54:39 -0800 (PST)
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To: Arnd Bergmann <arnd@arndb.de>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
 <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw>
 <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
 <1544566937.18411.9.camel@lca.pw>
 <CAK8P3a2T-DDfmpN_KcLB8cZKTszE4tohR8ChtktP3-du76hJog@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <9248f272-4b8f-183d-73eb-28fed1debcd2@lca.pw>
Date: Tue, 11 Dec 2018 22:54:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2T-DDfmpN_KcLB8cZKTszE4tohR8ChtktP3-du76hJog@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_195454_787043_A1A2810F 
X-CRM114-Status: GOOD (  15.39  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/11/18 6:06 PM, Arnd Bergmann wrote:
>> I am thinking about something it is probably best just waiting for those major
>> distors to complete upgrading to GCC9 or back-porting those stack reduction
>> patches first. Then, it is good time to tie up loose ends for those default
>> stack sizes in all combinations.
> 
> I was basically trying to make sure we don't forget it when it gets to that.

I added a reminder in my calendar to check the GCC9 adoption in Q2 FY19.

> 
> Another alternative would be to just disable KASAN_EXTRA now
> for gcc versions before 9, which essentially means for everyone,
> but then we get it back once a working version gets released. As
> I understand, this kasan option is actually fairly useless given its
> cost, so very few people would miss it.
> 
> On a related note, I think we have to turn off asan-stack entirely
> on all released clang versions. asan-stack in general is much more
> useful than the use-after-scope check, but we clang produces some
> very large stack frames with it and we probably can't even work
> around it with KASAN_THREAD_SHIFT=2 but would need even
> more than that otherwise.
> 
>          Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
