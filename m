Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D7CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:33:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E0620657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uhfb5xTy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ec+yIOBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E0620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ITdlYIR3rRjRIL3qDk2KpswO4wcuv+oRXgG8NqQtYW0=; b=Uhfb5xTyN+YKsl
	+j2fHbfhqkmEllNRro88bUXpUHGzlWY5E65W/1gYvgiOqWiZBI60725XRHSnb2qKjLuBP3Xu/G/xk
	H2Y+HF9ZQmz60ghp/Y9pakq52S7hqGkM1x+UZd0yp9zSgPnjnpOntYr0LMf8+qXPCHoyzpl1FwYi8
	UxSELnMhydbR0Mk0uYFGUVk2U+uCbIr5n1+mpGVqSEPehUqai7KJbpkGuvQUl1pSIbrB61t7dwGwp
	lIgE3o4OFPX0vBqZOkyVLwRUsJtRm3DOi19BKCeglbzladZE8aMEd2n7T68OjGPV1iP8/Ld+SjcC7
	yS/n3iUZQHlJZHVmAQVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghw0Y-0004LU-Ji; Fri, 11 Jan 2019 12:33:54 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghw0S-0004L3-6j
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:33:49 +0000
Received: by mail-lj1-x242.google.com with SMTP id q2-v6so12773348lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gg/juwHMoYXvq35apqcfFmSANXXLjDLHR1u7Jt3Y4Ac=;
 b=ec+yIOBtq1lXSBMab4HO9DAu25YdKJmJJVVmxl3fWVDHfP2poOpja/hXN0rEdic+Wm
 3C9Cjz3CGIxLvI8m8Pvd0YISBZT/AFBWsWyplqJny5Zdp+1WmvwW5rCtp+go/bkCqKI6
 0UATV63Xi4iIs9Y+O/bn2M7+bJLXVhChh/p8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gg/juwHMoYXvq35apqcfFmSANXXLjDLHR1u7Jt3Y4Ac=;
 b=D+CtRp1o/z7CMkmLhdZIlYP+W2q+Z5oBu58QUDT+8niE1Angiaxg/eWHHh1TveNiAg
 IVzUD2I4zOr78IIsT9F4NmEAflgOIENaM3sQKWlqFmJgvfiv2DY8Ikjrb5Y3VNSih0vA
 SR4oew8k8ciRJ+pqEBSHgk65aW2L5SZZAUuQ88eiIRvjRRMUwMGiGcNiomghTabCuQHe
 BKFDh/rjhu8z0gK1pfya1oyOrEQvz+Y54nbVq6cIz8CXG7nrFBHxVi3TDT9j+H3FKoX9
 TZ+qqi9AJgF32GFVuZxdRlRiUD0Pab4zgCTvohSWLHYbZqOl2rpj6x7LdWqOtOs24ux5
 Ityw==
X-Gm-Message-State: AJcUukf96ua6Z5JwfcBMOI7dpioDyH0uEhldKP42S8gDcDKPJZGH8o1J
 4X3CKuBdrGwk7HM41CVG2gqGvdjPgA2D6FaCUjxOEw==
X-Google-Smtp-Source: ALg8bN6di5M2gpyAbwClUybTIXjCcAsHVfhQ8DTWyGiTkkAnF0zk/qPZDR93oi7LY912mQODc409qxTHDOxqCrdJ350=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr8462600ljj.9.1547210026288; 
 Fri, 11 Jan 2019 04:33:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546667177.git.gustavo@embeddedor.com>
 <2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com>
In-Reply-To: <2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 13:33:35 +0100
Message-ID: <CACRpkdZkrsKo_=Wpps54jVaCADwL68JOLvUC1TeJYf8ZmLj=4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: integrator: impd1: use struct_size() in
 devm_kzalloc()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_043348_246767_03CEADE0 
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
Cc: Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 5, 2019 at 6:55 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Fix devm_kzalloc parameter reported by kbuild test robot.

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
