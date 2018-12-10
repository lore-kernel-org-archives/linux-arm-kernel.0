Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B81C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:36:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD9F204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="axfA5NtU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OnL2ALyU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IEROJNbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD9F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=udC1BveSNNR0J+Rb39uZUsah/LQDKhfVm7wqwdVrz5E=; b=axfA5NtUsa+7o7
	AkoYUN+AL1MaGBq566EuwZzAnUMPVGVGlyEBnFvh8UTKa8wxG3JUCffgQkawlii/FuJcl27QFFuQQ
	J6v8uKu4xkNKq9RRGcWSVD1HV48O9OilcMGKtxnF+G84naQS2QK2vzc1tpoSKm02NMuUcdzZEi2vx
	JMtsUbDRpCd7F4Sh5xyW+TaMXofWwoP9zFKhNJaTGjSO9hAXDSNJ1SEtfxQUHaSb9/gaQn7mlEmWZ
	dtAg+RNg9OaH8QGFj12ThmiF88qt9dLYlowIq89lIXXjHoanMWrZf2+eiSnKi0CfOrIIzjffP4gdB
	/EH0ndlbqeRjhL3aZi+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOXK-0008MN-HA; Mon, 10 Dec 2018 16:36:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOWK-0005Qq-0a
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:35:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CXX+95DKqqnT35MwxNl8T/REB4ekxPgFR8Dewad1Jxk=; b=OnL2ALyUDFru4Fhh2brFXL2HX
 PUa/L+EHUlw5gZgp5YBw9GqJy8chUjjrXTWwCyYWwF6hdsxvlZ0W3i9OmTSHgCNHWvM/BD4mVc/cL
 TjRxy2ti7EJzI9AEXTvlyfJ7Hj9gHPNqwY4V2uUuNVaX3Yj0191/QH/eHlRWQbU8TcPtb+q+khmJI
 BFz6HwuQrp+VeXcAZJd1QmDDwdOYGTCS8mHWJo1nJJlfA4wV9vXbZeJPFa8RBj+VIQK8ilWFzQFyv
 HGaq96doQDE1EUxogX4AFfgbQ6ANdIrpoYnBkOVScwRezDHbBo7N69onSEsNHoABu7VimIN/df8mt
 sC/XqSFbg==;
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORg-0007tZ-0V
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:30:18 +0000
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id wBAGTJiQ017392
 for <linux-arm-kernel@lists.infradead.org>; Tue, 11 Dec 2018 01:29:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wBAGTJiQ017392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544459360;
 bh=CXX+95DKqqnT35MwxNl8T/REB4ekxPgFR8Dewad1Jxk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IEROJNbvlbn+wKqcKRc/YtSU/ceGhayJiJE0ujHrenxXEVThQlaU8eWFwnnt8DtIH
 7yeSRGsXu+Gv0vieDzBzJC91NN6CeaC3VQMtAuo1KnYONYhL/4p76j08paFpr72JYz
 E/zNdJ/knkTx22MvcxlO/r7SunUhW154Bf0Y8SoOj1cwd5+TLB0zS4TGReiGpjiZCl
 KnrFsddRs9ybiwIqiobEYhC6WXR4z8lk+h4v0HzE4yPgrwfb1TXiaCFHYRJOEySRH6
 jqmPMHGhI57xd6h8V5iRQzWISQ1ZcxJZDEwI1kqX7cHAbK8mVtXJssgIxSyX3Hjf5c
 Gya+IOdmoFrmQ==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id t8so4043766uap.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:29:19 -0800 (PST)
X-Gm-Message-State: AA+aEWaK5GMHFkLlQcd2SD5GKC9d0s0eW3eAidFkneK9hSdqPfI9Oh7K
 SpKVB2Vlsup4eMGrj7F9vOGwyz8hcfTAwbvH0eE=
X-Google-Smtp-Source: AFSGD/WNvgAjt0ApjwrM/hg2NEMhZD1oqIWVLdax0+xuN6WvgybiVf08Ub1knt/oTFxuNskny5su0vVNZJcAfRTe+iY=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr5711166uap.6.1544459358492;
 Mon, 10 Dec 2018 08:29:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAToKE7dv8UHOhQhJN+6Q6qVs=noQvLedGCEQszSgmVvXg@mail.gmail.com>
In-Reply-To: <CAK7LNASah-5o_sAUw=DDwfKhY=rYXZ1dmeX+d_HhKNMGqKLLAQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 11 Dec 2018 01:28:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASV9cSq9xk-PuDi3TzhjAP8KQmMz+XJdz2HW98Uf48rsw@mail.gmail.com>
Message-ID: <CAK7LNASV9cSq9xk-PuDi3TzhjAP8KQmMz+XJdz2HW98Uf48rsw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.21
To: arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_163012_588227_3556B0C7 
X-CRM114-Status: GOOD (  11.57  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 1:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd, Olof,
>
> Please pull UniPhier DT updates for the v4.20 MW.
>
> In this cycle, I queued up all arm/arm64 changes
> into a single branch to avoid build errors.
>
> Thanks!


Sorry, please discard this.

Looks like I accidentally hit the send-button
before finishing it.




-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
