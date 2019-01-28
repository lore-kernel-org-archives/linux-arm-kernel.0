Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E09BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:21:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8152171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/76f/FJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kRSFtxiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8152171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=av8BZZI7b9wEpzWHMJnwURmWUPFhKP7evGVLdBLmfT8=; b=o/76f/FJh2JlfG
	oePehVocF9V8Vpr+SBN5jdXJwoGrKUtLbwX69XHavTDGAvUrKL5lO1bWmJ3Wq/98NlmEvZSKUbh0e
	8sRSDlepNlUzGZsG9nZQccJgpY45yWCmzXm+EREjHUcXOHYcK3DqxQm58yIggKtfdqZMUUzRpR4ip
	wZJzo94vBDIyNVveeZMJQQuRTZ3Z96/94IYnocB5Xb3YylLm5bGc+wDSVFtp7dlB/gxaXQhvYMvgT
	ezG2QWPVXW2xdBEqdy8J5luiuAP0IL9Y84GU+yDGpkcT1cdr0JlgDlBHkQ8TPToOYs2s/vpqjz7wF
	DUy0jagMHFg7fecT89Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goDPX-00038d-Hj; Mon, 28 Jan 2019 20:21:39 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDPU-000388-FP
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dTwi/trjnEqoD15lnK4zVR01WHPHZ76gAiAnWhjM/0E=; b=kRSFtxiSI2dD7m6j/Uw9jFAXDr
 EMVfeo/wjC1roKlWTZtmIFTs4j4rfsrSHRFmtJvPOdiGMmmajuz7ULRqtosyLsoRxaG3PhUk/vBWa
 q3xn4E3h/ReZxzZhmI3KDKJYY29OwO+N+gqTNK0ic3B8Iy9UswAGOpyj5ZsFSnpGZI4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1goDPN-00038E-E2; Mon, 28 Jan 2019 21:21:29 +0100
Date: Mon, 28 Jan 2019 21:21:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH 2/2] arm64: dts: armada-3720-espressobin: Set mv88e6341
 cpu port as RGMII-ID
Message-ID: <20190128202129.GA11826@lunn.ch>
References: <20190128200728.17747-1-repk@triplefau.lt>
 <20190128200728.17747-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128200728.17747-3-repk@triplefau.lt>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_122136_665090_3C691E8B 
X-CRM114-Status: GOOD (  10.05  )
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
 Jason Cooper <jason@lakedaemon.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 09:07:28PM +0100, Remi Pommarel wrote:
> The mv88e6341 ethernet switch needs the cpu port control register to be
> set with TX and RX internal delay in order to work.
> 
> This fixes ethernet support on system booted via a bootloader that
> has not already configured this register (e.g. mainline u-boot, or
> vendor u-boot compiled without ethernet support).
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Looks sensible

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
