Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA17CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:15:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FCA2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DTBNdkcl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f/XbIiUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FCA2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5tyQDUIRIMkkpYBZv+nWy+yUz7N0lFCUmT15e+wda0U=; b=DTBNdkclKM8DKm
	EYSxXLLGMdBBugcvXHxlMCvW6cMit1sew2Q0SK0/JvPJ7N0jsHS5PLEOpRDIt4OtmsdAdMA4g88wi
	SzejDhRBgSvVxV3KI11GfDKssZp3C4OGNBlSKGw/F6XbwxxXPaFu9EjIrN0uIgzMpSaj94pED1YXW
	bz+dro6TaaoDFLSYA269KLnQATxW1P1ioe2KIy6iRxIC+3B55j0BXm43wknl646hS5TzDFa0ecZtk
	comwzgnF4xQ/RFr2mvx/rpviOS9Aw9Mu+yqSKcojDvW4TF71n7vuPzBeJBtxwsvEnX9IE3SQ4Xp69
	UGNMJfFgNG+Rip70rWHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghkTf-00081l-Fq; Fri, 11 Jan 2019 00:15:11 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghkTc-0007jZ-LB
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 00:15:10 +0000
Received: by mail-pg1-x542.google.com with SMTP id c25so5522090pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=lrRYkQOX8oabBI7evmXJhlETKhOiCG5tJ57nJBVZseI=;
 b=f/XbIiUg+sKbMwHVCYO1u5rTsudsHeZsgVXAtIuG8QXpvvdyWs1xIDFJIEgnr7cq27
 vPbOApd2jwWdwhMSW6K53xmOkKq85kwxm5VCzRIRRxAKWM+ZvbHx8G9Uv/YvA7HTxuCK
 qRrv6fJCITronI4nz8ipRMrXhCi8E1WXqczyqZHC8B5fggZZphKkiMwt2FAauHQ/jYCE
 n2jrMeljN05Z0/GL3zQfiexo75lPpbvH39zNeAMBDv8bqE2MH0tSAIIKvriy0Rg/lOxN
 UwQkCj61ACmlHSwWoJ2lnkQeDhXaOq2DHlIsIerp5NDpqa+MhQuC4qLWd1J+Jp6L+zVw
 HGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=lrRYkQOX8oabBI7evmXJhlETKhOiCG5tJ57nJBVZseI=;
 b=eI++7uSI/ayM6a8wpH6naYA0E3fD6jRwOg8KAMDitDr4y2fEUW09UKoVEhNeukIhls
 3OGcTbIVxUQC7RBcl77LWX9O5bffUM8WgkPlsLFZdLNx0LgReA4D1rkVWmhP1PFtAik8
 6nSE5mI2B7K8rkjvngb9v1UURST9SJEaU9TLBqnG6DJD9oryPAdEhKQI1QxUHqT0GrzD
 IsHQwY08Dnh8UKJ1B7pLYCCSepG6Oe6xzHdZ0ZSYr5UVpRLkWnhH5kpCfRkZgged8wKR
 me4+8b1A5mVrHZq4sJms531RIUvG/WYXYDkfyTriMznWfrPWmMX5feb+GgF04XVsrxy/
 Yksw==
X-Gm-Message-State: AJcUukeJB7eLmgyMxTxMCrnrVBiSUYif+0Ib6AXhtaixNx+pe198t50+
 O/9DkZzL7IA83s0yUbICYIfAKw==
X-Google-Smtp-Source: ALg8bN53KR6/M8+Mt+5jqUyjitraKHDVbewmPsYnLuVNvTwlPDbyhBscf+tOeAMebs9YqWXTlpBzZg==
X-Received: by 2002:a63:9809:: with SMTP id q9mr11371259pgd.109.1547165708097; 
 Thu, 10 Jan 2019 16:15:08 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id i5sm19828838pfg.34.2019.01.10.16.15.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 16:15:07 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound
 card
In-Reply-To: <6770759de6ed04ecabaa163eb550769d43dfc901.camel@baylibre.com>
References: <20180828122735.28919-1-jbrunet@baylibre.com>
 <7hmusmvw6z.fsf@baylibre.com>
 <6770759de6ed04ecabaa163eb550769d43dfc901.camel@baylibre.com>
Date: Thu, 10 Jan 2019 16:15:06 -0800
Message-ID: <7htvigqcc5.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_161508_702876_93A802B3 
X-CRM114-Status: GOOD (  14.62  )
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

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Wed, 2018-09-12 at 21:49 -0700, Kevin Hilman wrote:
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>> 
>> > Compile the necessary drivers as modules, including codecs, for the
>> > s400 sound card.
>> > 
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> 
>> Applied to v4.20/defconfig.
>
> Hi Kevin,
>
> This patch was supposed to be merged for v4.20 but I'm still not seing it in
> the 5.0-rc1
>
> Could you tell me if there is a problem with it ?

No problem with the patch, just a problem with the maintainer.  Not sure
how/why this one slipped through the cracks.

Thanks for the ping, just sent a request to have it merge for v5.0-rc.

Kevin


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
