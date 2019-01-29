Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576BC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:16:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679E3214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UjA5mXGN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmH1jqxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679E3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=twyytKVG8myAUs4duAGNK5TcrNnMb9JsVzATvlHE5RA=; b=UjA5mXGNYodWmM
	f7QY49+nS1ilO+ZukOW8Vlt+ufiU18NWlkZhC79ffRGauOEBZEyU/QD3uK9u9s9eO7QsnHkYoZij5
	+8X9X6OoOvdPV9x+UdwESt0dpjNxMwgJazXvmfCB8t9GXdwE+FeJySd4Y/waPD6fdO9c53w0LKm1n
	260rPXhY+MR4aoxmgDNRh72t8ZbZXyThxq6q4lh3XJ+XlkmzJJjO80NcPCfN1lpg5kGyZ0bOvAF8d
	r6+mSpTy2cubSwdbWdtcrBJNETKz1p6CacmSrcarTmSq7DaSi2Uc4QWI9ALQh75cWLgeB30siE6cr
	gkqmF5nJvnDcB6eQ5hVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV7R-0003SG-03; Tue, 29 Jan 2019 15:16:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV7N-0003Rw-6Q
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:16:06 +0000
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8ECFF21848
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548774964;
 bh=4NCiHZKgNSMpmQtSj+IGKHh8nlqC8bRt2/41yc9jj8E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TmH1jqxwzKYulUw01J1To1zwwv8zNJnizv7EX2sbj+UYXkx0jJgXcAEB03qe6hF0d
 YUaq3NwwDIBKe9AN6pEs1ZiNE32Ai2d7HbFs7iDv/NOt5SYmE29GgqwLrSckpf0r1P
 Nro++Rp22bMKUugkwyRy4CkelTMSjL3ebjoKAKeQ=
Received: by mail-lf1-f43.google.com with SMTP id f5so14849759lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 07:16:04 -0800 (PST)
X-Gm-Message-State: AJcUuke5rJmEKUuFpuCtK1Gm2mc7RYcQzDSH4inWDmdbmZR3sThDeQ9a
 h7fSgSo63ZCS1f3eUfXaFvo2Z8LSKBHLqGCdRTw=
X-Google-Smtp-Source: ALg8bN53ZIctZPdAG12671uYZPyVQOuDf+rCJtTBciiq0EEM59Mzj/M/pL3brVxYKKmLsDuAur030T+Hml3dOkRIwjU=
X-Received: by 2002:a19:4948:: with SMTP id l8mr10240023lfj.156.1548774962763; 
 Tue, 29 Jan 2019 07:16:02 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5@eucas1p1.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <1548703299-15806-9-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548703299-15806-9-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 29 Jan 2019 16:15:51 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeN78Gpv0JM1onp3hYq0ZCVamh9wog_Vf_aJoOJFTHQbA@mail.gmail.com>
Message-ID: <CAJKOXPeN78Gpv0JM1onp3hYq0ZCVamh9wog_Vf_aJoOJFTHQbA@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm: config: exynos: enable DMC driver
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071605_249179_9963A27F 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 myungjoo.ham@samsung.com, Guenter Roeck <groeck@chromium.org>,
 Benson Leung <bleung@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Commit title/subject prefix:
ARM: exynos_defconfig:

On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Enable driver for Dynamic Memory Controller in Exynos SoCs.

"Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos SoCs".

Best regards,
Krzysztof Kozlowski

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
