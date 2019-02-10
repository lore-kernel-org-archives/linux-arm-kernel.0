Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FBC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756942145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XDQkug67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756942145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16HvFvixiXw3iwC/rpTbVIwyuokW2NfBpadgEHqrbcY=; b=XDQkug67th1ZCc
	5Ls7nVZGCM+ltuC0j/v8m6ewgFQ2BCF4Zj8cghzbmsLBU1KzNFoRzup2KCOTW2axOo6c63yClG+S2
	OSUugaLW3p6y/DC75U7uOUWDgVD9NFN2lSCUw8pG85bcSUue/NlJy8xHsLwrmfNT/l/CFyeicIfGZ
	9qBiPaagMpnD7N1a/1bDotAYoQrfW8urKau7cPHpEa5f4OYH5lbFBp6u6CQh/eLLwo9qay2qh12u7
	Kl0KxCPcxGQX2825DliyCsq3a02wMzLfg4drcDinV4LKLzPnLrJdJwdhNlr0H8St4RP3lim8sKjrP
	cTHj2RwyQko3ITZ8/Obg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gswYJ-0005UG-O2; Sun, 10 Feb 2019 21:22:15 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gswYE-0005Oj-2L; Sun, 10 Feb 2019 21:22:12 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 3F402C0004;
 Sun, 10 Feb 2019 21:22:00 +0000 (UTC)
Date: Sun, 10 Feb 2019 22:21:59 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v7 2/2] rtc: support for the Amlogic Meson RTC
Message-ID: <20190210212159.GK23062@piout.net>
References: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
 <20190209001813.6792-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190209001813.6792-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_132210_308230_E0582976 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09/02/2019 01:18:13+0100, Martin Blumenstingl wrote:
> Add support for the RTC block on the 32-bit Amlogic Meson6, Meson8,
> Meson8b and Meson8m2 SoCs.
> 
> The RTC is split in to two parts, which are both managed by this driver:
> - the AHB front end
> - and a simple serial connection to the actual registers
> 
> The RTC_COUNTER register which holds the time is 32-bits wide.
> 
> There are four 32-bit wide (in total: 16 bytes) "regmem" registers which
> are exposed using nvmem. On Amlogic's 3.10 kernel this is used to store
> data which needs to survive a suspend / resume cycle.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [resurrected Ben's patches after 2 years]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/rtc/Kconfig     |  11 ++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-meson.c | 410 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/rtc/rtc-meson.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
