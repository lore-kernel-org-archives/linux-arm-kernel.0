Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE597C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:52:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A853021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WWzJt2n7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnQSsnbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A853021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1cH2W8zo0F5/ZhzquaiGtTtGVZy+5eYk+M8KjGfF8QY=; b=WWzJt2n71dz31R
	eeiVe3zwr3YPo0nHpuuDmXWoVGQDnliL2gnwxTagf+q3Xr99xwePS5GrnCAVaUrI2c0JRR5/JfE+h
	/uFAu9vfbEAozMJLGG9+4GslPRljWwcWMLEc2Ht0cy4AxjU30NPlRnc5J1I/8Ck7KA1vMei0Y/dNT
	7K2ZY7RrRrGlBeAuQLNuysXbnS081ONcbXZCRpYQUumbQcz16UuRqLiIPqVKr4jWvbQgCPcn89nqQ
	5z1Zkla0qU0x8qO49wjzOSSQmAsYZK9+I9WbB4pdCjehZxvO8tqwJUcBU+qfuPtIe3HVVUQ5o5CZV
	FMrd1v8/e63XU+kq0xqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfUa3-0006HY-3Z; Fri, 04 Jan 2019 18:52:27 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfUZz-0006H3-Nb
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 18:52:25 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so1663382wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EyuUEfuTmvLhi67JS1rUvXvyUvFfSZPSyZaSd19L4GQ=;
 b=NnQSsnbz4YbBYK57SjeCoU/J+ug6Tmj8kMnUjyShlT+W4E0eEIL2be8pRzNgFuYlaK
 +FQhAYfblbB4mwxlXQ6ZxVSyFhLEyRsm2HZtWrGnAZIOM35BcNnee4gutE2TjrESNzRh
 to4jXNx2R3/SP/tKxPfpBhoReJ67XxP/FTQBqgkvTNhmkkGZqDvHdAbV2cxXc+6ALMaI
 +fv3pch4Pt4DGTU139scBJkC1KU1tl0C0gUr83gEiL0o8BE4lEXkrrhmRyXRIC//RJEE
 sqtae4CgPXuHH7/YCDTdhEdMU4LzBo4xe95v4y+sYwYo6FCSSppyLAgw8MecrixYFaet
 mpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EyuUEfuTmvLhi67JS1rUvXvyUvFfSZPSyZaSd19L4GQ=;
 b=sNpK5XCef2ZSrWKoJVA/xBoThn9U+fMbOk654j3DbIrAsptshSzMZjCzTrXDkc9q8J
 CrZCqs6AA6xcCiW3LUSLyzNUcjBnXQdMT40T3bDrNTbH0WEoeOskxydqaR6+YJx2yJdo
 AYrBv3roHptL/YiO2yvu7iqZJfZEN+PcK9nyGrSmxFtF9ezpki3O0yafheoqLb40MC/c
 oaXCifETEb2DhhV0H9d57TYIk13IhFgWhytwNciefAr7alJBhlinCWYmnfuA8pC6C1rR
 0mXk/+GIKnIQrKWfxh4Fq22y4FgmgDXFKE8pIvjNcL3zl9MsOY7lBBUrLcEXZD9FreMz
 ZDXA==
X-Gm-Message-State: AJcUukf7JsMDPM+8CKErIcB6KmyqCh0MCpt23S8pI1LFwPWWuE6uInWw
 JC8tjG6wFCy2fNMGdQgoejLZAO6HxJacHjCDbE4=
X-Google-Smtp-Source: ALg8bN5kCCB961KFTPcrrskQbky8VXN0Wm99dD6nYDN4XYlp9012ACMUURVoxrUAHBpzrHCfOe70Il70mxSksZCrYR8=
X-Received: by 2002:a1c:760c:: with SMTP id r12mr2032207wmc.127.1546627941636; 
 Fri, 04 Jan 2019 10:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-8-andrew.smirnov@gmail.com>
 <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
 <ddbf72a52cd5b6c5e2cba2c6f301d12be651e220.camel@perches.com>
In-Reply-To: <ddbf72a52cd5b6c5e2cba2c6f301d12be651e220.camel@perches.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 4 Jan 2019 10:52:10 -0800
Message-ID: <CAHQ1cqGbeJjKyGW1xed+nqTOyMNG6NFe-o-3cHbRfyBvYTrK_Q@mail.gmail.com>
Subject: Re: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
To: Joe Perches <joe@perches.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_105223_798433_E24CABF8 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 10:38 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-01-02 at 09:33 +0000, Gustavo Pimentel wrote:
> > On 21/12/2018 07:27, Andrey Smirnov wrote:
> > > Make the intent a bit more clear as well as get rid of explicit
> > > arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
> > > "size". No functional change intended.
> []
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> []
> > > @@ -22,7 +22,7 @@
> > >
> > >  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> > >  {
> > > -   if ((uintptr_t)addr & (size - 1)) {
> > > +   if (!IS_ALIGNED((uintptr_t)addr, size)) {
>
> The (uintptr_t) cast could probably be removed as well.
>

Unfortunately no. IS_ALIGNED(x, a) is going to expand (((x) &
((typeof(x))(a) - 1)) == 0), so we'll end up with (((addr) & ((void
*)(size) - 1)) which has two problems:

1. It tries to use & operator on two  void * pointers
2. On 64-bit platforms (e.g. AArch64) it will try to cast an "int" to
a pointer, resulting in "warning: cast to pointer from integer of
different size"

When working on it, I initially wrote the code without the cast, but
was quickly reprimanded by GCC and had to add it back in.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
