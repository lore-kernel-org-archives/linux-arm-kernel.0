Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9A020578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="knPEkvoF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qabd+m9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9A020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ZurtoI2BDvlU6bmXGgmn3eba4L/ERK8p2UnFxMNris=; b=knPEkvoFtAIefr
	M7QIMoioYdJTKyQKhupNNvNYpzPlL39LHr+AVIqQmzHMb/rDfRKGeHImrrio/8gdkN/lXmCbPgzMZ
	sjUDUwehd6w/iEp7/TOsfopjpyjV0kdEvak6iemLk9nNn0hefIBPaIf0g8I9f+dlRJmlnTCAQVKLs
	Q0btb5cvn2ho7kdVkLUtxiHrz0iolI7q4XnNZFbu26zE3U/GXkLDmZYHOnTkJ8ebdneCxPa3T8W96
	k13jRdpQtSCKC8EfMsmlgmdWoIvdb+nkpF+5wicvWn14i1K86hTDNz2owO6Y3s9gAMnwF0HY7VReL
	RqhfUS6aXKAWtApd0tqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkM9-00046A-RL; Wed, 16 Jan 2019 12:31:41 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkM7-00045k-Mp
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:31:40 +0000
Received: by mail-lf1-x144.google.com with SMTP id a8so4744773lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ok8cupwBDGGgfQcEKBeR0Iw0HERb6oBP5uNh5QaougQ=;
 b=qabd+m9bvuK7Y4la3dlRbmQOdhf/evPctJzTXZ+/Ajsx7kP/Nxve6b189ISRI6KKvK
 bwlm2QPJhuP5oM1C/SG/GuvgekA1/7r3rwneuJuriDtb3nJg6oiB2Ex2M5eKGyEYsAxD
 mL4pYBam0FGliV1qGQHbtMDwGbf/zhCHTBvi67sQWGmd9awdFqcAGe9ryVfZulQxNT/c
 CTosiE1p8vzfFpgizyLTAk0YMplSPO+B3TfbSm6TfbrMpY7fcjZ1aOfxr33tBa8fjxSx
 RhMpp6h6GHJihH2kEksCS1Vvi4mjNbduBMwcd9NQRqKsR+hXtdlNwWPh5dyrVl1//qO+
 BZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ok8cupwBDGGgfQcEKBeR0Iw0HERb6oBP5uNh5QaougQ=;
 b=KsuEEFtbGK/JN7jF0qfhz8q8gmOt7Z8D4K8EfBGI+vZvDoDZv0JVzfgeRwLdjRb4mV
 mU9O6P3UKsMLAP7BvaWq88tzfrEk5+W9G/IyhhUQnsa1ae+KtcqU1xM0irwiwzgidNal
 dk1+BzvbgInzy40kb7iIiP+5bLf7oOQxBN4i1kfRXL6M4nf6yTG+hSWLRKxfHbHJ+m01
 lNoj15x2V/f8eVOOpQVzuPAJDxWoXMRG7WjWoc2UGKwQWHnRTX8MyCS8XBO2tSjnP0i3
 6AAQt4WC5TkADyhamHtC3mQRk4eexLsvjGgEGC4G18ln9tAsicr6kZcV4fFeGLb1qrXw
 soSw==
X-Gm-Message-State: AJcUukeHLjVXvW/uCBB9lU2dQVXszWH8nwhSjVmrsNlwl8d6hRQVdIci
 pDNLfP1c2ifOmv1/TfYbLzWyLBSk5UXWMyA/uIQ=
X-Google-Smtp-Source: ALg8bN5JTjX42ux0ZsHZFeZHSN7Bglm/d5HO5yz/AtR+QM5vNSEldiErnGJMkaKq2+xmstEMAen4FyxoxSlkKbSSciI=
X-Received: by 2002:a19:c396:: with SMTP id t144mr6575207lff.110.1547641896857; 
 Wed, 16 Jan 2019 04:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 16 Jan 2019 18:01:24 +0530
Message-ID: <CAFqt6zZfTTW+MnRbxQf3F8qZE=MRstcxzrbYeq_YKOtam1F2Tg@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-sa1100/simpad.c: Remove duplicate header
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 mchehab+samsung@kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, wsa@the-dreams.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_043139_776210_048877C2 
X-CRM114-Status: GOOD (  12.81  )
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
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 7, 2019 at 10:45 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Remove linux/gpio/machine.h which is included more than once.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment for this patch ?

> ---
>  arch/arm/mach-sa1100/simpad.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index 406487e..c7fb9a7 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -18,7 +18,6 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/io.h>
>  #include <linux/gpio/driver.h>
> -#include <linux/gpio/machine.h>
>
>  #include <mach/hardware.h>
>  #include <asm/setup.h>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
