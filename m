Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09C6C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:25:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F7421850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NWKRspv+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzTC9vFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F7421850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NZPyFpJN09Zb5JWSjZBAkKivrZZjhR+oDY/6gvLqqfA=; b=NWKRspv+cX+dJp
	APy6CvgMiMAmGJgy6gvGKeChqj5ip05W555uu62251utUg1hCK4GJI4pEmRdcumVgmFgtgmiqT/N3
	pp7fdGiLU0pJhInnpvK1OlCQy5kgAafN2szV6KnulFfXx3kcj7oNyPQ/PM5vvAhe+qY/ec4iJ2Xl+
	wpDdR36sfKvgSEHXCz4nr1tzkBjUSg8yiNL8qzl+qEtdVRd663RNDuCuY8LPBZ+zYf/zMsrf2acNZ
	ys5+cX2O7LpOQE8+rr1hWlKfFBxZ6eJfS/RMo5n1rfQBGlITaMA+vtCwT+mgEvsBUJ/hjBDPaOwjG
	vPg8viPAtmGR48AdRO+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmNDH-0003Ef-Ft; Wed, 23 Jan 2019 18:25:23 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNDE-0003Da-EX; Wed, 23 Jan 2019 18:25:21 +0000
Received: by mail-ot1-x341.google.com with SMTP id t5so2828005otk.1;
 Wed, 23 Jan 2019 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WBaoiU7eR1QLYUu1fuep2rQ7Trl8sJuH/fe25wut9bA=;
 b=rzTC9vFa3foJ6/lEYJRbSFvun6uOBD28iWnfxI2s1iAdRYYIhMObQFMiBuIlBUV7Ir
 4zYZ2c6Q3YXPcOJdKcjxCmljw6J66jcOzc9TOlVXCg+Nu/9rhtE0jhHbos67vvGkt6EH
 WkTAHOfXQyAoqf/k9FFCi4qNWp2uONP674qhI0Ti3dI3ktcHfhWzlUP463gRXKSd4GhP
 +S0N5zjweMAeIDCFxrwrSMSJ7yA5W7EY25218D62j+9nJZQZbyOzujhxguL1KfcxLB4s
 l2xG/GmBbYaCpfIn7m+f6PcRyUmqr5p7AfSWJmgub8fjZO5lylP3Phqm24WqZN+/GV/H
 P+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WBaoiU7eR1QLYUu1fuep2rQ7Trl8sJuH/fe25wut9bA=;
 b=bq9thJM7TTN8mRRMQp0EBEn07IARIB4n30Mu5O0uUmx/x8EKrS3/G3GduT4GDjxR6H
 H3kchlBX6UH9QshpUKoQg7599qdwiWeyuqM24jetxuUIK5Dhoh3+R6x4D3v5s7dAUw/h
 Uo1k3ucTnJ4OI57m5V+nywNaULv6OJqL8UWuSqHVZqkT/ZJCiLRTuWsKSLIOPlqqTsa7
 3TpNuKdOLGwMFiedXjWrqR5t8yZKYiqj7nV3BE+FfzhDWyefmPnSIzyzQyLVKBVyIxWC
 WjWEiPR3YLYVQT+SHJxBlSWdqaU3f65vhb/M1pufLMzQkhP703f8PCQYVSMTKeq3nvzQ
 Zr8Q==
X-Gm-Message-State: AJcUukdLvJFyLOB61RIYU4xoTPCzwSK/vbj25XX2o0OFIlEIgbHFn8fF
 vnRMmaqAejpD2EOsnHDZfK1bKgKDLiybHA2UGDk=
X-Google-Smtp-Source: ALg8bN5uoY796+LtwhysN861ig8AM7za5LQWOz11AtUofkIZ5oAfxtgbH9TL+LhBLuNVrtPex97qVElNIGFXRrnaA2w=
X-Received: by 2002:a9d:6297:: with SMTP id x23mr1981688otk.63.1548267916656; 
 Wed, 23 Jan 2019 10:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com>
 <7hef93mi88.fsf@baylibre.com>
In-Reply-To: <7hef93mi88.fsf@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 23 Jan 2019 23:55:04 +0530
Message-ID: <CANAwSgQXFWNP4NdmheyE2O25FzBk7VOwbY1h7rx4GrH9J4XiZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_102520_513945_F23B161D 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Emiliano Ingrassia <ingrassia@epigenesys.com>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,
On Wed, 23 Jan 2019 at 22:20, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Add missing vbus-supply link to phy controller for usb_phy0
> > and usb_phy1 nodes, this changes fixed the power issue
> > on usb ports usb, changes help fix usb reset warning.
> >
> > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Rebased on Kevin's amlogic/v5.0/fixes branch
>
> As requested, dropping this series from the fixes branch pending further
> debug and testing.
>
> Kevin

[snip]

Thanks your very much.

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
