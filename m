Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:39:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13983218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PTg94RU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13983218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HxODELUmx7QnckhRw4JVmPDYJJSl+EObNgRoVnP63CA=; b=PTg94RU3KwVZsM
	YNcB2HoZdZ1fWU3PPUEoi71wN2oVo1poqOug6yqU/HtGM1EwocdZPk4vcJ9OxcjscLllKcuixmKvt
	TPAyVac0P9HlDuThc9PQCYTwk64mjzhOtbNgn3RqIRm8PUU9x0EKZN4MVj9Brd4OI3Fs1aw1EzGIa
	cT8UmlFe89eOGOmG7PFuGA/txozbqKhLoNdQGTWuclwqmxhseAFiUpwdUKEyMpP4CFQdqdBVjQ0ra
	wWgPu+xDSH0pXJq4DkbYJM6uBtb8ZpGiVwN5ovrHTlNdZgDKpMaDlVvA85fs6COyXCLHQZnfyXAPS
	SYqWPPbuDajAWEnsojmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grVqQ-0000IE-Cn; Wed, 06 Feb 2019 22:39:02 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grVqM-0000H3-Eu; Wed, 06 Feb 2019 22:38:59 +0000
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5BBB7100002;
 Wed,  6 Feb 2019 22:38:55 +0000 (UTC)
Date: Wed, 6 Feb 2019 23:38:55 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v6 2/2] rtc: support for the Amlogic Meson RTC
Message-ID: <20190206223855.GC4719@piout.net>
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
 <20190119144332.11984-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119144332.11984-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_143858_648923_A8715D46 
X-CRM114-Status: UNSURE (   6.90  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 19/01/2019 15:43:32+0100, Martin Blumenstingl wrote:
> +static int meson_rtc_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config meson_rtc_nvmem_config = {
> +		.name = "meson-rtc-regmem",
> +		.word_size = 4,
> +		.stride = 4,
> +		.size = 4 * 4,
> +		.reg_read = meson_rtc_regmem_read,
> +		.reg_write = meson_rtc_regmem_write,

Not much to add but if those registers are battery backed, you could add
.type = NVMEM_TYPE_BATTERY_BACKED,


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
