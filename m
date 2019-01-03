Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6543F2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MEWPBV3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6543F2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kUSedkD6DqukVg80YQ879h1TdcQbGy9tWILxnpmE1n8=; b=MEWPBV3NBXVArP
	vYS95E4//JTVPVwNp7y5Pp1Qj1Fu+COCFBBF+f04cV6fc8dICcLBdj4KJMGpjMhmGnYUjjeYobAOP
	t1uZvfiB89BfyVWj3lKW4XQogYs65WNJ/Ut9MslTfFWRtJJeHE1FwC+RoPwdBEw8fBV3QtH+AIqVF
	K/dmny8fCNmxGf835S8dn+MyGt9QCGGbhmmAj+njDCHjDd4YYHvhmuF74O6ndrfizkkznhDaWSqaX
	/V+IAx0d5EPvLe139lABmMtiEsNnLYgWd2jIdRFFijv3XLv2hh9HoX96XyWAqIyBIZ//ha5pSgMG8
	oQ3Ck9HmYX3lSWSzQGoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf60D-0003uN-T6; Thu, 03 Jan 2019 16:37:49 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf60B-0003u0-Az
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 16:37:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A77A15AD;
 Thu,  3 Jan 2019 08:37:46 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38C763F5D4;
 Thu,  3 Jan 2019 08:37:43 -0800 (PST)
Date: Thu, 3 Jan 2019 16:37:40 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190103163740.GC3529@e103592.cambridge.arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103004921.1928921-2-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_083747_376788_CAF44B4E 
X-CRM114-Status: GOOD (  20.13  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, mlangsdo@redhat.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, shankerd@codeaurora.org,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ykaukab@suse.de,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> There is a lot of variation in the Arm ecosystem. Because of this,
> there exist possible cases where the kernel cannot authoritatively
> determine if a machine is vulnerable.
> 
> Rather than guess the vulnerability status in cases where
> the mitigation is disabled or the firmware isn't responding
> correctly, we need to display an "Unknown" state.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 9605dbd4b5b5..876103fddfa4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -495,6 +495,7 @@ Description:	Information about CPU vulnerabilities
>  		"Not affected"	  CPU is not affected by the vulnerability
>  		"Vulnerable"	  CPU is affected and no mitigation in effect
>  		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
> +		"Unknown"    	  The kernel is unable to make a determination

Do some of the "Unknown" cases arise from the vulnerability detection
code being compiled out of the kernel?

I wonder whether at least the detection support should be mandatory.
sysfs is not very useful as a standard vulnerability reporting interface
unless we make best efforts to always populate it with real information.


Also, does "Unknown" convey anything beyond what is indicated by the
sysfs entry being omitted altogether?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
