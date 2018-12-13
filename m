Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4467C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:57:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965F120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1oWxLOZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtqsOBf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965F120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C9sCineYuDPS2T0qJTDLhHurmigwAkdwZvBbIgo/1W0=; b=F1oWxLOZzjGQFB
	PKgTSnR/7I7M3eOeT5axyv8tML7+WJNMF697NygGmSXLYk8wz+oOI7s1txbzAHY6NwQgDZPLGC1am
	a/wzBDehLOyf8o3FxfmrJAoxdL9RZFwaNbzp1DSn9g4KZBHXKhsm4dGOQHvfmaGi8LXyoGfyw7swn
	zKY87hbDFZJY5wJ/yRm1tqSC8UwiHZGIX22mGX8bf5rWQhjJl9GJxPpEpYN/h99JYstetKERmZk9v
	TvmRCtoQtIu9SNpE94ZqX4w3erIvmjlEt9ePQ5iL6HASXXVEiyT++Ms0sId4hmMWlbDu8ubrZ9UGJ
	2GhuzgsQ3C+CqynRFa6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOgT-0007sN-Aa; Thu, 13 Dec 2018 10:57:37 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOgP-0007kr-HT
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:57:35 +0000
Received: by mail-io1-xd41.google.com with SMTP id v10so1196673ios.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 02:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zBPGCEZzECNsX2OPifcWu3O7YHQ7JnbNyA/haoXeFhs=;
 b=UtqsOBf1yh2k7Z0TVu/kyP6/TIYnDmquIX2qNQ2hkSCxzNFqoLgvndqcP7Z5smSFu4
 cibc7dWTl5rQTHrLARTnzMqobl0PFSgVXeoauebgD6hnpZp3V7OwwX89clx5legN/+lQ
 VjvsHPcUI5H04KcWmnz3gkxSGmgF1/3rNAQtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zBPGCEZzECNsX2OPifcWu3O7YHQ7JnbNyA/haoXeFhs=;
 b=sySqnBn9OFxRb8bgmCx+CKDDdruvKcWLsVQMDfCIkLOrLnrqEZjZT2WMr+YLs9aTit
 rgiM9x6kjQvQZQp5e0V6QURemBRFXYY75ObcxzThZUgseKK4z4DC8LgB15Zu17Kxv9u9
 ORaOM1BQ5Tv6LcvmiR7ugOtaB1QAqeFoH+jmopo8QYhpBUP0eNQiySRYDxbPCOv9Mduy
 ZhiYAkXXpbWcZhAbw/E23qMOZ1lsVKo5ao0He/QsdiVto+Hd+4n+nqQIrcrqP07DF8US
 gfmUdYiKGa3imiuR1Jt/6UhNTCoQC35CM4s5NsopshpOCdxej8ErDqXGx+pKdFJoNm1w
 KuAg==
X-Gm-Message-State: AA+aEWaITi+1J+YDBMyfFGPO7RIHQtZ8sXBnEExBcJBxGlww/ena1qGI
 6UEniwbWCRdQGbZJsXEERVBMmMwNAVdVzvEUvVYsRQ==
X-Google-Smtp-Source: AFSGD/WjoXXnhpdnUvVh/fCJBDsdAaSMOIJYd/E/+w3xDYyFso8UrOAwcISaHQ/Vup5ziaQh1k2TnFZL7rejBybMj90=
X-Received: by 2002:a5d:8415:: with SMTP id i21mr19754812ion.173.1544698642170; 
 Thu, 13 Dec 2018 02:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20181210152855.3634-1-ard.biesheuvel@linaro.org>
 <20181210154808.GF30658@n2100.armlinux.org.uk>
 <32bfc5c2-1004-b1c2-7b68-cf3dfb05ce13@arm.com>
In-Reply-To: <32bfc5c2-1004-b1c2-7b68-cf3dfb05ce13@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 13 Dec 2018 11:57:10 +0100
Message-ID: <CAKv+Gu-x7G8_Zndn8H=PB7WOx1fFhpCHTsANkkoATFjozJh8wA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: skip cleaning of idmap page tables on LPAE
 capable cores
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_025733_583840_ABBB7590 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 at 17:13, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 10/12/2018 15:48, Russell King - ARM Linux wrote:
> > On Mon, Dec 10, 2018 at 04:28:55PM +0100, Ard Biesheuvel wrote:
> >> Since only LPAE capable CPUs may execute under virtualization, and
> >> considering that LPAE capable CPUs are guaranteed to have cache
> >> coherent page table walkers (per the architecture), let's only
> >> perform this cache maintenance on non-LPAE cores.
> >
> > That statement doesn't stack up.  What about Cortex A15, which is a
> > 32-bit core with LPAE support?  TI Keystone2 SoCs fall into this
> > category.
>
> As already documented in dcadda146f4fd25a732382747f306465d337cda6
> ("arm/kvm: excise redundant cache maintenance"):
>
> <quote>
> Per ARM DDI 0406C.c, section B1.7 ("The Virtualization Extensions"), the
> virtualization extensions mandate the multiprocessing extensions.
>
> Per ARM DDI 0406C.c, section B3.10.1 ("General TLB maintenance
> requirements"), as described in the sub-section titled "TLB maintenance
> operations and the memory order model", this maintenance is not required
> in the presence of the multiprocessing extensions.
> </quote>
>
> Furthermore, as per B1.6 ("The Large Physical Address Extension") from
> the same document:
>
> <quote>
> An implementation that includes the Large Physical Address Extension
> must implement the Multiprocessing Extensions and therefore cannot
> include the FCSE, see Use of the Fast Context Switch Extension on page
> AppxI-2475.
> </quote>
>
> So on a core like Cortex A15 where we have both MP, VE and LPAE, we
> should be able to assume a coherent page table walker.
>

Thanks Marc

I'll drop this into the patch system.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
