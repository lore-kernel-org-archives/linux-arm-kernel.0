Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00711C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EAE222C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VtMY692x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQP/8ori"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EAE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kKlRj5TIxOiVHYtusHq2Ps9mWElMohwsO8OwTLXHjA8=; b=VtMY692xBGNs1c
	VOjxB6Tx0yvQ7ZZvHl7fDx+WYzL9FH3uf6WuD/TxMBnMdyLoaFl6p8fS4ELD5hqoegdW1YlImkrax
	lBl7vn0+AT9JInYT4b5B7FnvXsFynKRL2LYIXwcJS/YfWdER6Yo3RtA4S7SlQLZ/UFodeX1lYrlkS
	CHvyyXUy+X92vvldlaJFg3GPhhiTZ9bMcIPnAps2HZvSTA+l4H0SL1APo/utGoEsf1MUUHMj0JZ4h
	MsOvWtTjX5Qt2u6IOxvd1zklgtQCjpCMozIlzbIa1pDT+7O//FF+99yzzJcepuuOc7Rz5T9Y2Jk/S
	NOpb9fzuT8T4xcqhc9EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtirt-0002Ot-O5; Wed, 13 Feb 2019 00:57:41 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtirq-0002OR-5u
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 00:57:39 +0000
Received: by mail-ot1-x343.google.com with SMTP id m1so1157815otf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 16:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kZqLbps8Eicn9bK00mPyp+DBSxWASkWXhIst/2wZu/A=;
 b=dQP/8orizVz3eshrenK/ZouNE/69Wr1hLGemLd1VoxCG/KLXBHtKEYl5466gXm8l1v
 ThIamJ4vVZs7wVAThJAq8eM0xa1FQUhBJtnFNzku+N3Y0uwet4nBztgW8L1mrFaECvI1
 IevrfxlAc03hDh1dsiCF/Xz2QSZn2p773nupHuoDQ1YJWwX/dVOQexC1mCvQe1UTXdOL
 WMwRgqFdYr8JZREc/i99TxE5CG2z5DtcXpse5e9VDPy2oqiKml5077LTRHSURrZYb0+i
 V+icdebCCm0M2G27SNjKre+K5THKSqunoAFJR5JmR2GzlpWN1x533KkrBQxAs8gwCVUm
 4y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kZqLbps8Eicn9bK00mPyp+DBSxWASkWXhIst/2wZu/A=;
 b=i+HusgQT82jwAqilpMa9YGzUxjXBfBESgwjA161IUr/w2mC0qO0Ie057OQeoaY/C9Q
 85NWDU0E1DKIOU1nYmRBjlsRHyFj1cgDt+F9FDnE7nvoZY5ZN2WKhz7PZhlg/iXIhWOY
 noihYqLgnDmJhLODSGfEqFgkOg+xypHYSj8e8QEAWhVukJkK8kWpQc8DAFFR1fgX+5oO
 XQhxhWH31MhWzH45ogDye+776Jm+BfrZ7MxfENfeKgPv0UKDFWv98zY+qv9MZqCRJ4uE
 9iUC67EWrj8bHy0Y8MZyFErfLm3ZpB2ZiDaKaL3Klz3A3TqkZLxGcauSmdHQKKZjohhg
 iFcQ==
X-Gm-Message-State: AHQUAuZ9eHgX9eKdpT7XQloocHLG5SzjSjSJvH5eRGJDt9LpFMvJ6dAJ
 yo4jrXKt3UV9IxGDI7Ln5mMisgc3deVzxhR/gLE=
X-Google-Smtp-Source: AHgI3IZ2ZWFHnUGl7nnxlmnyXkKsp0GTwym5V5KYNGiGc4gKmGBlHQhyLsthXo170+wBUY9bLuGxLBbDuxllQO/qZ7Y=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr7170940otp.225.1550019455764; 
 Tue, 12 Feb 2019 16:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com>
 <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
 <1549923727.3075.103.camel@impinj.com>
 <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
 <1550016436.3075.127.camel@impinj.com>
In-Reply-To: <1550016436.3075.127.camel@impinj.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Feb 2019 22:57:23 -0200
Message-ID: <CAOMZO5Ctp_p=j1G1DCaPxsyjWTK8dtKR9Ov59XGxYdiqE+1c2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
To: Trent Piepho <tpiepho@impinj.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_165738_228923_F14861A6 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 10:07 PM Trent Piepho <tpiepho@impinj.com> wrote:

> Tried SDMA firmware 4.2.  Still broken.  No apparent change.
>
> Get 4 cycle pause after each byte.
>
> And crash while/after using DMA.  Clearly some sort of memory
> corruption going on.  Fortunately, it's very reliable that using DMA
> almost immediately causes a problem and this is easy to reproduce.  I
> think that indicates it's either clobbers a lot of RAM, or consistently
> manages to hit a very important location for kernel memory allocators.
>
> I've got an idea of where that might be happening that I'm looking
> into.

Ok, thanks for investigating this issue.

>
> I think it's reasonable to add the dma attributes, but put a check in
> the spi-imx driver to disable DMA on imx7d at least.

Something like this?
http://dark-code.bulix.org/urfoh8-580174

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
