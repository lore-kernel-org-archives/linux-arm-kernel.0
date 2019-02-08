Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B130C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:11:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DD821B25
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmpJFlYJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWCuRQU7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MkTQf5pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DD821B25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=to5oim8Zj5/VBddl02YbSjd5vXZx3cj+HIT3aI/wzPg=; b=GmpJFlYJp3bCpp
	frKwaySxzrYJGnf9cdpeCfTPR9SsgSCDdr+HxiH1Xmcd+Z1j9+taS48fHpZaDrYTZtlMDUjkjgP8x
	Pry/ua09LMtmtOrybGxKv2xcHBbHuudYUhmhxhKe7cF2CLKPj2v8tO7cYU50j91yqc7WByi4lsU0M
	SL7453/hVxwZ70NAXCzTXjKqxw1/ucgY5B0NhuHeF/OwlBY++1GvMP7i8EFB0ue8ByJBGh/4s1ClB
	BfGhbg/S89hp46iX5lxYBGDPk6ACrBNZEAl5ld6d+ngFIiG9jvmOfPgFp+saXKTHOtS6bb6UQkLlX
	m6/DQ8oL2c/Z36F0QULg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAbt-0005OO-Cu; Fri, 08 Feb 2019 18:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAbr-0005OI-QJ
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 18:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8qlp/xAnLxAOjV4wYTNej8P4AqA27Ps7vMX0JSJoLng=; b=qWCuRQU7GEl0nlKEp/ZTttCjT
 DlNRe65QY6+YrB6woJgeAgRI+bkdpqi9Tqh9aTtpQS6a2WwPOJq+wu//MbUZCeEqCBonuiT2S1mAG
 0eLPhVuOtRNl7lcM6gBhUTgTmIS5RZhSGo8+UFcd/MjlOALDOkTdjqt3L0GLZ260RD6n9OxurIXBG
 Xbi6NRq4ELTud8jIahp1poyfUbf9EYExuHod4Q+vs9P9fv1qOmp6m8yD2A+r77S1SyzYBLdIODljA
 JB6UnVzGFbHthERSdQ0qbxn47QfvCaRXyRuN0DXxQl0mdZMzmJqFdy1rMJq3NqKNWkhdaS2230GHD
 o4FjHREhg==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAB4-0006BY-0a
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:43:03 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so1978210pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=8qlp/xAnLxAOjV4wYTNej8P4AqA27Ps7vMX0JSJoLng=;
 b=MkTQf5pY+FM2kNGLWUDj92xIebBxnlOjXVjgquZYYNsfaX3ahhiBc48k/QjE0oorjR
 +Qhx/V3+sTFwZwhEjrpwvGCPIcWnFVo+/SdNOB5wlUUURsfdSDPoW4SGHvQHGuuqTX34
 xYEGFFk2wSYsTdF6uwwHx9OAsZFo04c7O5nd6pdQUlO0FxXM7K9nFYOWhlWO8PtlrVDr
 +nM0lyIWIHYEza751xg34Ud2fGbssXO9Yh9p9PAr4xw2PEDa1FQRJ8sSGhAm2zyencT2
 QLEy8IjGtzFrobWfD3EVdGCUtEJCFejSjCzjG29Ulkv+6uNSp8Z91vjaA3lr6TNrN3Px
 olDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=8qlp/xAnLxAOjV4wYTNej8P4AqA27Ps7vMX0JSJoLng=;
 b=Mb8unSmAE8ehGAoAl2E4bRkGXL4x8+lSFG45z/rm2Qy3P8BnS9e/UJtQdaTDHGurty
 /WoRawTnwtC1ILgMa/rdc9Nr2qj95SqNsTz62IVRcZjgjtjTAm2e1reFXSUkco5CK0mY
 7BHdEzaMFX2s6aDR6ZJvv5wNC5D5V69z+GwRVlIgRnJQ5ju+wKAQMc/koaxZVshVFloQ
 TXYQsBS/nGrz6J6gRaU7Ftm6co84GDpLPlkP44iNicAYajzHgAt/VU+PfbQkMUq1a4zD
 PBV8EGYxrfHFAxG0Qe6/ZSjc3zdBadOuayDAWrj/LpnDv2wS5jw2d1slkZR5rGHapbTz
 2LgA==
X-Gm-Message-State: AHQUAuaHoOca5yg6vnxh82uCk9dNX2BCWf02bULwSfsazxfMaypDbEHR
 HyCau2sTaxuglsu+Q22oe1SoGg==
X-Google-Smtp-Source: AHgI3IbEMM+ggW03aYshu3UHusVMXPCZA+pNgaJy2Yeg2QaRHGd5A6XRwRSkf3NZE4Uho3P5QdJsxA==
X-Received: by 2002:a62:ca48:: with SMTP id n69mr17099411pfg.162.1549647778039; 
 Fri, 08 Feb 2019 09:42:58 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:551b:c3ab:6b62:8b9f])
 by smtp.googlemail.com with ESMTPSA id b26sm3844333pfe.91.2019.02.08.09.42.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 09:42:57 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: g12a: add peripheral clock
 controller
In-Reply-To: <20190208101405.25699-3-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com>
 <20190208101405.25699-3-jbrunet@baylibre.com>
Date: Fri, 08 Feb 2019 09:42:56 -0800
Message-ID: <7hh8defa73.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_124302_063226_14F08D8E 
X-CRM114-Status: UNSURE (   7.06  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the peripheral clock controller to the g12a SoC DT
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1 (branch: v5.1/dt64)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
