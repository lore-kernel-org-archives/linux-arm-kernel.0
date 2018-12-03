Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6312C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B387720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sUTkteRl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNQcOhBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P/AvNY+AFbBmOc/WnLTKIs+UHRpr7z25ouUjgrZIgww=; b=sUTkteRllrRzpc
	PgJl5wIzHPwgUlaOWbTmHyJ4DZv1XOHJxK44czPSEn0osCHkHFzskgkoLBhRj3Bod34QeLBalwz00
	7LUZ05h/t+N4jbbs5kiDMoR0h4QtVe/R3wvJRPMvlJ1O4uzfgbSQUnO8ErZdiYn5xl1Cp2nknZVXC
	4T1uUW8ELJXTCImUg8j3EoRrTqk5AeQlq52Cv4E1klSNs7HqRfXSzcSTY/0NGZIMbltggUr+2WU7N
	s3kHawbIYnP0uYZ/hAUlhl94e+FZWxxEuV+uM7YxuwyIuqQEzshyoVFdiYavyLR4xcTN1fdIg5o3c
	J/qZO4YrpSK+4b0ufy8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTs77-00061p-MG; Mon, 03 Dec 2018 17:34:33 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTs74-0005zw-AN
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:34:31 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so9834688itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cg+48DoFxNYJ/GCLHItJYQDW72U1S3V3i9H+pqbVQ/0=;
 b=TNQcOhBwOLixilY4XXq/voa3rZQ+h5VmS4r3l7AO/LCAGBY8RGNGIzpC7PNn8qfDdg
 8ksipToTExzXSuG2CFDebsNt2l50Yq2RSt5dEBru4WeQYOe0IwDpXGp6+U5oyhksWXIZ
 GEPhMa7rBT2NU++94LHq5cEvCTi5n+AaeUswc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cg+48DoFxNYJ/GCLHItJYQDW72U1S3V3i9H+pqbVQ/0=;
 b=iGF8g5EHA0O6b3ClFihqjRGRVafHwd+bC50cFp7CRWCFyDbDCUB4hrY2FbmKWeWPjI
 G8Edlnxd4mL9yx9kEwBJIXn2kEWFVLWkMv/R70/A9t4IlZEIBAH1Nl8tySp/sUUQEKFv
 YV61LYPC2hCKNQD7smeUDa4e/CKDrheb9KTRtwJds9DXk0uof6JST5+A5a2gC0INj12t
 ykJLwdBtRcSqCskU65SPXSiFvhYhQMNRkWaiDs3BBSnGfPH0tR8P5n5gSTPFlWNOMjLk
 VrFbRnxNPZDIj0w5eN1IM+rqMWxvQGeXC54c6GnMXc39Z8gU7GDBPPVQr5hKW9lFXucM
 JlIg==
X-Gm-Message-State: AA+aEWZr/bpZO3LyMbDrQumMcOTf6JKyIbZCBQnhzvJt44rzBLN/+YV0
 dd0E7BzAD+raeGDclO15LRX9JVDDklOH9a1GYHgzQQ==
X-Google-Smtp-Source: AFSGD/UJY7hy+sIo2ceMWvwRDc0V4Fs0+oXk9Zab7K5odLmRwTc2hHE5T8DrK/FLkUpw17jXORdym/KlWYzU1u+mCNQ=
X-Received: by 2002:a05:660c:34f:: with SMTP id
 b15mr8903651itl.146.1543858459010; 
 Mon, 03 Dec 2018 09:34:19 -0800 (PST)
MIME-Version: 1.0
References: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 3 Dec 2018 10:34:07 -0700
Message-ID: <CANLsYkxc21RbNft+k_oBA=4ZPCBr_rhYSV2vxiHceyJH3M6jVw@mail.gmail.com>
Subject: Re: [PATCH] coresight: cpu-debug: Support for CA73 CPUs
To: Leo Yan <leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_093430_362367_D1CE4EFA 
X-CRM114-Status: GOOD (  17.97  )
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 at 18:22, Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
> module can be initialized successfully when a SoC contain CA73 CPUs.
>
> This patch has been verified on 96boards Hikey960.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 45b2460..e8819d7 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
>                 .id     = 0x000bbd08,
>                 .mask   = 0x000fffff,
>         },
> +       {       /* Debug for Cortex-A73 */
> +               .id     = 0x000bbd09,
> +               .mask   = 0x000fffff,
> +       },
>         { 0, 0 },
>  };
>

I have picked this up - thanks.

Mathieu

> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
