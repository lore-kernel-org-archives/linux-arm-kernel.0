Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD9CC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B95218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LwhJhYj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B95218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ODN7J5MYtxq2kJU8PJ1pptFkkgXr0p60p+mXITBoznc=; b=LwhJhYj7aHG+kA
	h6MPJ596y4NXTSj43tatVLUpNsz0qMVm+C4GK5WAqL+iA+YfYMXvRiKTZQJffGtIq/orTjzRNVDt0
	POtG3PJGddfFPtdUjMaTLoFs05+CxaG4Her4JHxb0NMUvNXLnjSCl7X1ioX9Fz0/ZMCkKOcJbfNhc
	VvNGHC8ZXS/rcM/DGFgfnk/p0UGCZDh/yE/wZxBiasBfihV1u9jZC/Z7kzY6At27RBJKJfJMEQsxO
	GR5sYY8PSsSmvLtUxQR2X4RU61bUke+aLXvJ1El7Un4IVm95SZbUcY8mfnhFNWOkYKg737/lgqTyS
	XBFuaH8syohpSPqKz6VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouSr-0007gn-Dj; Wed, 30 Jan 2019 18:19:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouSo-0007gO-Jr
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:19:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D37080D;
 Wed, 30 Jan 2019 10:19:52 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B43A63F557;
 Wed, 30 Jan 2019 10:19:50 -0800 (PST)
Date: Wed, 30 Jan 2019 18:19:48 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
Message-ID: <20190130181948.GC18558@fuggles.cambridge.arm.com>
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_101954_662922_F5B50D71 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: mark.rutland@arm.com, linux-efi@vger.kernel.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Graf <agraf@suse.de>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,

On Sat, Jan 26, 2019 at 11:22:07AM +0100, Ard Biesheuvel wrote:
> The UEFI spec revision 2.7 errata A section 8.4 has the following to
> say about the virtual memory runtime services:
> 
>   "This section contains function definitions for the virtual memory
>   support that may be optionally used by an operating system at runtime.
>   If an operating system chooses to make EFI runtime service calls in a
>   virtual addressing mode instead of the flat physical mode, then the
>   operating system must use the services in this section to switch the
>   EFI runtime services from flat physical addressing to virtual
>   addressing."

I should probably go RTFM, but what does UEFI say about the attributes of
"flat physical addressing"? The wording above implies to me that it should
act as though the stage-1 MMU is disabled because it's described as an
alternative to virtual addressing.

If we move in a direction where we avoid calling SetVirtualAddressMap() by
default on arm64, isn't there a real threat that this firmware call will no
longer be validated? Do we need to worry about that?

Finally, Bjorn said that SDM850 is unbootable without this change. Why is
that?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
