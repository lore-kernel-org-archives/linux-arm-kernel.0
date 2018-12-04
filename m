Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA9CC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:55:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E1420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q9JKA1YQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dNvvs3fU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dNvvs3fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E1420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kvik4+uc+WmdQyT0sFE+ZXmybtZOhtL3itsR3BwV8uo=; b=q9JKA1YQDVyjZf
	3rPlsD5YIyZU/x50JrtiBISBW81E5gJn8FZ1eeCRjqYoVJo9T3mGzlfsDH5t7dAfEtGxDFLdwyMhc
	y2dK6AMbA53FAnsn3l0p8kuNH0+TZirXuyn9f41GpvpdxpBfihNW9VImLLtTYnXxWJ1wRZWxj9qHx
	oiU+LtxSirTT0MkpUoO3MDBl3ZZAezaplh/ITM399/K/RlpfSAlZvjVzLsg0ZS/9DsT7J6h1V2GzZ
	N6BYd7Ax29ujvQiSihW/qMSXmHmV39kBAILeuf98HYE30D/hgKlGjpcs+2oPlUg1W7lTZONvgL0sv
	gZKXhhZj+DI0+2QiTVyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAEU-00041D-6m; Tue, 04 Dec 2018 12:55:22 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAER-00040I-GP
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 12:55:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 8F86B602F4; Tue,  4 Dec 2018 12:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543928108;
 bh=7BOaiSQj/NL7ZmPQrEMNx4p7VtWmYPJNrrnbElvYKf4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dNvvs3fUdxL/jzUh6bWwVZdoYcwJMmUWn+jOeLWbdw9glpPJDoh24qxGAUAfmyz+o
 Oxqv5Epq/uDcUkSPPYzmj0/foucHtgr+9qlNut527vLuf/OKNXIl9FDFSKunzFQhGP
 6g3lfrlzBuDSBfma8cKOHdMO8TyTGINmvZ8p3msQ=
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 03315602F4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543928108;
 bh=7BOaiSQj/NL7ZmPQrEMNx4p7VtWmYPJNrrnbElvYKf4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dNvvs3fUdxL/jzUh6bWwVZdoYcwJMmUWn+jOeLWbdw9glpPJDoh24qxGAUAfmyz+o
 Oxqv5Epq/uDcUkSPPYzmj0/foucHtgr+9qlNut527vLuf/OKNXIl9FDFSKunzFQhGP
 6g3lfrlzBuDSBfma8cKOHdMO8TyTGINmvZ8p3msQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03315602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f175.google.com with SMTP id d19so9505636qkg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 04:55:07 -0800 (PST)
X-Gm-Message-State: AA+aEWb/gqpxBnhGxFMlKY1rbKSx6ZlBm/W9s6wFCvCmQX7Q6I6TeU1d
 WmQ6TLjj9Mz3g3w+6f5jfk38GvuapRDWiHht9yA=
X-Google-Smtp-Source: AFSGD/VKua0K2QYNoG/2fG/MlgOT2W9jGOFWCjPFu70hbxbcO3UkCW8ROHM9wcDgFVm7cDlCzsnF7EqsWcss0wcX+64=
X-Received: by 2002:ae9:ed51:: with SMTP id c78mr18161126qkg.85.1543928107338; 
 Tue, 04 Dec 2018 04:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
 <27c1c420-925c-c8b1-6103-4eeb885d7e63@free.fr>
In-Reply-To: <27c1c420-925c-c8b1-6103-4eeb885d7e63@free.fr>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 4 Dec 2018 18:24:55 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFri_XQJfpVAnpjz62KKzX57B2xT-D8HYGtRa8EHUkrGA@mail.gmail.com>
Message-ID: <CAFp+6iFri_XQJfpVAnpjz62KKzX57B2xT-D8HYGtRa8EHUkrGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To: marc.w.gonzalez@free.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_045519_581468_8EEA3FCB 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On Tue, Dec 4, 2018 at 6:10 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 04/12/2018 12:01, Vivek Gautam wrote:
>
> > Qualcomm SoCs have an additional level of cache called as
> > System cache, aka. Last level cache (LLC). This cache sits right
> > before the DDR, and is tightly coupled with the memory controller.
> > The cache is available to all the clients present in the SoC system.
> > The clients request their slices from this system cache, make it
> > active, and can then start using it.
> > For these clients with smmu, to start using the system cache for
> > buffers and, related page tables [1], memory attributes need to be
> > set accordingly.
> > This change updates the MAIR and TCR configurations with correct
> > attributes to use this system cache.
>
> This is version 2 of the patch, right?
>
> Version 1 would have been:
> https://lkml.org/lkml/2018/6/15/186

That's right, this is version 2 of the patch.
My bad, I noticed it after sending the patch. But i thought of not spamming
about it, and thought of conveying it in the first response to any
comments I get.
Thanks for bringing it up.

Best regards
Vivek

>
> Regards.



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
