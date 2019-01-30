Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C425CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918A521473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j65kcB9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918A521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TlQoXO775Kh7YVSB0h7bffifszHAFJx0fKipfx8LRUE=; b=j65kcB9P/gbqka
	JIYW+RlThtSXmjgzGHsu8Z9e06BPu+LkLR2oIZUhq1ITpsTc8ToZ1BW2WjbwOtpFPNW7lQ2mxl5D0
	yRJTEFBeLccT9m/Z3flqoIJ705komPqcuugARA5dw3lBkUspNt19G/raMsKfRPatmqjl+TBeG/5Vl
	nRQgtR5LrYQp0DY4IluWA8q1CtmmWruBgnDlMOf4gH6YGjfO6wovivcbLq3RIGrD1n/LsAyBJ+VqZ
	ZywPhIAjShKGw30HfMsecMm74CHxYl0JsO90Fi4xMBTU86wihwdJ1REToOV7SH+K6uKRh3//Kn4mN
	66gUcMJKO6xeLvx8O5UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got76-0004EH-GD; Wed, 30 Jan 2019 16:53:24 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1got73-0004Dp-B6
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:53:22 +0000
Received: by mail-qk1-f196.google.com with SMTP id q8so154921qke.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2/FWRnqD7teHRvhwFtTZ3ugWxHGnw4lYzfbfjgQSaBA=;
 b=X8qC1odUEMXDYwQyndd7eRjUukUnVpkN7iwkIlncSYdn90oDf2BUVUigO4WePK2jXZ
 c5GG9wPaO+DJtlcd3X+1vCD8jcxNHycisyVpTgxK5g6gcyEsbuFcLPrRyWDRpB2x+c3i
 JJb5pwCAePselAc109wobRNYEGr2p9+UJxJU+9P/pvVoj0PDTGqlaKSyPMjPd09AnuTj
 y9ucFSCnXoyKnfbDcw+6puaeWokmCQxDEXyKd7HcxHGU3BQ8iAr3PSHZ0rjAeTeXl7VU
 acGkwdZqGvfOUms7YOKW4zGQPOu9CkBn5lyoDyBLwnlPAphSC/jdwqKpsIqccUVpanDG
 qZDA==
X-Gm-Message-State: AJcUukf532D8IEJ+g6GHKCh8k2K92Qu04iGVvDAJ8bNiWcrlYpGj3MP5
 KTAkH8lYvrhFODVtmSDOUtMNQEJ0a3iqjRuPxVw=
X-Google-Smtp-Source: ALg8bN6Iv32jcEJshdtkCZWi4sG7MK+1sy6sZtq2ZH/kOoFPhWfYnQxUDtvox6Rwg0LQiJ7vzkcamcL38jjy42WFMh8=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr26779188qkm.343.1548867200432; 
 Wed, 30 Jan 2019 08:53:20 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdaKoa0MHnFESoBqmmun2ZOWXOgXBYWnsVcqvDnzgBfJnA@mail.gmail.com>
In-Reply-To: <CACRpkdaKoa0MHnFESoBqmmun2ZOWXOgXBYWnsVcqvDnzgBfJnA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:53:03 +0100
Message-ID: <CAK8P3a2cgKsx+g_ev=rg7bJvP0Gok3ONzmbUDuCO7X_XoFSoqQ@mail.gmail.com>
Subject: Re: [GIT PULL] DTS changes for Integrator DRM
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085321_374531_0EBA1DF4 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 9:06 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi ARM SoC folks,
>
> this augments the Integrator device tree with the proper nodes to
> use DRM. The patch has been circulating with the DRM patch set
> and finally the infrastructure is in place in DRM to handle this
> RBG5551 device as well.
>
> Please pull it in!

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
