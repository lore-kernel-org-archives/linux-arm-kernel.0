Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3177C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE642145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QZ0fcXKH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B2SBVgJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE642145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nHddzfGxz2XRHV6BbBYnNdutxl4z5EBrFIbpdKbZKDQ=; b=QZ0fcXKHmirCiv
	KJ6nAINKGtvoH8kLa8bVhLd2aJWTD145S44q7WaK0yKOUeL/NHfCBLFRxKccsAY+QmdjgJty7g5ZQ
	ETmklXccN+XEAJSn6Y2lrZ+9bukBO9bqqPztD3DFTeg95ouNTbz554sSxAKPuqzphyO75tATfw+IN
	+6PVyn0sp5gzrkfauRTkh5Thy4U5pMOWS+vJMI0EtG/L78rthbilAcUZ3voKx3IJrCHmMMQjVzAzq
	Mciar0yWkcPhG3w8PO62A3hZt9RiXF6t0Qzm3i8M/RwcqReRbmJxAViHfIp8wehNtV87/sE2Y+kN7
	Vfllg49oGSFb9RDHvNUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkk1-0005MW-FU; Mon, 03 Dec 2018 09:42:13 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkjw-0005KT-Ps
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:42:11 +0000
Received: by mail-io1-xd44.google.com with SMTP id f10so4067953iop.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJhyObZHH+z3JMwCDzBJOiMf2OvwIyDMaaZPnyC+mJI=;
 b=B2SBVgJWw4wISQbZPf1NwK1npbia/yVTs4q7AxGtUmAaio0K0YONAzUEz8zGXpqfoe
 XKMLc0F7qfxvAtt/sligAW8AKU/Tk/DrdUQxhpKlYGu9eheddYKL2KF1hBjtP/f1xxK5
 jpX7L+GZcYm8MZxrrxFMqcigTWY82iLWB09pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJhyObZHH+z3JMwCDzBJOiMf2OvwIyDMaaZPnyC+mJI=;
 b=leDFRXU7e89xZJznXXkj/uambT5RsYYO7JNaKU3cBDXlG+8oUW+4QyWxESxaik6aLl
 0RR7sPD6eLWsmjgaP+APzA+8NfpR0nIGZXS2P7vZECh8e2zj9D0HKHD+/Cu/MmsFYOUA
 l0nJGtzU9TFYsVSx3bJ3VuBrMxaq89jjV35XqkIirUPi99JdjiE6Vc6VOyw0rvLs/8W9
 m28CDxdSa/4Lreh5NbaqBst6eSTJNd4AWE9p+4xnwM9784M4oM+O4i/5vB2KridlujDS
 f5UQ3+skuOlaPPh5P5p8Qfgnmu2B1oxPamewS2dZB6kEAR5OWbifPw5u1TXWqD3WnS8z
 8Xfw==
X-Gm-Message-State: AA+aEWb+ep2fT43AM/BAFy0e0Zvg3qUIagSyyqXCkhOZ6zR4ExkTFYzM
 OZh5k64sm/g+J4WCWtpUaoiKmffok+Yqchu6o6qcqw==
X-Google-Smtp-Source: AFSGD/VnPpar5Bk1bJoyfUTzjkSCrRwrHD8hRdHsgcFBg6pQJgGlrT41KmOH3kSyIcpDWEG7eTCsml2+uXV0Y2Agr4g=
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr12284674ioc.114.1543830116872; 
 Mon, 03 Dec 2018 01:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-2-wens@csie.org>
In-Reply-To: <20181130075849.16941-2-wens@csie.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 3 Dec 2018 15:11:45 +0530
Message-ID: <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
Subject: Re: [PATCH 1/6] media: dt-bindings: media: sun6i: Separate H3
 compatible from A31
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014208_834700_BDD07AA4 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Split out the H3 compatible as a separate entry, with no fallback.
>
> Fixes: b7eadaa3a02a ("media: dt-bindings: media: sun6i: Add A31 and H3
>                       compatibles")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

"media" text appear two times on commit head.

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
