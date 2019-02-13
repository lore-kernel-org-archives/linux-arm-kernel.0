Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A300C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:32:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F062190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lh4rUHv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F062190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z6N+ZSsAdB3NuqnUvhZTsZ4rVWWAJrEhNvTIdz7p8TE=; b=lh4rUHv+5wueQC
	m1mnqT1jfgOWAjIj2jYK9otcX3bqTutPyHihw4W1gagA9xncwsmew8NplkGyKQFppzQJLAEq4/9Vx
	LJDa2qJ/pxuGKdtqAofTviL7WVM8S0lIjR7dInm8wpS39ZvZSAWCNxThtxNdaRfIhC4Z/QlxWbMBm
	InBfgWlD0kv93gEraROsNny15IY03EUTeMZ8VCsfJfyZdl+31v4alvFS7ET9hvnuMGAmj9EbgDEou
	a/2saC3DN31lJ3DcWR0UDVxMZ7TCHbhSYJWcdm6oFqdZXSFKeyICXlB24xMSNaJAk7D73qF4/4qI/
	yWw1cOzZc+ZyjSjHNXkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwWP-0001iB-IT; Wed, 13 Feb 2019 15:32:25 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwWK-0001h0-ME
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:32:23 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id A361080AE;
 Wed, 13 Feb 2019 15:32:28 +0000 (UTC)
Date: Wed, 13 Feb 2019 07:32:15 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190213153215.GT5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212163018.GL5720@atomide.com>
 <5b5d86b9-2aa7-718c-c1da-70bbf9bf589e@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b5d86b9-2aa7-718c-c1da-70bbf9bf589e@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_073221_158554_FC766DBD 
X-CRM114-Status: GOOD (  18.43  )
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

* Lokesh Vutla <lokeshvutla@ti.com> [190213 04:23]:
> Hi Tony,
> 
> On 12/02/19 10:00 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> >> +The Interrupt Router (INTR) module provides a mechanism to route M
> >> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
> >> +to be driven per N output. There is one register per output (MUXCNTL_N) that
> >> +controls the selection.
> >> +
> >> +
> >> +                                 Interrupt Router
> >> +                             +----------------------+
> >> +                             |  Inputs     Outputs  |
> >> +        +-------+            | +------+             |
> >> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
> >> +        +-------+            | +------+             |      controller
> >> +                             |    .        +-----+  |      +-------+
> >> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
> >> +        | INTA  |----------->|    .        +-----+  |      +-------+
> >> +        +-------+            |    .          .      |
> >> +                             | +------+      .      |
> >> +                             | | irqM |    +-----+  |
> >> +                             | +------+    |  N  |  |
> >> +                             |             +-----+  |
> >> +                             +----------------------+
> > 
> > Is this always one-to-one mapping or can the same interrupt be routed to
> > multiple targets like to the SoC and some coprocessor?
> 
> Yes, it is always one-to-one. Output of INTR can only be attached to one of the
> processor.

OK

> >> +Configuration of these MUXCNTL_N registers is done by a system controller
> >> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
> >> +controller will keep track of the used and unused registers within the Router.
> >> +Driver should request the system controller to get the range of GIC IRQs
> >> +assigned to the requesting hosts. It is the drivers responsibility to keep
> >> +track of Host IRQs.
> >> +
> >> +Communication between the host processor running an OS and the system
> >> +controller happens through a protocol called TI System Control Interface
> >> +(TISCI protocol). For more details refer:
> >> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> > 
> > Care to describe a bit why the interrupts need to be routed by a system
> > controller?
> 
> K3 architecture defines a heterogeneous system where multiple heterogeneous
> cores are serving its own usecases. Given that there are multiple ways in which
> a device IRQ can be routed using INTR, like either it can be routed to HLOS
> core(A53 int this case) or it can be routed to any other coprocessor available
> in the system(like R5). If every sw running in each co-processor is allowed to
> program this INTR then there is a high probability that one sw executing on one
> core can damage other heterogeneous core.  Mainly to avoid this damage the
> configuration of all the INTRs and INTAs are done in a centralized place(sysfw).
> Any user for programming its IRQ route should send a message to sysfw with the
> parameters. These parameters are policed by sysfw and does the configuration.

OK so maybe update the description along those lines saying it's
a shared piece of hardware between various independent SoC
clusters which may or may not be running Linux.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
