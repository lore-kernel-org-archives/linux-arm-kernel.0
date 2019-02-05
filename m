Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E0C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5E9217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DU5s1xeE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkGDSbHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5E9217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hI5KgBeEHoUHmIzIdzLjCJJ06BUgyaVJAQVO6zDPKWQ=; b=DU5s1xeEQogom1
	zNfwGwpZjZCyywWm1hdya9KuFEeKrO+NGEomWDbisvIFTu01c1d8jmg201iBhKZxZo5TqexPuxdlu
	VSKKRkDVgQaL4p9YpE9xMhKFxhvihaVMauSKi+u2uMH+OAkYcw282FhxZUY1wZAlqmKoUVRwO6j+Q
	xqkZHXwpgzGhILLm7oHx3WPQoqoDxiR6V4+kol1xnko7vZb4dXptjOhlhsmpwwkhDuANnsQSexy9n
	9T6ZM/xb63GHITnx8QhmtNTLYEvz589gBWYuBbWbCQdMtZNGfZPkobuEI/+/XQcjiOyLZ1JJzKP5o
	9RF77jrHcKZwcBdFwGPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2Ks-0005dv-7l; Tue, 05 Feb 2019 15:08:30 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2Ko-0005dD-W8
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:08:28 +0000
Received: by mail-ot1-x342.google.com with SMTP id a11so6123569otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a1Q0QlJvIRfHK6i1DO3S3Cu2PdkkWhb+q/mjicRFa/U=;
 b=WkGDSbHHiaHVj+2gvxInYdV8gstrS2hDiSAGCyNqsYB3JUfvA2mjPZkqUcWlh3ejP9
 x8MAImD4Zqpc09wfYlml7v7GIiczSgcUkXcWNT4IJR1StxAsugieGOnwD1cSo14eiP68
 HWz8RCh0bMmcMng2SouKxqNfRYiU1unpmq00o01XYp2t8zSbTM74lPmeNsnFVqBJgJs/
 EUJP/M0RMGUD60VIqWEErnvXnz6Gn3Tjkem1748IpccC+1kl35U2ojD3X7iM9MVNx5NH
 rmJdwjzmt+aNi8sHvCTN7+4nj496uvjah1jcXGnadBQUaouq/iOpADYfC4Mnssfugt/Q
 /bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a1Q0QlJvIRfHK6i1DO3S3Cu2PdkkWhb+q/mjicRFa/U=;
 b=Qva3+d497S/PWx8lI79P7Hn07O/7EhVouFuyvuoxQz7RkVS1yF94mExiMFgJXr0kWm
 7ljXo6rpbYFM8VwCdzFatgtwNkKSq5HrpW/oZMcUsG0Czm9nuMc7NF/2cYDW/aQWIRn4
 epbojhmfW0tN712EL9l3oZ+euncixoHotHj/mn7bzo1Q7R8fbjXIlP200L9AnZ30xnab
 2EOOCDf63mTHpwLPvrW9UFa5ImHzVD5EPhsfW370O08PSlYtzQUbseL5RXmLvLtzxjaw
 L+pn/NW5e4sAcd6MDbvlrN4vK6Lbk8t+/uppJbK8vFRSNHgILxZgMntiZ8hxDvtUoZOV
 F9pw==
X-Gm-Message-State: AHQUAubAf+A1p94oot9RJG+Ru2NUn/kcCHVT/P2+Ei0xv3Bin8O8389U
 WyENuUQCQsM7L8VkOS7i/Iijyei/u4WVIKL3Ofo=
X-Google-Smtp-Source: AHgI3IZlWOHqiiwLay1ZXepPp3GHv3HmnVS0Mau7jb1d4+uKmG3BMMqtMJ8/MS/ZwPQJYGrSufjSOfQ+ttlSvs9iMeY=
X-Received: by 2002:aca:c591:: with SMTP id v139mr2835945oif.76.1549379305480; 
 Tue, 05 Feb 2019 07:08:25 -0800 (PST)
MIME-Version: 1.0
References: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Feb 2019 13:08:22 -0200
Message-ID: <CAOMZO5CX1CNNRrKkifTB3JDCHzpznd42Yy2Ea42qxAVkbouHUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add RTC support
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_070827_027675_E8B17F81 
X-CRM114-Status: UNSURE (   9.24  )
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

On Thu, Jan 31, 2019 at 1:03 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add RTC support for i.MX8MQ.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
