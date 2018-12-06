Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC4020700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/46peNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC4020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h3KfdzN7IOlflQJwe0ObCnuf5+Ggx9E8QPNadN0GKLs=; b=E/46peNXtaxfte
	QklTQdSCpjnbpyiW+UvJQ+fDc18LjYVlzt/ZrjPD34fQ1F1iIcgZiSTJynTFGw6u4PhTQVG5CPuad
	ioqVwkMjPw3PLfjBuQ+CqWS95+8/qbtxZFC4Kayw1XX2q9PQRXhrdj+yCzOSe9Srys2Sz88qRTeCP
	67WVL0xvQxx8YrFyZSSH6b/ldHx4gGs6mw/2VXjV2Id4oC8QTZtFza/tBgprpzQEBbm/20PvlTwPH
	EncSLmrxdiwSayDod9nQr29ZIRN3anvJOrEHxQhnIl9FKx6YhdfJ6WKVRjhLo8gwneQeROHWA3fMF
	HFXOSCwkKezA01GcpJQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwLD-0003tu-Nv; Thu, 06 Dec 2018 16:17:31 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwL5-0003tH-TS
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:17:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C29C80D;
 Thu,  6 Dec 2018 08:17:13 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 A023E3F5AF; Thu,  6 Dec 2018 08:17:10 -0800 (PST)
Date: Thu, 6 Dec 2018 16:17:08 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 13/25] KVM: arm/arm64: Add kvm_ras.h to collect kvm
 specific RAS plumbing
Message-ID: <20181206161707.GL54495@arrakis.emea.arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-14-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-14-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_081723_950981_FAB410A1 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: Tony Luck <tony.luck@intel.com>, Fan Wu <wufan@codeaurora.org>,
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:06:01PM +0000, James Morse wrote:
> To split up APEIs in_nmi() path, the caller needs to always be
> in_nmi(). KVM shouldn't have to know about this, pull the RAS plumbing
> out into a header file.
> 
> Currently guest synchronous external aborts are claimed as RAS
> notifications by handle_guest_sea(), which is hidden in the arch codes
> mm/fault.c. 32bit gets a dummy declaration in system_misc.h.
> 
> There is going to be more of this in the future if/when the kernel
> supports the SError-based firmware-first notification mechanism and/or
> kernel-first notifications for both synchronous external abort and
> SError. Each of these will come with some Kconfig symbols and a
> handful of header files.
> 
> Create a header file for all this.
> 
> This patch gives handle_guest_sea() a 'kvm_' prefix, and moves the
> declarations to kvm_ras.h as preparation for a future patch that moves
> the ACPI-specific RAS code out of mm/fault.c.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

For the arm64 bits here:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
