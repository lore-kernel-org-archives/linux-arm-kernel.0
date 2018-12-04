Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0662082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APvN8f8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0662082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CjF1DITUSY7Q/rhPak1S1KHRNZleAQRn1PT8c9HgEzk=; b=APvN8f8S4T8PZR
	GLhouNMYiXwxq38iRzOExPQutxj0ynoYCcrfuOqrniSdUT9PomqI7AyNBvo5dDrGyFswmC/DBUX2E
	C6jBnyTaupoxKU+u+jbWx/bCY4pXsVjX9Rx5AcetZt9b3/VmsIgzy+FiY3lxfxddgagEU3FWslxjp
	b9CDNQqNj9VW4kxLF1tnSe7VskRwShATZm6aIkT6M2QkS+fj3ad6FpR2kAjHk/h9q+SrYLO9sugKT
	f2w2yRfLrHrFitD1T99ql+m6M9XeUmCiT84hEm65s7UZT4Q2dFhFGZLRXsBFC9WQThfOPcAgAdJQC
	dLGiuv7irWTUwDPHRW3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUC8F-0005lT-RK; Tue, 04 Dec 2018 14:57:03 +0000
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUC8C-0005kR-A1
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:57:01 +0000
Received: by mail-ua1-f68.google.com with SMTP id d2so5869579ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xYWDfCgBygTPCB63SMbqvdA93cB4zrg0LhY5khUtxJI=;
 b=Nb0gZo02zpcJloCjXfcLgLSvvWnWldA0V5jZqruKjtScdiBfrKBunGxEWXz3nOg9Ic
 kUbbpkDmKIayD1OBXIbaJVSdyuYw2meaA5Q6LWjRK6pvv50TP2aObtILChrI9KNf8pLg
 KB/bcSi0MryfGjZO+ho9IU3PPkYmd6mccVs9IDSOb1jgzVTOjDYzQxiB+MCSgs0Efk4u
 O10o3a0p3d10YpI65LMXfvd6N3kD7pMccgSrXy5tRCXjlpxRwVi5WDIe03ZNUp6DLEpX
 Iwo3p32ltN7GdkpxGY1R/VYPT+9FTC6oqysRwJM7EetF02+WDit6vYx/uprv4QUdU9um
 DqGQ==
X-Gm-Message-State: AA+aEWbbFILGhlDWn0xEVWrPG+Th+4IQKAAraGAfzOgfCtvDTud7EcCt
 PZKXtbBjHZTJXoHGMNdwiNrssmoTPPdr44/W284=
X-Google-Smtp-Source: AFSGD/UgfmisPTWx/S3A0dv/jJjsOtEKTW5ZSEF8Z79b9aWaFZHp8P3MGOAKfcJSD2NsZfPk0TGTzf67IxFgOhZthsY=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr9656963uap.0.1543935408537;
 Tue, 04 Dec 2018 06:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-26-robh@kernel.org>
In-Reply-To: <20181203213223.16986-26-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Dec 2018 15:56:36 +0100
Message-ID: <CAMuHMdXLpAR=EJnyhRFvTPEBVe8EhGiDd814sM9NkKYwePJdww@mail.gmail.com>
Subject: Re: [PATCH v2 25/34] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_065700_350250_9106638F 
X-CRM114-Status: GOOD (  11.24  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, darknighte@darknighte.com, Simon Horman <horms@verge.net.au>,
 Frank Rowand <frowand.list@gmail.com>, Magnus Damm <magnus.damm@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 10:35 PM Rob Herring <robh@kernel.org> wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
