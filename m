Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D22206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdRqIw/g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLxsFTEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D22206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cb2oMPgEtkGFkkcuT8nZPNoBNjTAr+mBEvaEd1VRD+U=; b=RdRqIw/gHW2aHv
	X7KfliCOCViOBaze8WWgbKE+SAGlmP7BL4hR3jjnomg8ubw8K4P1miB8UPkzFmoSso9gLRfOSz+4j
	jLR/ksZ1IkDemNXG9gY6oGDPL+hCDahIbCQohV0srC1XAgSee8z1cIGNhlrwZ+AoDL/ZGgNS/WLSM
	JXHI8zXG5jeqtPq1/0g7Q1IKMfoGAMOcAsrTqPYTetQk7P0kj3VkJLyBpoC/5133TEpnTfB2Lyag5
	TWx4a5TYx05Kp9hscgKX21SAIebeqowLXFOOzQygoYG6LTjPkNQ7TrbTr4Cno24EG7rOTNidpQBEm
	ZVktMOPjkb6VhPRXBBCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvrP-00007o-98; Tue, 08 Jan 2019 18:12:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvrE-0008P9-VP
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:12:11 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ACBC12070B;
 Tue,  8 Jan 2019 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546971128;
 bh=ycyEbDy7tDUV+zF8jQhABMpd4RbKVUFLuSCweXzfHaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eLxsFTEEJO9uZtKk+KgSyZzUu20ijjxL/7tVvCbm2Sw3RYPugjdQosgCJFyv6HLUA
 H01J49FkWLqZUHIFcEkAWM+iS79TtZekj6iBn0uGk+p8bLKZCEbtsBdVJsvQg9/JbU
 fPjm2jRfH2aumEnuhyJgIWC1Bn+eeym9KWwdcbI8=
Date: Tue, 8 Jan 2019 19:12:06 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Message-ID: <20190108181206.GA3848@kroah.com>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_101209_438331_9BFD1B0A 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "Wiebe,
 Wladislav \(Nokia - DE/Ulm\)" <wladislav.wiebe@nokia.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 05:57:24PM +0000, James Morse wrote:
> >> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c b/drivers/edac/cortex_a15_l2_async_edac.c
> >> new file mode 100644
> >> index 000000000000..26252568e961
> >> --- /dev/null
> >> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
> >> @@ -0,0 +1,134 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 Nokia Corporation
> 
> (boiler plate not needed with the SPDX header)

Not true at all.  Copyright is not the same thing as an SPDX license
identifier in any way, shape, or form.  As-is, this is just fine.

Now I will not go into the issues where a "Copyright..." line really
means nothing at all anymore, as lawyers like to cargo-cult worse than
programmers do, so it's good to have those lines there just to make them
happy :)

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
