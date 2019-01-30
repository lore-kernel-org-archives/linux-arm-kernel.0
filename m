Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88E2C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E0C21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rLO+VX32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E0C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PUBGt6CRkHVT4quvkjl4sAT7NKzCycEzyso4RjCb/qY=; b=rLO+VX32Wd0iHr
	m3X0R7bgGrdMaJ/P2tuCsGUCD2sGxX8RqjF05ttUNug2T7uscCkuMLq/rU7qdEhqlqwKpZoMDiE4N
	cFMLbUzNhiLnO9/LAoR8sXTzA8Un0w3jrkXkb0G4leRAtaNKx19h7QObC/vhln7Un/M9S9+Ym7AnU
	4L6oaRjKByX1Sb7SDwm4kCYoeunhkzjMG95EIRYohnn3+36nikcorifyzCNLWm09ikbwRxTwXEmj3
	zK7AeYijzNq0EyKicr3Teb2YQIrazg5U383ltAlBeJ0fYc+NwzKQk4SSSx/nxS4lEGtaxuJLvxzjP
	holQeHlPi2HBnnKYXC5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouCP-0000YK-IO; Wed, 30 Jan 2019 18:02:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouCM-0000Xt-56
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:02:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4217F80D;
 Wed, 30 Jan 2019 10:02:53 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935993F557;
 Wed, 30 Jan 2019 10:02:50 -0800 (PST)
Date: Wed, 30 Jan 2019 18:02:47 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 01/12] Documentation: Document arm64 kpti control
Message-ID: <20190130180247.15ab0577@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-2-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-2-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_100254_205815_8528F4A8 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: stefan.wahren@i2se.com, Jonathan Corbet <corbet@lwn.net>,
 julien.thierry@arm.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, linux-doc@vger.kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 12:07:00 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> For a while Arm64 has been capable of force enabling
> or disabling the kpti mitigations. Lets make sure the
> documentation reflects that.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt index
> b799bcf67d7b..9475f02c79da 100644 ---
> a/Documentation/admin-guide/kernel-parameters.txt +++
> b/Documentation/admin-guide/kernel-parameters.txt @@ -1982,6 +1982,12
> @@ Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
>  			the default is off.
>  
> +	kpti=		[ARM64] Control page table isolation of
> user
> +			and kernel address spaces.
> +			Default: enabled on cores which need
> mitigation.

Would this be a good place to mention that we enable it when
CONFIG_RANDOMIZE_BASE is enabled and we have a valid kaslr_offset? I
found this somewhat surprising, also it's unrelated to the
vulnerability.

Cheers,
Andre

> +			0: force disabled
> +			1: force enabled
> +
>  	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled
> MSRs. Default is 0 (don't ignore, but inject #GP)
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
