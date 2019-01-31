Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F325C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A602085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TRn0qiwP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fXscU4ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A602085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lRU3rDFsXXsGRezXbYDsoGlnP+kUrG2ejk9AXTTEWhc=; b=TRn0qiwP2iAiAT
	3EOdXrslI3I3k9qpOQuj3MXRhn+zOp3KWrgK1f1PteqkkjwlJ4sDTdXVOnxTu6TOPOl3rkuLd1V6q
	IreYt9a8UKYKth3B5eOYVUQORRmT5gOtY6rOAlUXfHmaPcwtcZrx3HBZa8CQIW6LUjVqa8nVjLMhh
	e8uZAhw75T+f6bAy/knAVDwYUc1NlgcI1rRZjC3tKHbcwjejjntEAT8rQWh1CFlBkMo8CqfS/0lX8
	02v0qcZtQG8S9GnhlZZcj0UnIkju4pm55zEjMuF4nrWqGF6N+MHR/HM1lUyT/peDW2F/pvc2YTj7j
	3Mz2Awk91PsSD2Ey9yyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCYN-0004FE-Un; Thu, 31 Jan 2019 13:38:51 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCYK-0004Et-Mz
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:38:50 +0000
Received: from zn.tnic (p200300EC2BCC5900651C63FB93E4C575.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5900:651c:63fb:93e4:c575])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 191B41EC059E;
 Thu, 31 Jan 2019 14:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548941927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=N9ZfktBJAMGDaOqi63rNj6dpil8IUx1OGdlTeCh4s6w=;
 b=fXscU4eeC2ToGWv6EVxYT5WtmhOF8NW0lZM2/wfvSID9gZS0549ZoFEAJheQvCW+hl03Uj
 wfD84p+pgqW+Tl7C0OAylMfQ5Xd9zmT8Cyt/xLrjf9jDmxW5isLfbUA6QbTK6EZ+Ywtft6
 JzhH2T1j/SxhHenwGC/hy0GjIb2jDrs=
Date: Thu, 31 Jan 2019 14:38:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 20/25] ACPI / APEI: Use separate fixmap pages for
 arm64 NMI-like notifications
Message-ID: <20190131133842.GK6749@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-21-james.morse@arm.com>
 <20190121172743.GN29166@zn.tnic>
 <bee87ef4-60ae-d4a4-2855-159543072fc5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bee87ef4-60ae-d4a4-2855-159543072fc5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053848_901403_2C1D4BFD 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 06:33:02PM +0000, James Morse wrote:
> Was the best I had, but this trips the BUILD_BUG() too early.
> With it, x86 BUILD_BUG()s. With just the -1 the path gets pruned out, and there
> are no 'sdei' symbols in the object file.
> 
> ...at this point, I stopped caring!

Yah, you said it: __end_of_fixed_addresses will practically give you the
BUG behavior:

        if (idx >= __end_of_fixed_addresses) {
                BUG();
                return;
        }

and ARM64 does the same.

> We already skip registering notifiers if the kconfig option wasn't selected.
> 
> We can't catch this at compile time, as the dead-code elimination seems to
> happen in multiple passes.
> 
> I'll switch the SDEI ones to __end_of_fixed_addresses, as both architectures
> BUG() when they see this.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
