Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A203C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DD42081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BtFvr+HE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Qu15MWCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DD42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NIPgx9F1ZKVnrhjKakSou9ml1vgpiJpcwCTJDGWXEHo=; b=BtFvr+HE4T+uDf
	QIEKaIxVX2mD9Mul3FlglCoRSXLvRpV6rjIHcr0ZmvezM6hkQLwft32rO8YEQPPVH1Toy/0woFzZk
	sks+EPS2VMSAOaDUwYoWv+UWj0et2RP6AYeoxCIv4KMMrHmpQnllG088xLRPFiKHIgilzz8PnpWL9
	QnO6AnreiKpAhnV/WnCg7puLbUA7tLOhz6kbvOY8ZlKimNLgIPDhh/v9EIZgBNakPc7rGdbtsiPvi
	acqS1HX1Vr2caRpRgtCtXltSbbfMjY41ZA5rrGkfiDgf82wanVF3fiqQ25t4KhghJNO16DYLSlgCM
	KMtA7vtpVKzB+Q8rrCtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWAIz-0008M8-7k; Mon, 10 Dec 2018 01:24:17 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAIh-00086d-SD
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:24:01 +0000
Received: by mail-lj1-x244.google.com with SMTP id e5-v6so8111205lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RHa0CeDZa4MnxL+mDcM4DV4dx0mUePAC1CUp9vQiJWo=;
 b=Qu15MWCVgljld10HWaowMcADJHvpMJ7y8uNAqbkng8MWP2G/lS7vda0S/nTG3Fb6oD
 BPE2uoQX28CrDOWxl6WrFrI7+4Rnty2JQE6P2D88M4hSIN6tKYH5m6DpyrHPNpG/lDJ4
 S5ZQG5JtdKE265FASsP7HzqFd87YTIEHLtWux90cVrG5zcSVpNOoPZmU2sclbzYXMb/8
 I6LQUxpXNNCowk83pC5YPH/UEafVm1ANezRFYQpjOqxSLotvqhtjnSSC0Aila+rTSVoo
 oib7DAAk7oGgXRcO049isxxJill7Qh8XIZNMXI8bU7w4GMZhNsJvp6iRL39qNt7BNVLC
 2hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RHa0CeDZa4MnxL+mDcM4DV4dx0mUePAC1CUp9vQiJWo=;
 b=QcOhi2VKa6H51RBiyanAWKZgB0DBydKe/00y9JZ7PTPVFSTCdaA+mvxX730HrlMt+g
 ndPr7qn8wbdfGsCrMKrBiAKnVM/EyJb2ghHZU13wM4ZC79f7rU2vcKhXg5qQEgvFviYk
 2XdJ/oof7mks0Dhyo5uGamxnUOgd1j21kMP9uq2apA4krOTVgNMD75/H31Ef0LnJN+6D
 97uZ0qbmYVP8HIqBlqBNWwvOyq4uYutldIP/4HATCQIRdPeigSZbHPiKCKhdZdcCupbM
 BwXVncGzuM2RaJHbl1VAKW6kQYkNYuKrd/kbrfjMyUUf8oQt9G/Y9YYLwQb52Xmue+dU
 NPNA==
X-Gm-Message-State: AA+aEWYY9AsYpP+w42Z2O1L2bxdkxQIO0P+QmkZr8vBZdAunA95mIYgF
 nB/PtQRzwV3SVbiYsEEl9WT2SA==
X-Google-Smtp-Source: AFSGD/V1Co8XmeUD4qeQTIYaoYTosDZ1l10JjOf7ZbTeTNRNA/ruBDIh4jGqH4aKEc0VA989fnJnyA==
X-Received: by 2002:a2e:92ca:: with SMTP id
 k10-v6mr5797120ljh.63.1544405030070; 
 Sun, 09 Dec 2018 17:23:50 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d19-v6sm1868457ljc.37.2018.12.09.17.23.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 17:23:48 -0800 (PST)
Date: Sun, 9 Dec 2018 10:28:16 -0800
From: Olof Johansson <olof@lixom.net>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [GIT PULL] ARM: mvebu: fixes for v4.20 (#1)
Message-ID: <20181209182816.wpzzryhgrkzr5mcl@localhost>
References: <87efasv2cn.fsf@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87efasv2cn.fsf@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_172359_913598_7A07EE7E 
X-CRM114-Status: GOOD (  16.26  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 09:39:52AM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for fixes for mvebu for v4.20.
> 
> Gregory
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.20-1
> 
> for you to fetch changes up to dae522045094ebfa9a10cf7951a8f79b02da8e15:
> 
>   Revert "arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K" (2018-12-05 09:28:17 +0100)
> 
> ----------------------------------------------------------------
> mvebu fixes for 4.20
> 
> Adding CPU Idle state in the device tree for Armada 8040 seems to
> breaks boot on some board, so let's revert it waiting for a better
> solution.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
