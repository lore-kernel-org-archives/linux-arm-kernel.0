Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB5AC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:44:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4B32054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJ9PoM9L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOFWpiIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4B32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/7L0wyhgvUbJUxda2qyvGZIy7bDtNP0NrzjM/nI/YUk=; b=YJ9PoM9LBMyW9d
	srUh+3h1lcmzBhAYsC2USorSZHRs3+Uu0mCdmHoAiA0z62wtIdgXrphPV/7pEs+eCNd1g+xg0EOox
	8qp9KsvPtubxyXxbxGqzumwfDytfyYtOabW4uC1xQBDjeWUz2TN8AehcWHO2kq5EU6nMjpyf0Tgkc
	1Bq8n8JrrNfGMGrsAJsGuhX3jL5sNfYgIDFWStSLjnO0nzuE7v3Y/pBLDWAZs5VP9XcD71zrpqj5m
	jkTGIbKncHPq6vhJnQinfLm2vzVHagEzGUpUecd42PLidzMpbaYylP+4T4EjUpj+4q63ShWWPU892
	W2cfIcfiIoO+RxznNdlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjGf-00038X-1J; Tue, 11 Dec 2018 14:44:13 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjGb-000383-EF
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:44:11 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so2484964wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5ccD+kdiWAzAcykpu4sjBPhcau0AaOdROPYqfds/Quc=;
 b=GOFWpiIKXHP+83uXX1vAzmFBrqCAxCJ12ApA3we8z00dS40ZOeb1/XnSwOI4PkAPzz
 XQFkExE0m0TZKbLZaDRVSUzG2L9YTmcyTOktF8CS1rhbBTNTxPE0WhUKAEsYZCJ8l9Fm
 ppAEBKOsg+926MpbWimKQHZIl7dbCxj8DAhOMen0qU6S2HGT3Itdd7bhw1fipdKovgw6
 8+gUJWfi4kNGNhS/H9UBKsANrR/NoUvCwwZkf2SoyicmKthgbOPFITpH0EjOLBrE4/wk
 ZFqmnq06DCVxuqfoA+J0YEp//f2MZ0773zqjzpKY5feVCbF3G7FPzgMQ3q4G1Jp2ZowD
 cQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=5ccD+kdiWAzAcykpu4sjBPhcau0AaOdROPYqfds/Quc=;
 b=Y7T7HGJbRVq8hJhTT9wCLvcMWG4e0Y7o0HaufQjxRnhlKjCbc0mO//+TqLMQq2Nmnz
 P6H4cSFwnLW35RL25Ni6kKJWubyLTd5K7ipOE10GUcGWFM/NH6BMhz0vFC2B0vOqMftp
 EIQkWm4BJszZZtGusghugYsLIRypaxlzmt7PEpbh8vf/uJWYNmV/ZW3iserTx2jj6uJO
 Y1P9BGU1EjR0dQp5YL0/x6CoMJK8g5hjPiJiGlHgtV+UqYxFHstCtvGvisNtmh7qsbop
 V8j9cbwSquoOr6TghYmOz2tzmZO2BlyAj2eqhMW/U7m901ZO7YKgIfbcAbMcmUH48HYH
 4qHw==
X-Gm-Message-State: AA+aEWYIoB2OoSIqBffHkQ8JNBplCWc2Au36iJgVooZhaGIq441VkO1a
 6tSptiVtNof2Xqs05frVDOk=
X-Google-Smtp-Source: AFSGD/UXOD3G/2J3Aj2DwB1aVKzTqgDZPWsqPkr3xbbFvWoFmWs64S6/GjtdFggBfxb9zyZbYU3TBA==
X-Received: by 2002:a1c:1550:: with SMTP id 77mr2754688wmv.100.1544539437747; 
 Tue, 11 Dec 2018 06:43:57 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id l3sm15355508wru.36.2018.12.11.06.43.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 06:43:57 -0800 (PST)
Date: Tue, 11 Dec 2018 15:43:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files
 with double quotes
Message-ID: <20181211144354.GA89489@gmail.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_064409_502466_12701F17 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Ulf Magnusson <ulfalizer@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kbuild@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
> 
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
> 
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
> 
> Make it treewide consistent now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks for doing all this Kconfig language work!

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
