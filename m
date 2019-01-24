Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:17:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5EB218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMLFXCCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5EB218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rxri5sZUl/TwC8R3weBUVdPmzRZAoyIJU0i1iwMHUgo=; b=HMLFXCCLOUsAbt
	nTqcn1RratvZca5y0bj58rAVafID1l4Z8yNQ1rXSpezNy0MZmYvdPMOuGh2njvdbna7LpKPMFOBOq
	dEKmWsjQHq4ufQy2da+foJA6GqZXS9L8OPGBgNUyEtJ+5BvMbJTgf4PiODZNLPqc6Q1RmRPgB1aKW
	Ygr6sSH79spylw1XoZGamhD8UgO4cerW6VmHUYjLVb3HAAGBS6IvcgTSBLXpA9Q9wUb8pQlYnCIGH
	kYoBvPoFn99Z+74BuQpuzfOBCowdYsb4TY3X/tWkd4kb3qA85cvlncePnWi6dSlYbhVhshgGdaZVr
	teCdKkATFX5uMyPj6sxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhhE-0006KE-Ch; Thu, 24 Jan 2019 16:17:40 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhh7-0006Ji-EQ
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:17:38 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id A5B4A80C3;
 Thu, 24 Jan 2019 16:17:40 +0000 (UTC)
Date: Thu, 24 Jan 2019 08:17:29 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Message-ID: <20190124161729.GO5720@atomide.com>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213135845.3965-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_081733_519352_34212105 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux@armlinux.org.uk, bcousson@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181213 05:57]:
> The ethernet works in kernel only if we use some binary u-boot from the
> past which have support for KS8851.
> 
> The u-boot sources are not available for this mysterious u-boot image
> people tends to hold on... Mainline u-bott does not have ethernet support
> for sdp4430 and if we use that the ethernet is not working.
> 
> After some debugging I have managed to get the ethernet working with
> mainline u-boot while not breaking the networking with the case when we
> boot with the mysterious binary u-boot.
> 
> Basically we were missing bunch of pinmux settings and the 'magic'
> gpio_138 handling in kernel.

Applying into omap-for-v5.1/dt thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
