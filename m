Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04183C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60DC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sucKmnrG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qe+Y4ZuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60DC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ypcH3oi5sKIidaUs2GssdTqdSVr16yHzg8IIqZR4fgw=; b=sucKmnrGm5MUux
	lCifKDfIjIIxf/Zihzi7JfvxnUzxs8VQEoLjvp25PQlFsc7v/vq1rGqNFpcwJVj1I3fiRrhIC1Ngn
	/T04B4JIFaleIn6YsGz7+GIvFUmkEao963i2WjIwxdd5AnUG7jC0DZGJ5vp752PJ3euWWxGM0OGg9
	q51hbhDSfj8XuetMM2qmkbvJKdhGtw27LmcziveMSoDkg4fR/Afcywa7KsMpoAn964mRkJR8ERyLL
	KdxyEDXQU+OYUIuANUkpNG5NYWkY9ONGB13x7jXZKr9M8Ssigig/K2hCQ4an/Kq9+KS/O8fnqC/va
	4feoxJVe4C8wKgRgtCRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX4H-0005N1-Og; Fri, 18 Jan 2019 16:32:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX3i-0003KV-Cd
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 16:31:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bNfdGocko+OEWFtIFYk7xVnpWazap8oQrgyHpyLTIDQ=; b=Qe+Y4ZuKNcPVpctOUYVAy079a
 xkrUx8fgUm94jSN/k4aTTZY5zSHtUHA/zWiJ2+vvq531myDgP0hcUxvqfPfItCCcll0YV4q7uDsPa
 oWV7/h9wJ78skF+gNz87daOkkTJF2Odmgu0zKlBK2xYT2chjEf0oOoua6kZLMNhXfU2Iiq5AKtyIe
 N5UoV9ZWgWk9jLyLc7bVWp0vCcc8J4nXC/uYV5+qW8ZydRGpCejQpO+VMngOOObr9gdXDurPsqzg9
 1i7PL6gyJCy+fTQNLhPtyniLyXSawwMpBZ/cbzu+HKSQUtwJ/FHgHDP7TEIRSeUHv4jW1ei1QY36e
 RtjdeCUIg==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWvm-0003d5-LK
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:23:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408CFEBD;
 Fri, 18 Jan 2019 08:23:41 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 756CA3F7BE; Fri, 18 Jan 2019 08:23:39 -0800 (PST)
Date: Fri, 18 Jan 2019 16:23:36 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v8 09/26] arm64: Unmask PMR before going idle
Message-ID: <20190118162336.GH118707@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-10-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546956464-48825-10-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_162342_855782_2689810D 
X-CRM114-Status: GOOD (  10.26  )
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

On Tue, Jan 08, 2019 at 02:07:27PM +0000, Julien Thierry wrote:
> CPU does not received signals for interrupts with a priority masked by
> ICC_PMR_EL1. This means the CPU might not come back from a WFI
> instruction.
> 
> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
> 
> Since the logic of cpu_do_idle is becoming a bit more complex than just
> two instructions, lets turn it from ASM to C.

I haven't checked all the call paths, so asking here: does the core code
normally call arch_cpu_idle() with IRQs off?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
