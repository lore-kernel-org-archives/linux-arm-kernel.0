Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D1C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:27:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B465F218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HzAeCDnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B465F218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6BFtTopgd2RwFF8erbtwtrMMGPgxu88oJ1mUPncfRHo=; b=HzAeCDnYErmOGK
	98aRGM4iQIR8vosKAgOTIJH5mTgf8ZANpFwYfWm1qa9XwipwH4FddxUOnb9/TgoB6oc9/xPKWsFIE
	TYqhBEOFY4CFY2IrfMh2+c3Kx9WsqxKwM/YU4aT9NnYKdBXSF4Ifb4buqzf/AeLiq4fv8dMLUcE3V
	RC8cbH//2Z8x1VBW363FC+t0XAJ18jcpNI4Msta8aXDRq3j0dop/EbQyvCvFZRCNqPtfd/zRYzpeZ
	WLqw5A1smELik1TTnY1pe1eygmLgT74EIL1PksIPmrOJo9WhTneIll4w02aIKxvLMOOsns1dYiyDP
	VGGdUWMkMBIW5tU9YQgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnN3m-0005Hb-4A; Sat, 26 Jan 2019 12:27:42 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnN3i-0005H5-Je
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 12:27:40 +0000
Received: from [192.168.123.67] ([84.118.159.3]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikE1-1hJhCN2AQf-00czju; Sat, 26
 Jan 2019 13:27:26 +0100
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-efi@vger.kernel.org
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <496259a6-f277-77b3-e5d2-7d45b4f515c7@gmx.de>
Date: Sat, 26 Jan 2019 13:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
Content-Language: en-US
X-Provags-ID: V03:K1:q9SGswfxyQ80dLnMY097vFG30NWQswX7uUTj8cxDldYKTrgRXJx
 PL1XDP2FSd1o2buHHGcjcyvHB9gOxHgvG7JZ2DP9JzdEqEuvjHpAIAYb+OFDza4P06uMYbs
 PwklLESrbbJ6qFftVptUvQXepXB+sadAX8iOFMzQ8z9/m+pJYAxGZ8OAWzwziwWk/KhzCHy
 7NVNf/TKNcK5E9loCed9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6I27/M+JPyE=:KZHz9qmMRmQlnCiac80FV8
 YjwpQ7PDCOBi7rg3iWHQQp5dYzPZBfOcjgjH6j3kUDKSWzDh7Wd3W5YV8NWBh6/keMKxUXws5
 72IOUkebOgB9lD6yV5QCnQKx2cQ8d2BFxB4u9kTy0lubHJD/9obBiPQKJVO6n70SO/Ggg2u47
 gtLtErYF+2/e1c1Qje5gvRSQILL01cb5xLRKIXtgm4dxQ93YO55XzMQ6ClJYEQqyb/yK+KnNS
 CdakddRKeVj3EawPuQlCuAYgeZcwjY+ufvTRLuAIANh7JWdVndnp5MOeSTL6QKxcdjx48EyG7
 iww+9IEsCefUu1Ymw4F3YOhC1mLfBRMNPG4SkNlMmEP8mfuGWY8snx4htlzkvTIl421WHP2tY
 N+A575eTtH8zVJbbJmHYyhx9oan0h8bdaLCOoV0aGiVDBxwHdYb6cotRDV+0PYU3gVl5dHcLx
 gbWQCl1bHHjn5otB7HfpFzj3Oh9zZEe5ZSzHEwROE/ywtC8o9to0ghZNACGvQmOlaWMU4Rspp
 7npcRBAdWUGlsgiqcORAl4KYSkDVb1URACFWeAYb9tGf1XVjM0fdy9WTkwZlVkLDAEErdbn04
 qaVPiLqE93z+krXvlA6I/WXoCQnbxiHXt2QOyXQgvibtYDyw+bNmeLFLu8WNEi3D0UWM0/nP3
 2bEHxC9MxAt3k2pJxXhdscIXE98zTK5EXBgZD24cl+EfTEcTW6zQtpsdtY/MayidERjUQhspK
 AKyFPYnHN2AOEnep1w8B4iqcrPdC7ZP+VBsvcnfgH1P6HP9qdK5HFTmpIxphd66br3fHmvCui
 vhJ+ftUpytYfrMrR6ytirJl/RpBsZR4Upvve4FMsI2cPEmmQkeDqq9f/QLMB2FDkD8IRkJ2aG
 pMJoOLbQXcnjyiUqtNDCgrFDBzoBud+4jRPeQEqWSz2xJsQEgCo8dy5mZgmMBMzRO6NAgdJaV
 MT1kw3d75Ug==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_042738_948807_5442E0BB 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: mark.rutland@arm.com, will.deacon@arm.com, Alexander Graf <agraf@suse.de>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/26/19 11:22 AM, Ard Biesheuvel wrote:
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

NAK

This patch breaks EFI booting with any known U-Boot release.

You are a contributor to an alternative open source firmware (EDK2).
Could you, please, share test results for EDK2.

Best regards

Heinrich

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
