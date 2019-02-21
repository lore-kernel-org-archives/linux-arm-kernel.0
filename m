Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:22:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224CA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YSV1yrJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224CA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tvKCL8jfbAd9+mxJY/F/1YKe3Z7wR2LdmKh4KXHG7Os=; b=YSV1yrJNDtvhoR
	lqISPQQIp0sNRmK9XwKROtmTy4vq2zPQj+DLhnR+w+rBfelU2B73pzAEqkCtHqh8PLuDHOdiNARPT
	s5c45Zuq9adsjjPjjEw7Pf+I6xsd04+AgHa4eXo5Jm9HaeddTPwQbMC3nn0gqwj9NvrhJoZd2Fbv5
	5jan2Qryuge2vFjWIiVH6nCpp65KWGSFR/R+VUicN5Iie86NaJKFNXFCn5uXDjWI3aJGeQd/9Aj/p
	w/dy7ovg1at39rpHqswn6vs50QF1Fk1uOv7c1T/JA49qpAOAr3QKidonGW5R2H0H+KbJY4VwKNtJ3
	CGyuNkYPyBYGSQOIw4ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwd4Q-0000cR-2R; Thu, 21 Feb 2019 01:22:38 +0000
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2
 (Red Hat Linux)) id 1gwd4L-0000bm-6A; Thu, 21 Feb 2019 01:22:33 +0000
Date: Wed, 20 Feb 2019 17:22:31 -0800
From: Darren Hart <dvhart@infradead.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v5 06/10] Platform: OLPC: Add XO-1.75 EC driver
Message-ID: <20190221012231.GC5838@wrath>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110175845.1203986-7-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 06:58:41PM +0100, Lubomir Rintel wrote:
> It's based off the driver from the OLPC kernel sources. Somewhat
> modernized and cleaned up, for better or worse.
> 
> Modified to plug into the olpc-ec driver infrastructure (so that battery
> interface and debugfs could be reused) and the SPI slave framework.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v4:
> - Chop off the reboot handler. Will be added back once it's clear how.
> 
> Changes since v3:
> - Introduce CONFIG_OLPC_EC symbol to enable parts common to this driver
>   and the X86 OLPC EC machinery.
> 
> Changes since v1:
> - Cosmetic style changes; whitespace, ordering of declarations and
>   #includes, remoted extra comas from sentinels
> - Count the terminating NUL in LOG_BUF_SIZE
> - Make olpc_xo175_ec_is_valid_cmd() return -EINVAL instead of -1
>   on error
> - Spell keyboard/touchpad in full for CHAN_KEYBOARD/TOUCHPAD messages
> - Use a #define for PM wakeup processing time
> - Log a message on unknown event
> - Escape logging payload with %*pE
> - Replace an open-coded min()
> - Correct an error code on short read
> - replaced PM callback #ifdefs with __maybe_unusedm SET_RUNTIME_PM_OPS
>   and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> - dev_get_drvdata() instead of a round-trip through platform device
> - s/unsigned char x/u8 x/ in olpc_xo175_ec_resume()
> - Use GENMASK() instead of 0xffff for the event mask
> - Replace cmd tx/resp rx buffers with structures
> - Turned suspend hint arguments into a struct, and tidied up the comment
> 
> Basically all of the above is based on the review by Andy Shevchenko.

Andy, I am happy to merge this series - but this patch includes a lot of changes
driven by your feedback. Are you satisfied with the changes, would you like to
add your Reviewed-by?

-- 
Darren Hart
VMware Open Source Technology Center

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
