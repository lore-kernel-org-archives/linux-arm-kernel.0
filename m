Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD79C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:05:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080D820815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhhWlxm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080D820815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e6mbCYU96FuRUFrUEDFEmJQccvNbX1pmhacCQL1ciSs=; b=jhhWlxm8DCR1Bq
	FcTCQKqcdygLA6/8+M0XHI091vhmGNxL3aazznThXKgqOdZz3nq3EBm2xIkFB40Mh3QtERP0e0fCz
	v6c1SkG0axbSSnTMlxyDqcgyQ82KXSmx8/ximEX1wyKjU3g74tGfPUezHkf5JwYyqkP98Uq+0rxw2
	MIjsUE5iRNHxitDd9ftmaHIW2S/8Nwj+WW/ilRrucLwrIMStebFLr0xZUOR+yxIikv7m8BJDdWifd
	lmRRuaqHiJ/beGy+DMoop7CKZQ8h2X7CwtfkjDP3A4pAXGtAIcUBh3Ycu2+XnAT6Jwnw5FH43dTgV
	KN0liyFCzJNh3c5oKmNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqHT1-0004yj-BJ; Sun, 03 Feb 2019 13:05:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqHSx-0004yN-Co
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 13:05:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706A780D;
 Sun,  3 Feb 2019 05:05:40 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37F73F59C;
 Sun,  3 Feb 2019 05:05:37 -0800 (PST)
Date: Sun, 3 Feb 2019 13:05:33 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH -next 1/2] genirq: export irq_chip_set_wake_parent symbol
Message-ID: <20190203130533.072b235e@why.wild-wind.fr.eu.org>
In-Reply-To: <20190203123131.28323-1-masneyb@onstation.org>
References: <20190203123131.28323-1-masneyb@onstation.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_050543_441779_2DAEB3B6 
X-CRM114-Status: GOOD (  18.07  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 sboyd@kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 linux-gpio@vger.kernel.org, linux-next@vger.kernel.org, andy.gross@linaro.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun,  3 Feb 2019 07:31:30 -0500
Brian Masney <masneyb@onstation.org> wrote:

Hi Brian,

> Export the irq_chip_set_wake_parent symbol so that drivers with
> hierarchical IRQ chips can be built as a module.
> 
> This fixes a build failure in linux-next's spmi-gpio when using
> allmodconfig.

I don't think the mention of linux-next helps in the commit message. It
would have been better together with the note below.

> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Mark Brown <broonie@kernel.org>

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.

> ---
> See https://www.spinics.net/lists/linux-next/msg46362.html for Mark's
> message.
> 
>  kernel/irq/chip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 34e969069488..086d5a34b5a0 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1381,6 +1381,7 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
>  
>  	return -ENOSYS;
>  }
> +EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
>  #endif
>  
>  /**



-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
