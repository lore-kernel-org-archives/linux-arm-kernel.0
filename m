Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA92EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7778C207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zjq8l6a6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTwH1ORi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7778C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYGPurwaKg5YG7hA+r+fPZ/WsEau355UI14aLYnvU8k=; b=Zjq8l6a6fgOT76
	JLsSpnYFDqFMqYIt9yD+yP98JOjQLNqAkftzxyudmG8ROtGdFqQscwei/t4YNWlD97PTKOxq/u1pV
	AuWGIIG2p1vMn2v8LhywZskt63kxlmsrv6gl+jWJKalP9TVkiq2X+87DLT55+XG/zw7NHHh0xE4o9
	qEmYlEE+E0n4MzdW2xoKhMryhMK4Qgqq9ssfipD3ZBMVkkxlbjw2RW1tOCQ1fLRQboZo+9G3u77GC
	PbPNvaT1Xv2bRXSlvBLiJG6idBHsoLkk8g/+uUQ6RUadxZdwOLa8Mldhx2iHjBaI/gUlOVoIfdwF2
	tVekiM3yskXSGOC1fOtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr15v-0008SK-3d; Tue, 05 Feb 2019 13:48:59 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr15r-0008RS-G6
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:48:56 +0000
Received: by mail-ot1-x343.google.com with SMTP id s13so5732755otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GHvKWi9L2842L0cyfRSb5wn3PMhEaDm6j/wUQekR4yE=;
 b=VTwH1ORiTzjZdAYiRLyQt+Yh3fNZuZwWPRJWtqC/MW7hUf73g1BWYdgzcoZe5c9t1x
 wVlNZFUnpDtlRn0RVdc/cSfTkKoN5gQul7+BP9ZLXdb13r7JX2lA4z3KoXiwOie98I+w
 8OdDUaMXFJzvWO6xWq+PvMZIpyxPT/n7azm7dqnCWo0md9MMXqfWBZPkhjSP+9Er0fqq
 4JguXn1R//axurMYytEfO95LDjZ6pHLNuwgA4tzcTZWUB1X73YraDf7lKt+FTX47n6+f
 nk5W3kRldlimDGGWdBsjpn2C/eTI6H/KGwyUpmEXLvH33HL7qTADKYmzasqU47IjbeXw
 L68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GHvKWi9L2842L0cyfRSb5wn3PMhEaDm6j/wUQekR4yE=;
 b=LeKQ3XP4QfCFcdpjol5XuHmUJtjCA8YDkH8GwbSda2xvCDshs2YPjBSTvhejV80ly+
 Tf2oiMiK9Ttl7coSFIfoC5tJ6YjqiXkZPzqH/z2gn0D+nY8U8Y5FM5vGcvubR1FvHgPZ
 oxibehTL+099h6DR+NoiE7EbYbglVaD+L2J3VBeBv5UJjTmBE1jFSN1vUY9mVSSUMakt
 ukPjrxO5Dvqcu5gi1q+mmRrZ6YJGOJJq9ccR3zg/tYVwpcmG05cf32QOQWWfOxmhi8/R
 GPWCFtkre+z9iEMh7X4d9gjHWUGOc1TI72F6W4ECuAELhwocvyJ2LYCS7oySm0JPsFlo
 y4+g==
X-Gm-Message-State: AHQUAuaxf90m5+Oh+9Ie6vbWjmnkxV3UYqudyiyrxP7KHyzp50wqD3xL
 GRMZk4GUUpSswa9ntwG5Ifp3ffy31SsQIrh4bfg=
X-Google-Smtp-Source: AHgI3IbYcLnPSKCZe0bq0wJ+gQtuhwW6iiC7Ck5SrV9Z/2Wn7FCzX8hIYP/2fdcKNvkEokrxuijZc8ZPd575zEN38kw=
X-Received: by 2002:a9d:60d0:: with SMTP id b16mr2562943otk.109.1549374533932; 
 Tue, 05 Feb 2019 05:48:53 -0800 (PST)
MIME-Version: 1.0
References: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Tue, 5 Feb 2019 13:48:42 +0000
Message-ID: <CAGUNXRSvtEG95XG+y3DDza4gXu6nyZcGUPiPwKRqp5PgGTu8ig@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add RTC support
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_054855_557297_BDC86188 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Baruch Siach <baruch@tkos.co.il>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On Thu, 31 Jan 2019 at 15:03, Abel Vesa <abel.vesa@nxp.com> wrote:
> Add RTC support for i.MX8MQ.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Tested on my i.MX8MQ-EVK. The system time is now retained between
reboots, but not if the system is fully powered down. Judging by the
absence of coin battery on the board I'm guessing the SNVS is simply
not powered when the main supply is turned off, in which case this
isn't a problem.

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
