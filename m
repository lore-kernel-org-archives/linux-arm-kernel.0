Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A819C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9D62148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zng238Si";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d8h5YH72";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bXxPqVyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4M4xG3pao/H78zpgZpARUPGRH/2jMdjc6YN9v3GizFU=; b=Zng238SihH7zMjFXkin2kK9Qc
	aG+8dj82hPnRDLbi12beGwHJT0r0zhM2Ova4GGtmC/4RFW4WJuVfOX1LWX46y6YBjKoCmikm1ZN0F
	VcJjNUaTZeeQYqHMFYnmRG6pVYj+ey82vbZj+gdZbzsTLblkCwLCCCb/pUINuTljW3jU5m08scCR5
	Kpr39TdcJGgeD+n+xCwD1OsKfYTDHxMCgLvFe530lLldFSZdW0AKlqi9gBP9P2P+LswbsHbgE8BE7
	nFyhZ2jpNHQzhvXFOw+lJ1AyuBuvJwl0i/0Vs4lM9eX0jTC0zy3XF2yKLcqc27pSgAkqG4H1M7EIR
	XJ7dTLm8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBIq-0006Md-1P; Mon, 28 Jan 2019 18:06:36 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBH7-0003gQ-7E
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:04:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 33DFA60C81; Mon, 28 Jan 2019 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548698686;
 bh=dB58iaWK6JFWXKaQUXSYuZPu3lfrUtbdeWKryL2/ivc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=d8h5YH720n6272b1eO9UhjkeF6FQ4OxmkkqhVlCT3Cb2bxc0BK1QrTGoEZ7XNPXul
 Y9w/o8n+P+Qj9JOk536UFUoXfewieySomjzlTArE2OzVo01qVOYjA1itMMQTQ/Cegk
 LRfB6gIPJIT6oAcFJwGIyI89cGY1bTSCaA5+oYHM=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 132A560A50;
 Mon, 28 Jan 2019 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548698684;
 bh=dB58iaWK6JFWXKaQUXSYuZPu3lfrUtbdeWKryL2/ivc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bXxPqVyzp8IYqSVukHy4luf7XqokXawXsh0ctjbsmMpmvO9l7gLw17wZo4OTHGNup
 Fg9rjjUaO4kzJo37bi5CZCqm9wJLCuMs3v+2pEZPs3afw5r/YBLX+X/bONqXjYvXpv
 QOWq/E+YIczrHMP7fx+OIEOlIoCi3j2tAWmDNwXQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 132A560A50
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-efi@vger.kernel.org
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <abc36cf9-4fa1-da12-bb94-34d850ae34ec@codeaurora.org>
Date: Mon, 28 Jan 2019 11:04:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100449_313364_3BBE45E9 
X-CRM114-Status: GOOD (  22.93  )
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
Cc: mark.rutland@arm.com, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 will.deacon@arm.com, Alexander Graf <agraf@suse.de>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/26/2019 3:22 AM, Ard Biesheuvel wrote:
> The UEFI spec revision 2.7 errata A section 8.4 has the following to
> say about the virtual memory runtime services:
> 
>    "This section contains function definitions for the virtual memory
>    support that may be optionally used by an operating system at runtime.
>    If an operating system chooses to make EFI runtime service calls in a
>    virtual addressing mode instead of the flat physical mode, then the
>    operating system must use the services in this section to switch the
>    EFI runtime services from flat physical addressing to virtual
>    addressing."
> 
> So it is pretty clear that calling SetVirtualAddressMap() is entirely
> optional, and so there is no point in doing so unless it achieves
> anything useful for us.
> 
> This is not the case for 64-bit ARM. The native mapping used by the OS
> is arbitrarily converted into another permutation of userland addresses
> (i.e., bits [63:48] cleared), and the runtime code could easily deal
> with the original layout in exactly the same way as it deals with the
> converted layout. However, due to constraints related to page size
> differences if the OS is not running with 4k pages, and related to
> systems that may expose the individual sections of PE/COFF runtime
> modules as different memory regions, creating the virtual layout is a
> bit fiddly, and requires us to sort the memory map and reason about
> adjacent regions with identical memory types etc etc.
> 
> So the obvious fix is to stop calling SetVirtualAddressMap() altogether
> on arm64 systems. However, to avoid surprises, which are notoriously
> hard to diagnose when it comes to OS<->firmware interactions, let's
> start by making it an opt-out feature, and implement support for the
> 'efi=novamap' kernel command line parameter on ARM and arm64 systems.
> 
> (Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
> used, given that the physical memory map and the kernel virtual address
> map are not guaranteed to be non-overlapping like on arm64. However,
> having support for efi=novamap,noruntime on 32-bit ARM, combined with
> the recently proposed support for earlycon=efi, is likely to be useful
> to diagnose boot issues on such systems if they have no accessible serial
> port)
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

I threw this at msm8998 (arm64), and it seem to work fine as far as I 
can tell.

For what it's worth:
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
