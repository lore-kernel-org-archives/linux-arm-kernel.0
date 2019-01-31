Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B198CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8320420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szWzRdzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8320420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NAMFZ0njvY5mkKxzvwQJBZwU+BbEDXVIoOlNuqpA3+4=; b=szWzRdzlhRYp3L
	C7JJ9lLFRUfDu8i+080/Gb7yaB2uiBpc7uKCTzKO2hvMX9e+rIoCkQpJ4arKgvQB4FW5/9yAVQQGT
	6x7o+bKyoVxlXRZ5ZCgQ3k7s93IXXDaPwo844Eyb1MCwjTao0klj+50uif7Ln0N/m8Cfl5eLI/EU8
	AhFXulqODwInQ/bL4jyRuotZk0wE8w+uMmFuGFkwxMMVqcL/wv+NVGzKEzB+/6PzohcIqWs6IHDIk
	VCr4Fu5Fm8Imf0K/9tEoiniyI/bwC0fn0s0QXk5vTyhDEgcqxUxggiFdzP/hfBlmjyh4gqtN+6XHw
	UhW45dfBvtzbQ3v4qgeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGY6-0005OR-Fk; Thu, 31 Jan 2019 17:54:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGXy-0005Kz-C7
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 17:54:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59DFEBD;
 Thu, 31 Jan 2019 09:54:41 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 806C13F59C;
 Thu, 31 Jan 2019 09:54:39 -0800 (PST)
Date: Thu, 31 Jan 2019 17:54:36 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 08/12] arm64: Advertise mitigation of Spectre-v2, or
 lack thereof
Message-ID: <20190131175436.1c24f7b8@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-9-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-9-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_095442_424741_D67E7BB5 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 12:07:07 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> We currently have a list of CPUs affected by Spectre-v2, for which
> we check that the firmware implements ARCH_WORKAROUND_1. It turns
> out that not all firmwares do implement the required mitigation,
> and that we fail to let the user know about it.
> 
> Instead, let's slightly revamp our checks, and rely on a whitelist
> of cores that are known to be non-vulnerable, and let the user know
> the status of the mitigation in the kernel log.

Yeah, this looks better, I was scratching my head about that
blacklist already.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> [This makes more sense in front of the sysfs patch]
> [Pick pieces of that patch into this and move it earlier]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> ---  arch/arm64/kernel/cpu_errata.c | 104 +++++++++++++++++----------------
> 1 file changed, 54 insertions(+), 50 deletions(-)
> 
....

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
