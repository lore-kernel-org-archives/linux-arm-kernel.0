Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23FEC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:50:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B33820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGZdmpgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B33820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rJlWVRplhgBgQhni7XBUUSHThz3hiPanLm91id8rP+4=; b=IGZdmpgZ4LRXXW
	+acCmy1qNNwEI6OuSpWbjNJ2Kzxn8FbF6qIpNxeoD/A9VYNE0dl60WcrTgB6+Ys3TmbqzzgEWPMrM
	ub4LizBChkamZ01Hu5tbn/Cz6oKWTdUOn2xjvSXzxKtYA3bIZlE0BVqBBR+3rZA0H5E0/6Fqg1SfR
	g1R0WT5iJxkf6qGeXXeu9iYaOU6m5XuPukxCsEt9Bx1Gcc1Umt8Bboh62h/HxOPe3XIz7yshdAly3
	bxctWgl3F68jijoqLuTAYpGqdLaxa6WRYjj2pPQrdac8mYBlHjyhy/ArCCtTAEgDksuXZAoLD85I1
	p8lws9bBa2sw9FI1yo0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxkU-0002nI-Et; Wed, 30 Jan 2019 21:50:22 +0000
Received: from mail-qk1-f173.google.com ([209.85.222.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxkR-0002mv-Vu
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:50:21 +0000
Received: by mail-qk1-f173.google.com with SMTP id g125so720016qke.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8xAfwCkiwxNUSlsW0GXRq8FEqtxfonaVVOHs6SF3oNg=;
 b=OVK3fQTa6+pTk1wr+yh+0EDXoMSa6fNVzusV9P8+Eodhe3HGPb1WH+LpBlOmuv9jd8
 rEzZYzhBRHyzdBHvx0tdxRRC82oggWd8Lknd/yXQK5w2RWO1mZ3sAZdHeXqvgRzUeKpv
 vsfA/qjf6Sbf8tl1//i0KMRNIndbiHp4xLGG8dZt7pCJn826idAJ7iy7/jkBAxqccGCI
 vxSLgccaRI4q1HaXBKwZ3H9e0yX91Qrn7v2RbtIpDB28V2NGY9lYgdzOP+cC89emOd3t
 QkR5VxRixy2mS8wMtCjbpCveosi8SpL1KQMVtaCjaw41MVN7NkBSkvR0beEznxTVv9rQ
 JGXg==
X-Gm-Message-State: AJcUukef/ahDgEAjTzHzPL1IBRJO5Kt9okbYzBNpTl8Uc1dywau3bZJH
 /YE/xf0kPam5UE3BAZHAVYRQEgImkmmAJTY3iOM=
X-Google-Smtp-Source: ALg8bN6WT/dc64fV2nbkWxLzkti4fQN1hp22RRYhoz9ZRcj9AN/x2wedY5e48yVre4uDigGAwKS//dcx9bhUdw/shNM=
X-Received: by 2002:a37:9a89:: with SMTP id
 c131mr29378017qke.173.1548885018505; 
 Wed, 30 Jan 2019 13:50:18 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZ-WSqRmL=J2LCEoU4dz1DrOTUwbF9tutVZaovEbat+qw@mail.gmail.com>
 <CACRpkdbG8FomArY-jC1WQeR0zmaDY9qiw+YwVcUrvsxUR-3J2Q@mail.gmail.com>
In-Reply-To: <CACRpkdbG8FomArY-jC1WQeR0zmaDY9qiw+YwVcUrvsxUR-3J2Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:50:02 +0100
Message-ID: <CAK8P3a3pozUQhcz+HO+vKKq7oZCwy+Pw9vKenUP5Gg0Ak-sT2g@mail.gmail.com>
Subject: Re: [GIT PULL] Nomadik defconfig update for v5.1
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_135020_034782_BE1567F6 
X-CRM114-Status: UNSURE (   9.30  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 1:32 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Did this get dropped or postponed?

I only looked at it now, but did not apply it then. Generally speaking, I'd
like to see actual configuration changes separated out from just moving
options around or removing old lines in the defconfig. Could you redo this
one?

In particular, looking at the changes, the ones that are not explained
and not obvious are:

+CONFIG_CMA=y

-# CONFIG_INPUT_MOUSEDEV is not set

-# CONFIG_MMC_BLOCK_BOUNCE is not set

-CONFIG_DEBUG_GPIO=y

-# CONFIG_BLK_DEV_BSG is not set

-# CONFIG_CRYPTO_ANSI_CPRNG is not set

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
