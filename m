Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E1B214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OxgFPzDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E1B214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=67fNF6o1aM/E66IAukOj8ASOrYX10t9wIiCdrItcng0=; b=OxgFPzDRUp5Am6
	sB4uMQkRkry66jzsglg6P1ZvEH6Q7h/gK0q0Um78NDCMUJjgXSPnEdsOC1fZg+lGY82Gh8UaYLEHn
	kPFF4dW7ZzIE9WOdHIrOmZTzKG64eChKYhZJWO7jdIo9YYCra7qiYCikJM4QE5P6zDnRLNmx754t8
	M4QVZj9QcK9TAJoiEN9y4+YwphSrVJnZwUeFJIBOxQKBwLqoKrQsQQFNu+oFehtisU2b8vzapOMjV
	2mO84ViiqeKD3HPa7gLhZmDJMT9zGYHHONpWRD1eXepKCGLALZXky1z1IJmkMf4PxZQs59caHeY0a
	ZCigzveVYTs+6yLalCbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gngg5-0002tS-R5; Sun, 27 Jan 2019 09:24:33 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gngg1-0002t5-5Z
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 09:24:30 +0000
Received: by mail-qt1-f194.google.com with SMTP id r14so15371651qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 01:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AaDJija6UKG2unMz2UqBHNOl5GWCn+T+fZPhVoigDHM=;
 b=LJqAon7KdWNieMkZgoiv0vLNPH+ArMTz/zIkekfYNdL9RnywG1JU6uB0tiAKA0+L6a
 O08wnUZrzLAYSR11egLQK24iAtb4MBvw/BOOvO8B1FgNfhFfeII//4+GSHIGoRFG853p
 vwJdVlMfk1pz3CiqCuvEvnhn6+61U0eYFiDdDxkB2u5Vj0RrtUz4nw3Ho3d1trNiYRgY
 B8R7Av2eHrMIzVr209g3VBnLuoAQdgqVRzzATrBxqgUUrcIrPs9BsvDedAgXW0Dkioot
 ToHVpgHBBM8SZkE4gsXZMDg2eu3tvS/FJ/SWXPIyCg0FkZePjDH1e6ZI6taLpxIjIwAd
 q0nQ==
X-Gm-Message-State: AJcUukfbr7ancCI5j4Na9erDQkTG0ja4rTb/rS1y1JJb31I7FH53sPuS
 1WlbCll2tuGrd3rICU0K+MHcMm8K0EsVA8PQwP0=
X-Google-Smtp-Source: ALg8bN6YOrCCbFLraxbCAPIcE7Ke2xKTD7COsjshu0jkDrMpY+3p8hvnecYOSve52woTsvixPsFw+6HRVTtgmj5kkQI=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr17403811qte.212.1548581067076; 
 Sun, 27 Jan 2019 01:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 27 Jan 2019 10:24:09 +0100
Message-ID: <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_012429_210473_76AE8E73 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, darren.tsao@bitmain.com,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, haitao.suo@bitmain.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 26, 2019 at 5:11 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> processor subsystem, a single core RISC-V subsystem and a Tensor
> Processor subsystem. This patchset adds support for only ARM Cortex
> A53 Application processor subsystem with UART, which enables the board to
> boot into initramfs with 2 CPUs.

Nice work! All patches in this series

Acked-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
