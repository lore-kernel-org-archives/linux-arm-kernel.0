Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E1C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:51:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F4720684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d+cUsqDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F4720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4/GjOquU6UPQBE3xISlkXzgawxiqtKwulqNYZQpw9F4=; b=d+cUsqDnG/5F0I
	xPBA02kBuCxF7DMzrIyTHwiWvNYKGYuwFhtNbu/MSzcCCbV/AGzwHTL2VUCS7HQPeAOjcQi3+j7Ke
	LKXJOoUVQMfEHtRWny5eV442VS2tFAV6tKdpqlwiHmlX6tOiRyqgjc7x5tS7bxUEbIQkqJ3UM9vMV
	omlfIEc9Vf+x/FAqpNN5wrY7fAtePSm/kGtQvWy2BtfqCm1wiBG7z7U7yEPxDqVB3InznsJt3HYki
	s+UDjx/XLU00iNpT1KPgLvTHN/mCswqAOWMqpUmwNGNxpYLlloZUI/dlbMiR1c0yiykJqoBkReSfD
	0RGU+gJVGvL3Cy44Zdzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwSO-0005u2-M8; Tue, 22 Jan 2019 13:51:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwSL-0005ti-GL
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:51:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0FD1EBD;
 Tue, 22 Jan 2019 05:51:08 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582B93F614;
 Tue, 22 Jan 2019 05:51:08 -0800 (PST)
Date: Tue, 22 Jan 2019 13:51:05 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH] ARM: dts: mps2: use list instead of tuple for uart
 interrupts
Message-ID: <20190122135105.GB18606@e107155-lin>
References: <1548066939-20880-1-git-send-email-vladimir.murzin@arm.com>
 <20190122115517.GB2656@e107155-lin>
 <3de06852-597b-06dd-a2d1-8b0830a7869f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3de06852-597b-06dd-a2d1-8b0830a7869f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_055109_547436_B448D1D1 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 01:32:26PM +0000, Vladimir Murzin wrote:
> On 1/22/19 11:55 AM, Sudeep Holla wrote:
> > On Mon, Jan 21, 2019 at 10:35:39AM +0000, Vladimir Murzin wrote:
> >> MPS2 UART requires dedicated interrupts for RX, TX and overflow, which
> >> obviously should be expressed as a list. Current form uses tuple and
> >> it has worked so far because NVIC has interrupt-cells equal to 1.
> >
> > Applied for v5.1
> >
> > Just saw couple of other instances that can be fixed to elsewhere in
> > vexpress DTS files. Will post it soon with your reported by(though
> > you didn't report them directly but this patch made me look around)
>
> Thanks!
>
> Now I'm wondering if it is something dtc can warn about?
>

Not sure if it's already in place at different warning level.
I generally try W=1 which itself produces quite a lot of warning, but
yes good if this can be detected by compiler.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
