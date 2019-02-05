Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51615C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:23:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D05D217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDBSOYAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D05D217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2/QMNcKmcCdDo7DhpItOM1HxEBM8K+tLGHhJ9YfYjAI=; b=LDBSOYABmXTW01
	NrhVlNTz9cuGI/jdGAorHDj2hqCwd3zV+DeFlGvZM4gkaurDoWsVp2q6ETx4reM8z4MAtX+AvXKU9
	2GaiSN5NxziKyzCQ9OG+0AnyIAPSkL50hOuPVoNIhcSQmLJwFXEvKIlNBIwiaEGXBD4ZavEtPJynt
	PUirkTkdRwAueQK6H8qex0/xnB79FRSVTtKIo05U6bEjrF0Xit6q5citpR1fMoQDujeTYp4UpJf7y
	lOd/AujLYCsn8o240zHkMxldOsd6jhs8cZgzY6hCwbo3bh8ZNgHZxs4iuYSoaMkJN5+vwn5EdcQ+7
	u49lEuljI73xNSOfZOdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grA3W-0006uj-EQ; Tue, 05 Feb 2019 23:23:06 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grA3S-0006uN-9u
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:23:04 +0000
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A4AC960004;
 Tue,  5 Feb 2019 23:22:58 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Remi Pommarel <repk@triplefau.lt>, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/2] Fix espressobin ethernet support on mainline u-boot
In-Reply-To: <20190128200728.17747-1-repk@triplefau.lt>
References: <20190128200728.17747-1-repk@triplefau.lt>
Date: Wed, 06 Feb 2019 00:22:58 +0100
Message-ID: <87ef8l95wt.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_152302_494009_D2874956 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Remi,
 
 On lun., janv. 28 2019, Remi Pommarel <repk@triplefau.lt> wrote:

> This patchset fixes ethernet and mv88e6341 switch support on espressobin
> board when bootloader does not initialize needed registers.
>
> This patchset should be applied along with pinctrl fixes from [1] which
> have been merged in next branch of linux-pinctrl tree.
>
> [1] https://lkml.org/lkml/2018/12/21/507
>
> Remi Pommarel (2):
>   arm64: dts: armada-3720-espressobin: Configure RGMII and SMI pins
>   arm64: dts: armada-3720-espressobin: Set mv88e6341 cpu port as
>     RGMII-ID
>

Both patches applied to mvebu/dt64

Thanks,

Gregory

>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 7 +++++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 5 +++++
>  2 files changed, 12 insertions(+)
>
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
