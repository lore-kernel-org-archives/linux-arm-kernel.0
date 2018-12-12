Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557FEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:21:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D9220849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IlCwet20";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W35yfCzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D9220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a+9/ViNEUAy7Pk5X5yXynlA7OJPEgz4C8ooRvcfufmU=; b=IlCwet20+UCiou
	TJ0VYBHSPK1a2JP2vABXOP0lJxUZq098FFGr6qTMY7gmndD4ZKfXKjvvUkpsLOxZX1jbmvBlLtYKF
	eDASli5a6XN0sqbNn17589wvLzKr71pdzfQbJlJzBkoCSfi3JoKmwN0z1i6/29lbx5+JSh0jKUAso
	r9yUoD8n8utbuOFg4VaFKZF2qk/PC0rrk6aYCAKG9OiSi3UWH5WdHDSq5C5BmVIaQ1equhE0kDgEa
	cz6qny1QlZt2/6wHDM9z9iRKxF+2zACCpZF6Efekr6k/K/Sg7HnMzMXW79NxQw3aSGrlPvji8/wE6
	Xu7MzoNuznb0ePEdFJtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2aB-0006XH-Qj; Wed, 12 Dec 2018 11:21:39 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2a8-0006Wf-D3
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x944t8VhjvN3XbdKgWOBAoCRnXzI8LDRUuh+wGQfU6M=; b=W35yfCzPzyqSiVjzN43xBzqnP
 mQbKSB/X7n4/vRrYcbAyea4kWJKn0HB1FzVmpsm82EpUO2sE1+PLZ8T5fPAIPvDbiAM6W4S9WZs/c
 eyN41uZYRSdBOCtRnhTrFaOhrwQ3uegWtGe4a7By3h4JYQfCsf2U4GDlwnsbDstQI/B6A=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:59227)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX2Zt-0004LU-5U; Wed, 12 Dec 2018 11:21:21 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX2Zj-0005MU-HY; Wed, 12 Dec 2018 11:21:12 +0000
Date: Wed, 12 Dec 2018 11:21:06 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5] ARM: actions: Set possible CPUs from ncores
Message-ID: <20181212112106.GK30658@n2100.armlinux.org.uk>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
 <20181211080759.3150-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211080759.3150-4-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_032136_449629_85EB7E40 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 09:07:58AM +0100, Linus Walleij wrote:
> The codes figured out how many cores the SCU is reporting
> so let's say that these CPUs are usable.
> 
> Possibly this code is redundant to the device tree parsing
> code looping over the CPUs in arch/arm/kernel/devtree.c
> but most other platform do this and it looks coherent.

Maybe it's another cargo-cult issue - presumably the platform already
boots fine without this, so it is likely redundant.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
