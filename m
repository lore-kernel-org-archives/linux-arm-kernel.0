Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5580C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D80A21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gOCV9cx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D80A21901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lUkqLmkgKmqZqxZywkZInEzTq9i5eY/rTl51xZ4mC1o=; b=gOCV9cx9tZrNF/
	uCjIBMOMFOE++dX/quJftqnqCchzlErGZF1rVfpifBnCk0rekX5vjo2MQpWqEKyMQPWmSXVnsBNjj
	Nuvi8CvaC8ApNbD328/DJk+78mFsVW6JaEWW3YCjpcm5USK+EW25ac5tpow2/IJfmOTqkW/AwVoiS
	ECOcXKbUMEYHbvu8mtJWLkWmjDoCkRW+Efmd/DMsIp/svN+xMX/AshTOyw7u7awPT7dhLt/YDUoOH
	v936yQsAI8xyWgZ8Gmtp1+LR3ywLw4yp4GLbCj43hGkhFHc5G3Tav8M9K9Cc4HQmWl506uh4rlsKT
	vyj77iE3vgwoUKcHLxzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjnl-00015C-Eo; Mon, 18 Feb 2019 14:21:45 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjnY-0000tJ-B0
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:21:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2D41650;
 Mon, 18 Feb 2019 06:21:31 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432EE3F589;
 Mon, 18 Feb 2019 06:21:14 -0800 (PST)
Date: Mon, 18 Feb 2019 14:19:25 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 00/37] ARM: davinci: modernize the irq support
Message-ID: <20190218141820.78bfaef5@why.wild-wind.fr.eu.org>
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_062132_386237_8A72BEE8 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 15:51:54 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> the irqchip drivers and moves them over to drivers/irqchip.

[...]

For the irqchip parts:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Please route this via the appropriate tree.

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
