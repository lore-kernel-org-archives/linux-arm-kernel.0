Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D31FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB6720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0g5H9+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB6720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hlMOAdixXv3JmmZ/DmLTe9Fmfkfet/3VtkrRF/4PTRQ=; b=O0g5H9+UJY/iab
	yzjtDK9RGQa9PQ3aH0f5Szhz1ONFYCdo8tkvrh9uo3ZLT6fxYSEHojnALtk8xUaNMkmH7vPPtq/AS
	pXZCBkVPCkNiUUcuJxYuVCVvAfPu3uZs3RM+w1qeSfQpdCTIva5FUaWBlqgajXHXXIldnZyDclvrA
	gJBs4M32d+dHzgW3PtEcWHIWtwFsg6RaHf7xFaAN1+KlN+Z/lbOf2ePH4Fq6A8V2y3Vi3xvHhwd+I
	mev/3R02zJCciDtOyRyelGbYSygY5hzxIeIRTm+Let/xfrRz94PceDvBIKkisXyqj+XhrKt7+jNQC
	A7Hd2QnXZ6tIekUSBMiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwKM-0006H5-H7; Fri, 11 Jan 2019 12:54:22 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwKI-0006FO-4m
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:54:20 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 70367209BD; Fri, 11 Jan 2019 13:54:13 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1B084206A7;
 Fri, 11 Jan 2019 13:54:13 +0100 (CET)
Date: Fri, 11 Jan 2019 13:54:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used
 as IRQ controller
Message-ID: <20190111135413.73dad0b2@windsurf>
In-Reply-To: <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
 <20190107164210.3ecf37e8@windsurf>
 <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_045418_318587_486EEC81 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: Josh Cartwright <josh.cartwright@ni.com>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Nava kishore Manne <navam@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>, Borsodi Petr <Petr.Borsodi@i.cz>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Shubhrajyoti Datta <shubhraj@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Linus,

On Fri, 11 Jan 2019 10:54:20 +0100, Linus Walleij wrote:

> My stance is that the driver is responsible of enabling and managing
> runtime PM for its hardware block(s).
> 
> Runtime PM in the core should only be added if the core needs to
> be aware about it, such as is the case when e.g. a block device
> needs to drain its write buffer before going to runtime sleep.
> 
> I fail so see why the GPIO core need to be aware about this.

In this very same thread at
https://www.spinics.net/lists/arm-kernel/msg600515.html, you kind of
proposed to handle this in the core in fact :-) Though indeed you said
that the core could provide helpers.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
