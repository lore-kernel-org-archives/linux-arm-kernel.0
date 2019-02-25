Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:57:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EB52087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FKtGCdRA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciOIEzIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EB52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7O1h6QMmapX8/upELXvlQzlZh+fpzCO5qm/mLVleutI=; b=FKtGCdRAAy0EHG
	V/u1/ttkq4eykOvG8ZzgkRjsnRNTltICAWJIfGrVu6wZWAXWQQFhmKhkLPJDOVxyXmCtjrhcK73wp
	HmSZsX/mZhEDaMyPyHAYn7trjpBUpba/gGqNKO+NriH2VDnGGxgNlzaP6O6EVbd3QuxYr/rLXBeFZ
	jbOuMAOghvNQ93xDFvZOm8HI/tdtX16v+dGFcuaA4SZhoolALl12n/Rp3JwZ70P77mosxJ4RF4xlN
	UllYbuyJ2NkbMNWYz+MurnabNywAx4SfLWsTLeXjjN/7mN5BvEQyaj2O/irxc0Rbi/WvN2cDls5kg
	ELPQOsIAB1fVrpl7HEvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyB8u-0000Za-9z; Mon, 25 Feb 2019 07:57:40 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyB8q-0000ZC-Uv
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 07:57:38 +0000
Received: by mail-oi1-x243.google.com with SMTP id e7so6524373oia.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 23:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5AmyUQFwlZ5Bk+oW79CIwNgeC61rRf9hzgzMUkdTYLc=;
 b=ciOIEzIwYybzPrxqjbs3V0zfX9pNpNKVr6rsZiiZ0iW27iUEspgwSHHvPr1ZBORNrS
 /7kHxBL2SbX2XSjsjqlskyDXYTPLWCdWLQOwyvT3Y4U1wdz2ryGx/IuOZo2tJO78H1jD
 5hUoFJn/l+kcFjAq259eqaTAhQfrwLp0Ns/fpz3mpb36xFEAF3RQFswbi6UF3wacU/pD
 1vMDG4IvJNgw5wbhOF3QTgL2+QA6wyznQhE1zPfGbo31uRQB5WlPzMTVQSwD13vt0ny0
 iepM4ACuL9Ny7KtBb6jcH/h7nMtNxscBMMGmDKBd/cs4ZrAxT0IEGXebecPsEh8/PpWF
 /2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5AmyUQFwlZ5Bk+oW79CIwNgeC61rRf9hzgzMUkdTYLc=;
 b=Mk5MnIRe0Uc0VDAXu/vA9TcOldLyLYlyvlXq/eQ5l2yI4TVNpFipzPgklJAG/BdfbO
 wznZSYmVU5Y6AXrDEjlADxDPjSULCM5Ff+Mtlbcjn2IsQZ1muwt7cwMiznbAKIx3M+OL
 H21fsMP6soQQg1//f+UA3IJCWBhUNaIOKCTAqgpNgXbNhx9lB/mlursoOCULfded67I/
 B7LhDkm29QG5LRRwhL4rO0L+vo8NHiomoW5HcFSn/bcYHp/M8CyZ6ydrQZpAQbCd0a+5
 KYbppxMvCRVp/btceIQg6bKdNxqQx24VnxnGkqqsfUYpl5yaQbOOeCNrlpvVITky37Ho
 GgNg==
X-Gm-Message-State: AHQUAub1A64ORl0RByAEF8x151J2JCFz3b0ztFxbAOgiw4VhrMiQMCAN
 8e/jyZcm4U/zrLi5+ZhDyAjhbnVbzxu6l0IfEtE=
X-Google-Smtp-Source: AHgI3IYsSko6M20Yv5aIh7Uf1qpnrO9qFkrlQBnQRslILT68cRtZiwxkkuY1nZCfftv7BSiOg1kcVLgwN2n+zM70JBU=
X-Received: by 2002:aca:be83:: with SMTP id o125mr10680272oif.72.1551081454670; 
 Sun, 24 Feb 2019 23:57:34 -0800 (PST)
MIME-Version: 1.0
References: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Mon, 25 Feb 2019 07:57:22 +0000
Message-ID: <CAGUNXRTY0yKnLH1hnxiv5ydnWG2VKNzpY_4rZ2yRhj8_Jq9rYQ@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Add generic i.MX8 SoC driver
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_235737_004506_18EE771D 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: Rob Herring <robh@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 3 Feb 2019 at 11:50, Abel Vesa <abel.vesa@nxp.com> wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>

My patch series which adds support for the i.MX8MQ to the CAAM driver
[1] needs the SoC driver, so it would be good to get this one in.

Thanks,
Chris

[1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg36947.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
