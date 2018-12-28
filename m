Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97354C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630DE20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHXYa5Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630DE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=frjo7fHxopvlikTanRg6OqsZY1s0A+QALVccsCUQPy0=; b=GHXYa5VfgZtE4r
	WjSe+lUBSGII0oGTotpj6RWWayqrwnM2mdPqWI8wJH2+igdYh0UBxTRwovKT556WdUE52ohhlaeNa
	M/74aTTmC85mpRb9YXDvUV4PEWaqxuXf5SxunQ4mYUcmLKZ/gR+O4qsjuOLUt4UKWNt/D3toS1cc5
	L3pt5SzXpKzPpumG5Ju5yNfctCohamV3hzRxhFAViQYSonsJoFS4u6ODEVBpX8WHIfHjme0wOF88+
	NrjqQBsxQomexcO8lqox2MyN6lZu8HcqDjWmC59wRxzo3WlrgpyfoNKyhKshV14zq8ih15+HR5TWv
	CAMAeIDeiorEFBvr3kmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcs9j-0007e4-I1; Fri, 28 Dec 2018 13:26:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcs9Z-0007ck-Oa
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 13:26:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C35A78;
 Fri, 28 Dec 2018 05:26:04 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F4143F675;
 Fri, 28 Dec 2018 05:26:03 -0800 (PST)
Date: Fri, 28 Dec 2018 13:25:57 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
Message-ID: <20181228132557.GA12018@e107155-lin>
References: <20181221181149.6708-1-sudeep.holla@arm.com>
 <c22dacbe-ddc9-04c7-cda8-100dcbe0e70b@axentia.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c22dacbe-ddc9-04c7-cda8-100dcbe0e70b@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_052617_798702_48CF624F 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 06:46:12PM +0000, Peter Rosin wrote:
> On 2018-12-21 19:11, Sudeep Holla wrote:
> > Most of the legacy "gpio-key,wakeup" property are already replaced
> > with "wakeup-source". However few occurrences of old property has
> > popped up again, probably from the remnants in downstream trees.
> > Almost all of those were remove couple of years back.
> >
> > Replace the legacy properties with the unified "wakeup-source"
> > property introduced in the commit 700a38b27eef ("Input: gpio_keys -
> > switch to using generic device properties")
> >
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Why is this not v3?
> Why did you drop all the tags you already got?
>

Sorry for that, I intentionally dropped Acks from maintainer who would
merge and add their sign-offs, but I dropped yours accidentally.

> Acked-by: Peter Rosin <peda@axentia.se>
>

Thanks.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
