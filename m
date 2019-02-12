Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:23:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB9D21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q9gKjeta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB9D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3tVqteUYwHDvMw7zqd4MklRSTDct35dANBofvZYLaAM=; b=q9gKjetahxa1jQ
	y4QuxRLWvSO79IdTtNUN7ktUjVsqvZZ4snzzBgURI2XQ7/q4LmAVj24dLS1v4dZ5Rpcb1CMCgjB/T
	IYahtxFko0niCgdPa9ca3bHx4TONB5JcG1wCNEvtBTO4Tp16LjjY1o9M/g3YQF2fn4CAoJttzIXS3
	sKPp8rM004LesafWmelZUC9YcTYqGbDc9QUWBjlTzElP7oy6w1ypglRXZmIJNRg5Wlem02Xs3RSlo
	tWsLa6le058WyGjsJXoaxoEIoB7KouAsgecGt9k/Ct8ytBHXf+w2o3fNK4FU5vy8dqbK+4JjJMZsw
	/FibSzfffFNnkWEsHAYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtapj-00050K-4A; Tue, 12 Feb 2019 16:22:55 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtapf-0004zx-Oc
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 16:22:53 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 2625E803A;
 Tue, 12 Feb 2019 16:23:00 +0000 (UTC)
Date: Tue, 12 Feb 2019 08:22:47 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190212162247.GK5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212074237.2875-6-lokeshvutla@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_082251_845312_23B408E3 
X-CRM114-Status: UNSURE (   7.74  )
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
Cc: Nishanth Menon <nm@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, marc.zyngier@arm.com,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> +Example:
> +--------
> +The following example demonstrates both interrupt router node and the consumer
> +node(main gpio) on the AM654 SoC:
> +
> +main_intr: interrupt-controller0 {
> +	compatible = "ti,sci-intr";
> +	interrupt-controller;
> +	interrupt-parent = <&gic500>;
> +	#interrupt-cells = <4>;
> +	ti,sci = <&dmsc>;
> +	ti,sci-dst-id = <56>;
> +	ti,sci-rm-range-girq = <0x1>;
> +};

Can you describe a bit what the "ti,sci-dst-id" is above?

These IDs seem to be listed at at [0] below, but is it really a property
of the hardware? Or is it some enumeration of SoC devices in the firmware?

Regards,

Tony


[0] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/irq_dsts.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
