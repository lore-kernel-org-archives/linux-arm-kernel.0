Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:30:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92351218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRxPApwR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bE3CSH7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92351218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gHUgUt7NBXfzBVIWpqcFBZFmIBFULmc6HpT1My0ZQIc=; b=mRxPApwRFOvuhf
	IsJ/10HLvwKMDy2SuVGbYd8wtgLRVJLZzb7FZsWzFr6trDgr5x1s1aQoBbOECkez2RQ4bdlOarXM7
	t3KaQSZF9zJ/09nH2U6yembqNYNWUfQivTltk/yos1//Upjji9xhtQAj/NppP1NGyWgmaE8fotGmi
	gNliNUF/AdxfirRP50S9oLF4u5xuczT5tGKQOyoT+72wrDPncIr+tk/0pscnR05KsbhwDpS8cUH03
	6g4yT2Lg3NDLuBr9C1bX/hLa05eLT7H8giVv7BavoLOW8ShC3k3cCffoLuYCbiw9DxDCCeMxxd+qH
	BArt5QsnhieDhbFoA5eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCPz-0001W0-O0; Thu, 31 Jan 2019 13:30:11 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCPw-0000od-5U
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:30:09 +0000
Received: from zn.tnic (p200300EC2BCC5900651C63FB93E4C575.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5900:651c:63fb:93e4:c575])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70B9A1EC04FB;
 Thu, 31 Jan 2019 14:30:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548941406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=yFtcBfMUUYkbqUgRtVFMbksJPGrUCYA7EaPgerWMiYo=;
 b=bE3CSH7miRGbUMKqe9kS9V9fY72eYAYVC4BYNj6g4HVgDZEGDurkcQyvtjbvO6Gs9PYA6b
 Ti/SUND6wI2RU0OfxtXiAfGn5+pKzQPotfYHuVatH3pI/a1sf9ECtenz11UbkLVQuRaP1G
 PW5t8QUjBSyjxmHw0PNxsF5DiKErDRI=
Date: Thu, 31 Jan 2019 14:29:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Message-ID: <20190131132958.GJ6749@zn.tnic>
References: <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <20190111174532.GI4729@zn.tnic>
 <32025682-f85a-58ef-7386-7ee23296b944@arm.com>
 <20190111195800.GA11723@zn.tnic>
 <18138b57-51ba-c99c-5b8d-b263fb964714@arm.com>
 <20190129114952.GA30613@zn.tnic>
 <c17156e4-278b-7544-367e-50e928407a03@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c17156e4-278b-7544-367e-50e928407a03@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053008_372450_1821877D 
X-CRM114-Status: GOOD (  19.97  )
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
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Tyler Baicar <baicar.tyler@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 06:48:33PM +0000, James Morse wrote:
> If firmware has never generated CPER records, so it has never written to void
> *error_status_address, yes.

I guess this is the bit of information I was missing.

> There seem to be two ways of doing this. This zero check implies an example
> system could be:
> | g->error_status_address == 0xf00d
> | *(u64 *)0xf00d == 0
> Firmware populates CPER records, then updates 0xf00d.
> (0xf00d would have been pre-mapped by apei_map_generic_address() in ghes_new())
> Reads of 0xf00d before CPER records are generated get 0.

Ok, this sounds like the polled case. FW better have a record ready
before raising the NMI.

> Once an error occurs, this system now looks like this:
> | g->error_status_address == 0xf00d
> | *(u64 *)0xf00d == 0xbeef
> | *(u64 *)0xbeef == 0
> 
> For new errors, firmware populates CPER records, then updates 0xf00d.
> Alternatively firmware could re-use the memory at 0xbeef, generating the CPER
> records backwards, so that once 0xbeef is updated, the rest of the record is
> visible. (firmware knows not to race with another CPU right?)

Thanks for the comic relief. :-P

> Firmware could equally point 0xf00d at 0xbeef at startup, so it has one fewer
> values to write when an error occurs. I have an arm64 system with a HEST that
> does this. (I'm pretty sure its ACPI support is a copy-and-paste from x86, it
> even describes NOTIFY_NMI, who knows what that means on arm!)

Oh the fun.

> When linux processes an error, ghes_clear_estatus() NULLs the
> estatus->block_status, (which in this example is at 0xbeef). This is the
> documented sequence for GHESv2.
> Elsewhere the spec talks of checking the block status which is part of the
> records, (not the error_status_address, which is the pointer to the records).
>
> Linux can't NULL 0xf00d, because it doesn't know if firmware will write it again
> next time it updates the records.
> I can't find where in the spec it says the error status address is written to.
> Linux works with both 'at boot' and 'on each error'.
> If it were know to have a static value, ghes_copy_tofrom_phys() would not have
> been necessary, but its been there since d334a49113a4.
>
> In the worst case, if there is a value at the error_status_address, we have to
> map/unmap it every time we poll in case firmware wrote new records at that same
> location.
> 
> I don't think we can change Linux's behaviour here, without interpreting zero as
> CPER records or missing new errors.

Nah, I was simply trying to figure out why we do that buf_paddr check.
Thanks for the extensive clarification.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
