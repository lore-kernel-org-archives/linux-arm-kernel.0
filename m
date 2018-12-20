Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:51:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65155217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n5TO6nOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65155217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OhX6nbLJ8zvSgXi6tvuAGoAQTWtpjPdCZYwvajpMF38=; b=n5TO6nOKv6tfHf
	btmbFqOsj7Cq7/ABhzV+qL5tjxKXYDbvVeLhc7L9gXQDWzskrA3zLgB1ZevKBaKBchh1+5lbakLKQ
	EMm3tblvKsDmnTWC3gYmIMWTgMF4N0crU8S8iOkNFpWdrY0oPAjMPMxA8GM3P9xTYbYXn+X4xG8lT
	PpwwbhC3ANdVv9WEwRekIZAsz0bNr7oQF9UEvZj3npZ8ql/pjmwCiA4n3dH1nsT8i7zCU0LZx/0fz
	Xi0iuW+wGRiuUsBQXGQbVjRp+N51Ohm/gpu2XGoWX5joLBfuTaj3KJjzzxvIkuoU7fkXpcBRxtcEk
	ZixW3mKBR1yr9vqk+HMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0bX-0006al-Lc; Thu, 20 Dec 2018 15:51:19 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0bU-0006Zv-MW; Thu, 20 Dec 2018 15:51:17 +0000
Received: by mail-qt1-f193.google.com with SMTP id l11so2318998qtp.0;
 Thu, 20 Dec 2018 07:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WQWGtgT0fgcNBIfwioUMaqKGTaG8bbKxTwCufj0gFV0=;
 b=HHUg0YdAE7vRLghIIAqozbo0EaF/hpz5KFKPcNU8h8s2ut3m6fHD86YcQj2v4RDNtC
 OWmyy6nVvqrNflnRPmxjgeVijaAH01KGr0uFujOy7Ooj377ExRRVFYIHUntT1Trlj3GV
 8nsR+TFuA0ZbY2wXukPRHW1Zd34oCtq4khYK4Y7soj090FEFiU+53d3UkNii2KRZsGzQ
 +uNqO6ELp3R4C+9T8T6KAQlt688sxN9ucsqT6JOk50aly6DGfYuNUUblXsszIOD0yjYQ
 szyvPSBwt5Gul/4qrlZM1HJHvOFv3576qv87IdtjiF1dRGWe9wuwFdD6BT6OvmGyhOQs
 3U0g==
X-Gm-Message-State: AA+aEWaY0i+9znwCr6zZVuwJRaJhUmpNypSCgc8JHnQ/rt02ywpMnYYA
 9hVxSUGdnKvgsreJCJ9NBRSSX/DnQqBDlrbU/gE=
X-Google-Smtp-Source: AFSGD/XenCVSVL/Aed2RpsLxbi44vSAgavBh5yBinMcFcNIM7bqyPXQGlQdnK/4PZdrZf2UZ8noWf145NcA+PlIRD0k=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr26273107qtl.343.1545321065719; 
 Thu, 20 Dec 2018 07:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20181216084854.GJ13243@dragon>
In-Reply-To: <20181216084854.GJ13243@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:50:49 +0100
Message-ID: <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_075116_727118_BBC0FA26 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: frieder.schrempf@kontron.de, linux-spi <linux-spi@vger.kernel.org>,
 arm-soc <arm@kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> Hi,
>
> As the series cleans up both i.MX/Freescale arm32 and arm64 device
> trees, the pull request is based on a merge of tag imx-dt-4.21 and
> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
> This comes a bit late, and we appreciate it if you can pull it for 4.21,
> as it paves the way for new QSPI driver under SPI framework to land in
> the next release cycle.  Thanks.

Pulled into next/dt. For my understanding, what is going to happen
with the fsl-quadspi mtd driver? Will it remain as part of the kernel
to support old DTB files, or will that transitions mean those stop
working with new kernels and have to be updated the same way?

Thanks,

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
