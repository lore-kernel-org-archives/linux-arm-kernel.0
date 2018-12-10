Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10397C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:41:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EB420880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nlRF4pHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EB420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JiPCjJRq4JfIXffujg6durJii83gpfzdigFQ7/BSzF0=; b=nlRF4pHc5DAp/S
	i70sgI431lwRGk9NnC0s8RGqeO3fTZTRld3Pdw203d3hf09R1BQN2V67etVQgNVnCenKP6f4FIE6P
	dApXq/cX6zg4mB816ZBYePX9sYtM/SIgeqU6hyniuPttRnOOmaezhCQTfJbLhVfeE0V1oiNIjdMge
	RXz5RqNrmLRs6UFKkPU9zK+Yx0RfV/FV+0pjri3Qj4LL3GqTaZb04l6NW/z1zlcJ8J3su5cqgR0ar
	1j3c19jZZ4ZRmfFgKb0N2Wcs7STxle2YK0xuwQohUwnKRp8IOcDxr5+pShNercWN47SYhbX3EC9dt
	LCyGo2hf8KiIkKrEfOzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJw2-0003Zb-24; Mon, 10 Dec 2018 11:41:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJvq-0003Lg-OW
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:41:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 775D215AB;
 Mon, 10 Dec 2018 03:40:51 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FC043F6A8;
 Mon, 10 Dec 2018 03:40:49 -0800 (PST)
Date: Mon, 10 Dec 2018 11:40:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 00/12] arm64: Paravirtualized time support
Message-ID: <20181210114047.tifwh6ilwzphsbqy@lakrids.cambridge.arm.com>
References: <20181128144527.44710-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128144527.44710-1-steven.price@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_034103_353680_99944FAB 
X-CRM114-Status: GOOD (  17.00  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 02:45:15PM +0000, Steven Price wrote:
> This series add support for paravirtualized time for Arm64 guests and
> KVM hosts following the specification in Arm's document DEN 0057A:
> 
> https://developer.arm.com/docs/den0057/a
> 
> It implements support for Live Physical Time (LPT) which provides the
> guest with a method to derive a stable counter of time during which the
> guest is executing even when the guest is being migrated between hosts
> with different physical counter frequencies.
> 
> It also implements support for stolen time, allowing the guest to
> identify time when it is forcibly not executing.

I know that stolen time reporting is important, and I think that we
definitely want to pick up that part of the spec (once it is published
in some non-draft form).

However, I am very concerned with the pv-freq part of LPT, and I'd like
to avoid that if at all possible. I say that because:

* By design, it breaks architectural guarantees from the PoV of SW in
  the guest.

  A VM may host multiple SW agents serially (e.g. when booting, or
  across kexec), or concurrently (e.g. Linux w/ EFI runtime services),
  and the host has no way to tell whether all software in the guest will
  function correctly. Due to this, it's not possible to have a guest
  opt-in to the architecturally-broken timekeeping.

  Existing guests will not work correctly once pv-freq is in use, and if
  configured without pv-freq (or if the guest fails to discover pv-freq
  for any reason), the administrator may encounter anything between
  subtle breakage or fatally incorrect timekeeping.

  There's plenty of SW agents other than Linux which runs in a guest,
  which would need to be updated to handle pv-freq, e.g. GRUB, *BSD,
  iPXE.

  Given this, I think that this is going to lead to subtle breakage in
  real-world scenarios. 

* It is (necessarily) invasive to the low-level arch timer code. This is
  unfortunate, and I strongly suspect this is going to be an area with
  long-term subtle breakage.

* It's not clear to me how strongly people need this. My understanding
  is that datacenters would run largely homogeneous platforms. I suspect
  large datacenters which would use migration are in a position to
  mandate a standard timer frequency from their OEMs or SiPs.

  I strongly believe that an architectural fix (e.g. in-hw scaling)
  would be the better solution.

I understand that LPT is supposed to account for time lost during the
migration. Can we account for this without pv-freq? e.g. is it possible
to account for this in the same way as stolen time?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
