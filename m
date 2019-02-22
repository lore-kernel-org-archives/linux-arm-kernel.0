Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:37:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1BA20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/QDSvmH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMbt4tXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1BA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OnnJjG/c1975B6PLeEDmT+KBz/6AlPa5oQRFbYThOqE=; b=X/QDSvmHqP92Gq
	NaXBpXG9qhlNlCUyB4dw01CX4EkPqRoc5qDRL0g4aqZXuUs7MdXPnU4P6lGFtQNZB1gfo22efjKZN
	pWy+GnOaRQOkIG4RODAr3tj/NNG9H2/vwyt95FJfuI86xgMV6Cm1uVYHkukVpehOOvkt8Y/deYx4q
	tCgmlrogdkXf5NvM8EfVparbpKziusvWqQpo/3HSTdl+jMa+4Jy4CT46xkrP69yoKPsTorbYzzTio
	ZODn58kD5VYb2pC2N9+Gchy8RmPF0Wf1zirzMBFYozAJteWEsSyHL+kDs5nUipaTPnsnqvIVwWvCT
	Iy13XmL2AXUmpZfwcW6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx8DI-0001ff-FZ; Fri, 22 Feb 2019 10:37:52 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx8DF-0001f9-35
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:37:50 +0000
Received: by mail-qt1-x843.google.com with SMTP id y4so1876017qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YDhY5QR6K3nu4I3i+LYpQivoVxRjW66bCBrH3hAXbSY=;
 b=YMbt4tXx98WwgpIsrFW5E/tBVFzLfN23zF6OqzV3cijgLxXYVLdz6BdF56YJYSCZpo
 oFmTN0qIxVBRg3zGBYB85J+qk8SPqF7hQBw9myB/8e6DxJBGPfJnh4Jxv8gGCeleiuPw
 kamUMhTRMYk+oC60S4RVZ5Y5pszN/Mz/MWyYx3kx1abxZtK36D0bb8wRY1VgwCv7Un3B
 A+RHSmy4kyChHF89c30TTUgjUBc2m5kZj9X8bLhiCJ17WglckfJhRjinDWtIMjiljsU4
 xqK2Hjdq2lyQLI9bMWZUw0BJaqGn9I1dFBvPn9wgJ9werm6lUdN8qbR8maJmDPNkwlo9
 SqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YDhY5QR6K3nu4I3i+LYpQivoVxRjW66bCBrH3hAXbSY=;
 b=ekyank6wprmwY3yU1Zeiw5uLFri/XoLTuFKNLLszfc4R9bSGZ1cQPrsoqVwgUO45tq
 142WNjromlxzz7bbqqh7QnhGLGtxr4HoNjkVYc5rCQf8sqwBBMFSGKSVm94lAWB9e7J7
 NZoCL4Mw1DA59GIJvVy9QDhBPVr0nA9mDlvDS+N9r/PEsphph8KEjt8ATX6sECysQIq8
 E20QwMpH895XKmwbG4ZyailZ8Dh3AWwiyZX/m/ijmpWBdrzOLsMeOJaw2nlnyMSVTMCu
 AWGSmzVxxlZnLGyxiFOO+kdEaBFUKVQBIY68FKEKVZ4apxAX2qE2DYMBp7NnA+s+lLIO
 KnKA==
X-Gm-Message-State: AHQUAubm95edDBCeVQZmotXdDjPdUV+ODmAK61SBBbUuvcsQ0Pk1vV7g
 2UmYjdKwO7C6XNs2ghs/sufVupnyUopIS1lKKegzpA==
X-Google-Smtp-Source: AHgI3IYtahtk9cn3d9ka1xW8Cqn1XfyT6ZblSvSzQKKf7BII53YsXkufwQOLXP5MW7VW0gknoqA1Dx/9UfxNtyNYfR0=
X-Received: by 2002:ac8:2de4:: with SMTP id q33mr2437439qta.358.1550831867914; 
 Fri, 22 Feb 2019 02:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20190221154458.23763-1-linus.walleij@linaro.org>
 <20190221154458.23763-27-linus.walleij@linaro.org>
 <CAL_JsqKxEu6AhqEXhXSMwSFcfd3oZ2pZMmT_wwZZvvX9e=jUDg@mail.gmail.com>
In-Reply-To: <CAL_JsqKxEu6AhqEXhXSMwSFcfd3oZ2pZMmT_wwZZvvX9e=jUDg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Feb 2019 11:37:35 +0100
Message-ID: <CACRpkdZ5Sm53AbWf1a3sL4bfrsgrkbxXwajO4c=ZQbH6w_BmEA@mail.gmail.com>
Subject: Re: [PATCH 26/30 v2] soc: ixp4xx: Add DT bindings for IXP4xx NPE
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_023749_135728_2380C90B 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 10:48 PM Rob Herring <robh@kernel.org> wrote:

> > +$id: "http://devicetree.org/schemas/firmware/intel-ixp4xx-network-processing-engine.yaml#"
>
> firmware? firmware/ is for things like psci, optee, etc. I'm not sure
> this fits as it has some sort of h/w interface. Wouldn't networking be
> a better fit?

You would think so, but the NPE, despite being named something
with "network" and primarily intended for that is also used for e.g.
crypto acceleration which is generic and can as well be used for
disk encryption. Intel names it a "hardware multi-threaded
processor engine".

Each unit has quite elaborate microcode and is clearly containing
its own CPU somekindof, it clearly has a Harvard architecture.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
