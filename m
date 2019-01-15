Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708542085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gWhOBbTg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqzmbTg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708542085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRnOGkA1eeyZ3icdtkZeYN3PQxEbf2E6Jl2luzhN0GY=; b=gWhOBbTg5mQxQT
	PDmOjfALOvBad1r2IRU/D+1aWmK2Q3hPx16Ufqo+hy3nnevNEKnXTJhh+IjZITMoxkFy0QTul5jpd
	KbecHF26GZ6Nx0/SiAY6WZocWoVG3DYndVFGWnXeqhx1ICFbbyjUUP2coyRpEfSt2psvI9GrfG3Hg
	gUoN9pijXT2HL4i8ZE6ExnnH+1RxeulqzbRpufuCQCDiqxIAwYetRbMqfOVA4/rw8pZxiQCKqG3YM
	MqjXV5jmr9sE1wS3mLZ2NZ9+4xT3MwXcA5zJ01M6/zACkp1IAazOoym09VsMZ+hGY0asJEvf3YjwA
	dljx+fDVJGE73xJ2S29Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjGXi-00061k-Cr; Tue, 15 Jan 2019 04:41:38 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjGXf-000617-Ik
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 04:41:36 +0000
Received: by mail-wm1-x343.google.com with SMTP id t200so1832744wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 20:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nkWbQeeZZqOQHoiCzF2orNqjxrcoTi6C42m9bZwQHQs=;
 b=NqzmbTg8Ga8JSRfjctmuGTorGceM4hkXE65okF/LlYidngSBgyyu0qIIL1L4PiKK9T
 3fnpVDe+N5eCJEDiK5LbHe3ugblRbXGRox05j8ZU9veoN08o8MM96YWAqIcO+JPpPXGW
 iCKWA3UeO9eWPn2qOLb+bk1uFFXfEgTdJ00RR1HtCEmGGuEetXmBd0/ATS+QTYe/68pS
 N0zJSTQR8zM2jJpvWm0CsPcuzSZe4KOM85S1VZnLBmctaHiNnRmdDp1fblvhCg/A+KeU
 MDxZ9vYTtoW6rtlKPOJPLKqOEvwJ1g5p504++prDDPgfDeKCmX/Si4fw/PFEeE+WJiqM
 LT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nkWbQeeZZqOQHoiCzF2orNqjxrcoTi6C42m9bZwQHQs=;
 b=hdtYCXSWM8fdLqAHcy1TxMMF+rqzwPZTah5vo2o5ZDFLS05uUdQGTwOJa46iuEQZV+
 ThbO8PeIN+jlX0QD+oXPsmEeXeZoXkxyTpOGjokXFgHStzAC2somG/vvuT1WvL3QgZjz
 RayyJb2ansVcMTgfjaNzDuojuhQCOzRxPHZ1L5UDjPLWyIBJvmM31gL0Dn4+uCWC4p3A
 VkYZH0O/UoPWcoRKufolq6fb2juc5AEuT77CtdCL2qn+z3O6jLtgmA1OZrF4qTH2ZpdD
 9iSgEhrhTz6V/riACb37c9jzPf6Sv2y9sa/ozfT2gw9JhMuSp2762CIUmYM2IQh0Anww
 tmsQ==
X-Gm-Message-State: AJcUukdWiCQj4r51nJSxXQRzJlroycCxJx30jglXZQmNHtw59Kwz1Y9M
 +WjRKQcbRq9sIpDSljpv+UrlEaxDLpbGe6Ucu4g=
X-Google-Smtp-Source: ALg8bN4jSL6VkIjQd8K94ljKxhwYMjZ0GYciB7UhEtpjV38WRfWenm0gUd7vI4CxVsnzSn1cUlr7843W0xEwYJoY3Bk=
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr1639313wmf.27.1547527292713; 
 Mon, 14 Jan 2019 20:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
In-Reply-To: <20181220010700.8598-1-andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 14 Jan 2019 20:41:21 -0800
Message-ID: <CAHQ1cqExs8MVoYUXE9tR3SBrKwG6+Los+DM6AgBTx8OGpvB6rA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Reset controller support for i.MX8MQ
To: Philipp Zabel <p.zabel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_204135_646333_D7A4FED4 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 5:07 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Everyone:
>
> This patch contains changes I made in order to add support for i.MX8MQ
> to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
> SoCs.
>
> Feedback is welcome!
>
> Thanks,
> Andrey Smirnov
>

Philipp, are there any changes that needs to be made to this series,
or is it good enough to be accepted?

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
