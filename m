Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F9C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE2920869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XEjdkOj3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhYUN36w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=50fOGnZ01FZftp4H60XTWgbPtvIhbpmIGHiqiBhm0OE=; b=XEjdkOj30yRGCW
	rywAojXCS2rbfxpCd417G+XaNiAO1n5LQ5k9rflMetFp+sSGznNJVusNs3b8xzUkytUVOWH3PnToD
	ZbiJe9BH8e9Z0OkzjLvzL3H9HT4JEuKETSANPAJyLo5pvqK7c/uQMMNZWOYngyPhhAa5G0WXPIqJc
	PKjYhUH5cqpr7hFcuYQlP5q5ZFrIRzGAarTMg/j28dpxxsChwNMZd5xErwgID775FTMjT5mDQz9bg
	nqa0SfkGL7UFEzDWUEDKT60yv3BAX6158CJeub628DmWC2Av+3/ZMDOd2ud5lOBGx6K8a4COI5zQ/
	N/bINzKMSgUwJz/zQAMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gph8v-0005ck-Lp; Fri, 01 Feb 2019 22:18:37 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gph8s-0005cC-7O
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 22:18:35 +0000
Received: by mail-it1-x144.google.com with SMTP id m62so11735782ith.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kyy0ek5GfntFjkRqcbE0N6jOjkBWQ0WDzHgq+JL9DK8=;
 b=WhYUN36wOddX/3O2nAP1OCelMJpSPoPV9K/8qIWw4ZZ18YQ5mkK7cFksKcIve/Jjny
 xEg18YCXX7va5+bsJp9jz/3WU3ac7fMbD1U6Ctl7HgcvUXHxC4tFvkuH1FyLCfrT2cVr
 WvV09nvfo/cEuEEt0SCerl71joxEMyOjknw7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kyy0ek5GfntFjkRqcbE0N6jOjkBWQ0WDzHgq+JL9DK8=;
 b=jSx0DcQe3xAtOE+/2yCkpqFiqrCV0bumxOF4vpMEf8z/fB3K+GOhbCp0zqSbMNHu01
 Zx7cS4imBZiLG0iERoMLtCIad7itvjBSS/Fmr/+HJeWWbbaf0J2lRA7fjMGwJswdf4sx
 xVtXWxLJhHCpu3RD32Xfei/6aRrJXm8gU0RelFC9OQ3OszEJCZfbs6dZWh9CAg9LiEYV
 ov3FvfervrsQs1QOVdbJ+KL6amf7qbw8mb+iUntA10tdlAM1CoHXqNw8IFRKerF19V1K
 J+ERJdFKCYHhO+xnsVRMXYsUzFRfFresGux7tfIrir14ij1zQeV6oWnpQjG7hP4Zr7Uz
 lW1w==
X-Gm-Message-State: AHQUAuaHLOIc3APjmR7NVRhei4koJ9h/zpbU4i1QW2B+vw0/PjEEWZQ/
 JcGNURbHeoFA+1ITrbedlqGLIyyHNTVzXVBLlqhPrQ==
X-Google-Smtp-Source: AHgI3IYztE79pcFL2PmgAPLt5NhgKbUJzcKAZwIF6GjF+MICRCLjvoJekTuDKhCUGOm5gd9192jW7Tq8JIGE0oklv7o=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr2973906itk.71.1549059513045; 
 Fri, 01 Feb 2019 14:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201192001.6495-1-natechancellor@gmail.com>
In-Reply-To: <20190201192001.6495-1-natechancellor@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 1 Feb 2019 23:18:22 +0100
Message-ID: <CAKv+Gu9tcpZvMZdbD0D+EUCTbdnszv3+MHM68utLZssuMcxyZw@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: Don't expect a return value of
 ptdump_debugfs_register
To: Nathan Chancellor <natechancellor@gmail.com>, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_141834_265121_E2D61F3B 
X-CRM114-Status: GOOD (  19.86  )
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-efi <linux-efi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 at 20:21, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> As of commit e2a2e56e4082 ("arm64: dump: no need to check return value
> of debugfs_create functions") in the arm64 for-next/core branch,
> ptdump_debugfs_register does not have a return value, which causes a
> build error here:
>
> drivers/firmware/efi/arm-runtime.c:51:9: error: returning 'void' from a
> function with incompatible result type 'int'
>         return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> The arm version is still awaiting acceptance [1] but in anticipation
> of that patch being merged, restructure this function to call
> ptdump_debugfs_register without expecting a return value.
>
> [1]: https://lore.kernel.org/lkml/20190122144114.9816-3-gregkh@linuxfoundation.org/
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


Catalin, Will,

Could you please apply this directly?

> ---
>  drivers/firmware/efi/arm-runtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 23ea1ed409d1..7ae3b797caf8 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -45,10 +45,10 @@ static struct ptdump_info efi_ptdump_info = {
>
>  static int __init ptdump_init(void)
>  {
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> -               return 0;
> +       if (efi_enabled(EFI_RUNTIME_SERVICES))
> +               ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
>
> -       return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
> +       return 0;
>  }
>  device_initcall(ptdump_init);
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
