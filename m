Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6C521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O2MG7vYI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeRg3YVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6C521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nnoKbe7vYT+Z6XqdTV3G04jzbP+3OlF6Pvg/NqNQhMY=; b=O2MG7vYIeFx8ys
	+wKcDPE/0Ft9p4emAztR4CwA3K4v+31vpnDkcdk0EBmfwEmkrVMIvpBub1t9haCPPHh4zmJa0Om/N
	7sS6tKC4zYQ4gK6jCd5G9KVGJqPTVUWFw3V851PEjImH7slcA0VHO2TsUxRvHlBs/9e1I8yYvB6BD
	QRg1jfzjJ9tvyFqcWJnxhAGda8eLmr5IekyNTQkqgsjUTKjtTvmQAKMIZVoH+zGvUAapR49+62caF
	RjQPCSqmDykBwTdt5NyQij4wuz3+A/3i26K8+PpKIzGVF2qKKN214s7H4LlljsEuj+pno/hOcPPOT
	7bEJSUvn/lhCMme4utcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8Gb-0004jm-5a; Tue, 19 Feb 2019 16:29:09 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8GY-0004jE-5X
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:29:07 +0000
Received: by mail-ed1-x543.google.com with SMTP id a2so17310075edi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eTIyXcANNF9vHPfm+eipaAYN5nRj6Ks336GiU+ADjVI=;
 b=OeRg3YVUxJ7IzgY9z/DIA7Dy5M8ZWx/YTqEmmWKt3eVtwvFJmjOCQ3P2UzT58CBcZN
 Hh5cahHgILLf7yQeTCRs0SDDcqGKX5cf+cOW7UXJgDjuCKVwYdH+Kaggy1ZWzP9XzsMl
 ACcyg9nYf/0PZlRUWtC2DQQs+rDpwYpvCejH764GGWfInox0sfeN2q3MSjS0L3EaNZEy
 xrf7hgKE75AYjvu8V0elwo8vqcEhbKeadgfp9UCKIMRxZaXfqsHizmUeVCyl/NrdFCmG
 pCXe5v4ktg9sPzOf0nrH9S1jVuEs5DhE8uksijG6pTvNEzSt9MRsUOk+wKbFAxVGO/Dl
 +uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eTIyXcANNF9vHPfm+eipaAYN5nRj6Ks336GiU+ADjVI=;
 b=QAmP32+SfRn1nyAW1YRyE/yZaL6x3eueoLnnKz4EZawzlDQgoNwd9hwUB0z4vsDWZc
 /GVP6dOcVB6Gplz9WzZ6G5KxxW6wWNxl1R+m8w+CyDmrOmJU0mz4xIQxdaobQ3mm761d
 tut8pvjWxAD28/L1Y5wrwAxhmmRfoLNMXLeHbFxeXjg3AshpnO8GHS4sX03S1e5urAnB
 F1mfmW8NQTElifFjewq07vk8vbMtR3E4TQcF6fN0CpqKC17CmRhXPDLzV6mxjAu4vJHm
 6wnBmNgnuqPIIGBQUFAWDqfjtbvquW78L62FVAWYjLitrxTgeSA0/LNpqkTglRJxi9lz
 oCJg==
X-Gm-Message-State: AHQUAubJaSe84DLGsypk5BMXCRBSadIyt7nAbwZCOSG2AB1Mqc3Shdq7
 9oJllAab848jMyQP2NfDtIcfLv7GkE7Z3v7FTnE=
X-Google-Smtp-Source: AHgI3IYOZRjfpkz3EsLDWUp7uicPN2zhoQ0WQy7Hc/jxy/V4J6Lkh3s31x4MUoG2yfxIzm5JKoDsE8Lu2p8HQI7hQzE=
X-Received: by 2002:a50:9b50:: with SMTP id a16mr23011268edj.135.1550593743766; 
 Tue, 19 Feb 2019 08:29:03 -0800 (PST)
MIME-Version: 1.0
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
 <8ad3211c5c6c6835997237af02df71eeb2c78c17.1550518128.git.mchehab+samsung@kernel.org>
In-Reply-To: <8ad3211c5c6c6835997237af02df71eeb2c78c17.1550518128.git.mchehab+samsung@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 Feb 2019 16:28:36 +0000
Message-ID: <CA+V-a8vCQ3grhE9xeen0vfs9O4LFR2t9fK+OcjkyOet9x=5FsA@mail.gmail.com>
Subject: Re: [PATCH 12/14] media: include: fix several typos
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_082906_227573_B6328035 
X-CRM114-Status: UNSURE (   9.95  )
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
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Pawel Osciak <pawel@osciak.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 LAK <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mauro,

On Mon, Feb 18, 2019 at 7:29 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Use codespell to fix lots of typos over frontends.
>
> Manually verified to avoid false-positives.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  include/media/davinci/dm355_ccdc.h         | 4 ++--
>  include/media/davinci/dm644x_ccdc.h        | 2 +-
For the above,

Reviewed-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
Prabhakar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
