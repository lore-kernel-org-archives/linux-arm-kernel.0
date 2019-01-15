Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B8EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:28:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D50820657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kodPcUHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D50820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LwLiZ7lH66RtR5Wo1i41XYQy32wzgSjSKPUOI1R7kmY=; b=kodPcUHqSCeFYy
	S38sO0N/yEDlb1O9Q8V+/I0SN7o3n9p78T21QfnYpkqhiNML8UqVVrjc35eVSm5/2pTlo/bTMmW8m
	F7ZBkKnHigRh7QP7QFCfkNCgHgImqzQtFyu1VIul5PlKzMHAcxeKJjkJ+Ig7jgXf+VBpkhawTqTj2
	NuerM1BoSerBo1JZcVr2MEgyzxnC4gHXg3+9YfSFpRJysRPlBmfRRqal9TsBQsvmPMza+NvO0JPvM
	M3RIm77UI8W4r98sIUVD5w0vHblkepq2zaCQgnqvDDXvhnF/Uj+3paqeKWaYzwuZ46yRJh8ARJOKk
	nOpKgOMEwnMhNoEwlkrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjUOG-0006wZ-I8; Tue, 15 Jan 2019 19:28:48 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjUOD-0006wE-UN
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 19:28:47 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 7246E8022;
 Tue, 15 Jan 2019 19:28:50 +0000 (UTC)
Date: Tue, 15 Jan 2019 11:28:40 -0800
From: Tony Lindgren <tony@atomide.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Mark Brown <broonie@kernel.org>
Subject: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190115192840.GK5544@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_112846_016156_DDEF47D6 
X-CRM114-Status: UNSURE (   6.11  )
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
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-omap@vger.kernel.org,
 Belisko Marek <marek.belisko@gmail.com>, Tero Kristo <t-kristo@ti.com>,
 Jon Hunter <jonathanh@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Keerthy <j-keerthy@ti.com>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Looks like commit 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add
level-irq support") caused a regression at least with palmas PMIC where
child interrupt no longer work and we get something like this on
omap5-uevm for example:

genirq: Setting trigger mode 3 for irq 157 failed
(regmap_irq_set_type+0x0/0x15c)
genirq: Setting trigger mode 12 for irq 154 failed
(regmap_irq_set_type+0x0/0x15c)
genirq: Setting trigger mode 8 for irq 149 failed
(regmap_irq_set_type+0x0/0x15c)

These are for child devices like power button, USB and RTC interrupts.
I'd also assume GPIOs might be broken now.

Any ideas what's needed? Some triggering mapping data to palmas.c
driver?

To me it seems the child device interrupt triggering can be whatever
the hardware supports including IRQ_TYPE_NONE for non-configurable
interrupts. Additionally palmas.c supports inverting the SoC
interrupt also.

Not sure if other things are broken now too, it might be worth
grepping the logs at kernelci.org for similar genirq errors above?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
