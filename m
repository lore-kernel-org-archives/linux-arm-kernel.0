Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A52C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D465E20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pwrl16nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D465E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YXYEB3pf0dz06ye3owkXHke+RXdY0gugjhVcWnO3Dgc=; b=pwrl16nYNHjzAy
	0m5JiO63yMQNlO9j/nLkZ+CwvS2gyHSxbmNwdV6uxpFN3sHOkSiOaUuO5eMDODrkeMd8CFry6bKFr
	Jp8WoBKfYYpSzcAEzYuPHmVC7MEackbW+1QU+Mmso2XtVLNw0KMe+PQwYrd4OZHN7QZobKNOJ/sHb
	ywBbFO8UKEOyFjfC3CdcBn+xBTDV/ydXZM41/5yvNnTyrIfvTZFT5lgv1Lrd5POFrdAmc/62yANyT
	AQWtuEuEMywcrGb/5jdvBw8vpdsbDZo7/BRd1pWmI+sZuSH0g6WioG8PNd0wOkuGwckn4MNkX6Knt
	jNNtp0IB0EJ+cw4wFmgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUFw-0001Nt-9m; Fri, 18 Jan 2019 13:32:20 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUFk-0001Dj-P2
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:32:10 +0000
Received: by mail-vs1-f67.google.com with SMTP id t17so8382638vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 05:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4tT787jebN7BjtZV+4IEE5o9wdiK4Z3vEVKaglFhafo=;
 b=c7p6lrqDFDScG8GiYsGYqRZpjJGeXHdQc1yAZ5apn4IRC0eW9Q6NcYGzL+X88UFRao
 DlDVC5kuXbEAq4/8irsDIpi9TWiV/o9W4zir6fQQUBAtfDvCx3JHuRGrqcallXkcr5Cm
 3//SZ06Nw2HPtwB3X71ol8xQtUx94zjhDSvn3W0hFXUJzQSus2ahc/QQdprRcP483Ne2
 y3mhyf4xrLPw1WCmzWVJWcwcwCcTO+5t/M501gmA4BhXC75ASe9F7RZS0KdJJruw7J6u
 x3FepldAig/Bx5jEOKn7M9HTF7QYwBxq+GR7xkoaD3enXyvnuLE1XUxUkVS3pweFa271
 mXAQ==
X-Gm-Message-State: AJcUukdNSNPR+Dfag9zvF29ti3LTQ9y7zIg/yNEfIlqPpes9LnLpC3Gy
 dBAFsG+SJRuRDvMdAlDH5V2ZOjp2GUsa9YHQRJ55iC3f
X-Google-Smtp-Source: ALg8bN6Zsf212RwGWZzHCYSd3pQVmBcm2PSkjJNNZQwbFzsFMH/SLx/xpt5eGqpQ/kQzYgN5op3u29ikIgO0u8DCSQc=
X-Received: by 2002:a67:3885:: with SMTP id n5mr6739362vsi.96.1547818326731;
 Fri, 18 Jan 2019 05:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20190118122536.20000-1-horms+renesas@verge.net.au>
In-Reply-To: <20190118122536.20000-1-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Jan 2019 14:31:54 +0100
Message-ID: <CAMuHMdWt66viDaMGnFXJD9kH0Rz_GkEjPcPnemy65j0vz69UvA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_053208_806618_3CFE6487 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Fri, Jan 18, 2019 at 1:25 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Enable HS400 of SDHI3 using the corresponding DT property.
> No further changes are required.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Using "hdparm -tT /dev/mmcblk0"

HS200:

 Timing cached reads:   694 MB in  2.00 seconds = 346.60 MB/sec
 Timing buffered disk reads: 434 MB in  3.00 seconds = 144.56 MB/sec

HS400:

 Timing cached reads:   696 MB in  2.00 seconds = 348.20 MB/sec
 Timing buffered disk reads: 446 MB in  3.00 seconds = 148.65 MB/sec

No real difference.

Note that "dd" gives me very fluctuating results (all for HS400):

root@ebisu:~# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=128 iflag=direct
128+0 records in
128+0 records out
134217728 bytes (134 MB, 128 MiB) copied, 3.20103 s, 41.9 MB/s
root@ebisu:~# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=128 iflag=direct
128+0 records in
128+0 records out
134217728 bytes (134 MB, 128 MiB) copied, 1.15324 s, 116 MB/s
128+0 records in
128+0 records out
134217728 bytes (134 MB, 128 MiB) copied, 1.82701 s, 73.5 MB/s

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
