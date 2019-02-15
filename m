Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F50C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:20:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADE2222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QIuyXYVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADE2222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rnXWGWPDwftjcUMZ7udbiaSygb+eUzpLR3661kqwflE=; b=QIuyXYVwjZCHuO
	lsEY2ZseJRtpidAq9X1dbLkFtDTIjfXGnEzLMrq/WlnA8zCGCVsHHK4/w5HsAnxtOeKWzgW0L4tdM
	4Z7KHa0ZxiKJt08hMkWxK5lBZLNkcg6SEyz0hbfA3/E+zJaD2/zZzOoJJ/wE2od1LLiRXQMs1Ah5p
	2q5BwMWs3XjioPO71BolO8IUxBW09W8DtbtaN/37w+t7ddhxpAG4kj+VTl6/qM1mxe9EjwIUkACbK
	seCsL9J+LBcDOxeUO8NLLeG72TbjSfgI+SAoFNFqFQePxc6rVXykZ1ooxXXdCaL9iC/OstG8XkZhN
	cqeiW79nsNDlPi8/koag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gui6R-00080H-NI; Fri, 15 Feb 2019 18:20:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gui6O-0007zr-Qg
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:20:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899E0A78;
 Fri, 15 Feb 2019 10:20:43 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 DCE553F589; Fri, 15 Feb 2019 10:20:40 -0800 (PST)
Date: Fri, 15 Feb 2019 18:20:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v4 03/12] arm64: Remove the ability to build a kernel
 without ssbd
Message-ID: <20190215182037.GI100037@arrakis.emea.arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-4-jeremy.linton@arm.com>
 <20190130180415.0cab24e0@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130180415.0cab24e0@donnerap.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_102044_869383_5B2F3026 
X-CRM114-Status: GOOD (  17.39  )
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
 marc.zyngier@arm.com, ykaukab@suse.de, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com,
 Christoffer Dall <christoffer.dall@arm.com>, shankerd@codeaurora.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 dave.martin@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 06:04:15PM +0000, Andre Przywara wrote:
> On Fri, 25 Jan 2019 12:07:02 -0600
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> > Buried behind EXPERT is the ability to build a kernel without
> > SSBD, this needlessly clutters up the code as well as creates
> > the opportunity for bugs. It also removes the kernel's ability
> > to determine if the machine its running on is vulnerable.
> 
> I don't know the original motivation for this config option, typically
> they are not around for no reason.
> I see the benefit of dropping those config options, but we want to make
> sure that people don't start hacking around to remove them again.
> 
> > Since its also possible to disable it at boot time, lets remove
> > the config option.
> 
> Given the level of optimisation a compiler can do with the state being
> known at compile time, I would imagine that it's not the same (though
> probably very close).
> 
> But that's not my call, it would be good to hear some maintainer's
> opinion on this.

Having spoken to Will, we'd rather keep the config options if possible.
Even if they are behind EXPERT and default y, they come in handy when
debugging.

Can we still have the sysfs information regardless of whether the config
is enabled or not? IOW, move the #ifdefs around to always have the
detection while being able to disable the actual workarounds via config?

Are the code paths between config and cmdline disabling identical? At a
quick look I got the impression they are not exactly the same.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
