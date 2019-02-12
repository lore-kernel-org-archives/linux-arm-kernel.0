Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962B1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:24:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6376821904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TjRGMgGh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRVLLXcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6376821904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N3vvOiuMvS+E7guMRe8BmyYVZXzc2qWQwY0WzFO1iKE=; b=TjRGMgGhcs0BKD
	4P2ta+bPL/LWLe0vL1ao+WOjSOInpiPlkZ2gIT4DjygvKstbYxyWpZJNN/0wK5mk23G9+xZAK+A4R
	N/sileBwAsq5wXdNqoc/x6trGAx0C12bf0rNqWIXmy/1aMXjtJereo24DhhelYOCzW+omfEFMILSq
	trQwfDJhcAMe9qNzAJvW0wQ2Ulc/gwAxXtagolXl6RxoMMqNS+nb4N5TbkOyd8HS7w6NrwhWwGkhm
	/WIDiaQCcrouWqZDMjcDb/n9Re9FicKWFXoHMEh0Qjw5jxNO/InIN3z7wjY/bVWJm4aPVSiRJnJC5
	vSr9HD8rBgoGSaxCvtew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtebb-0007e5-QG; Tue, 12 Feb 2019 20:24:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtebX-0007VJ-RX; Tue, 12 Feb 2019 20:24:33 +0000
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 498DE222CB;
 Tue, 12 Feb 2019 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550003071;
 bh=BveQ4nP7N3gyvkFjUSr90tJMP/e9r0pbToW4MSxdXJY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gRVLLXcgZ1AIYHYj00/fl4zJj5uwHFRPiSNjERGvza+b63FiOJlGAARkss3C3bqVe
 4xSpSvXckOl0xlj/QTFw+dpy/7ieM/yBbv5RtKuxEnIMrAqW/ZjmlfrqjyFVRm9s3z
 z0YNNT67Hgad3I7KnqxwKPL9kYfuWQJIEs817/Zc=
Received: by mail-qt1-f182.google.com with SMTP id v10so4550148qtp.8;
 Tue, 12 Feb 2019 12:24:31 -0800 (PST)
X-Gm-Message-State: AHQUAuah05em4IqW/+h+YZn63rQhLjMICZxI9G31S8XFqNqOZB2BzaMR
 TuQ/QLgHOWG66HnxMh4bGIB/ByqNXP6NPqyuTQ==
X-Google-Smtp-Source: AHgI3IZ+aYxfQi/q+LDrbNlsuqcIsAtFo4UYad7A+3Ns0Rodh50TLXP9jNafEkB5/FuiwJjwL14XDxq/b8yo4h5Ejaw=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr4325527qta.76.1550003070462; 
 Tue, 12 Feb 2019 12:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-4-hch@lst.de>
In-Reply-To: <20190211133554.30055-4-hch@lst.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 14:24:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
Subject: Re: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch
 static
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_122431_935375_21D60048 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-mips@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This function is only used in of_reserved_mem.c, and never overridden
> despite the __weak marker.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/of/of_reserved_mem.c    | 2 +-
>  include/linux/of_reserved_mem.h | 7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Looks like this one isn't a dependency, so I can take it if you want.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
