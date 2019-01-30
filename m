Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB8C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22DF20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5EcG8fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22DF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pf8Q/3/c6ljBpIEQ9WaEIzthyM8SeaBd0hv5osVqusU=; b=E5EcG8fSIUGe3s
	d0t7GOsNy9/17LFpJAePQY+hYMlkgFCiY1ByfZAKNxi2bPRzSUQemKP0NrL+/9j1O1Xdr2vRVrMzh
	+6mGBmWTowVJ+jz8yu7eXURz6hJ3x3w2KF2x3Ysx9PaJnOxLWT3A7MWqMFg6M+F9SAQaNMLnXUgWt
	+w0qE2J6Y1vywJoR8QAYvdrZ3Uw4HNYSZpctr0dO1Aikk5eq6Dp1PWPISJssH0WbD3RlH8Mv9Ch1R
	5aqTQMbgdggx+TptU5HNbiKq/qzyr/7t5Daz9xuXa8h/Hz5gpc9f5xODkXF/nS1MqfYmC8Ao6Fqll
	WuNPJxiVLH6u+kkBz8yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goljl-00052p-C2; Wed, 30 Jan 2019 09:00:49 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goljh-00051j-Tx
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:00:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F84A78;
 Wed, 30 Jan 2019 01:00:45 -0800 (PST)
Received: from [10.1.29.142] (e121487-lin.cambridge.arm.com [10.1.29.142])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91293F557;
 Wed, 30 Jan 2019 01:00:44 -0800 (PST)
Subject: Re: [PATCH 2/2] serial: mps2-uart: support combined tx and rx irq
To: linux-serial@vger.kernel.org
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
 <1548425597-38175-3-git-send-email-vladimir.murzin@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <db2e9569-b16a-2386-b482-d12275d06b86@arm.com>
Date: Wed, 30 Jan 2019 09:00:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548425597-38175-3-git-send-email-vladimir.murzin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_010045_972659_D6A51001 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/25/19 2:13 PM, Vladimir Murzin wrote:
> It turns out that some designs went for implementing only combined tx
> and rx interrupt, which is currently not supported by the driver.
> Support of combined irq is built on top of existent irq handlers and
> activated by the hint form device tree.
> 

It seems that folks combine rx, tx and overrun interrupts, so I'll send v2

Cheers
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
