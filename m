Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3383CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:27:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C3D218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LblSf8Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C3D218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HYF0F/cibh6WTodVTaPHMf4jfj1PCrjlcjGchpdW6bo=; b=LblSf8HjiZ5Bgs
	AIu9AQcvYIZPA4H53k3PZU0vDBvPgbM1SeONlBlNWkhtLVpWwvFmXyKv2KDOkYp2SAbN8E1TZTGYz
	4OWJ/Bk+mFCNNN8FxYgRdhNwpeG7Ldn6M9K+kORUGfJZBNEesiSwVcBhrC1ChWQxcKKMARQmrxn7v
	WbLbDiAX3IKR/8gnJarXnlezrMEWaPkKmGrTAe2OdIXai/MptWs9l0lKJujCyVwRUjhooDz+iLHrE
	EPFWmnSBpMH1ykjCj8wLx220gVfgieIv9kX95DWlDlikh8UOCL58oSWpxzVDspGXY1cK7EAQVq9iJ
	cPCzz8lUnG7S3STFkHnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKQH-0006Yo-Pl; Wed, 06 Feb 2019 10:27:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKQE-0006Y8-Oo
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:27:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A705080D;
 Wed,  6 Feb 2019 02:27:12 -0800 (PST)
Received: from C02TF0J2HF1T.cambridge.arm.com (C02TF0J2HF1T.cambridge.arm.com
 [10.1.30.174])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75BF73F719;
 Wed,  6 Feb 2019 02:27:10 -0800 (PST)
Date: Wed, 6 Feb 2019 10:27:07 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v10 00/25] arm64: provide pseudo NMI with GICv3
Message-ID: <20190206102706.GA92291@C02TF0J2HF1T.cambridge.arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_022714_807531_4411B609 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, marc.zyngier@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

On Thu, Jan 31, 2019 at 02:58:38PM +0000, Julien Thierry wrote:
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 
> The patches depend on the core API for NMIs patches [2]. Both series can
> be found on this branch:
> git clone http://linux-arm.org/linux-jt.git -b v5.0-pseudo-nmi

I queued these patches in the arm64 for-next/core, on top of Marc's
generic-nmi branch:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms irq/generic-nmi

I'll push the changes out later today, once my tests finished.

Thanks for pushing this series through.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
