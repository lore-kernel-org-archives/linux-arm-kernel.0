Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57EC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:58:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A202133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OQD0++Uq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l6Ml0Ca/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A202133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yYXTsDgS/hBNCyd8MTtQwQ0RlBqYFnR60AhTXa1zsHA=; b=OQD0++UqSc4cND
	lqcjB2mBCmRDsYZwhnJvepF6jb5lxlp2D0j4gAjlIpBrn+SgcjcOwJ12h4J30kQOTQKSugojANEVo
	gyZA7lhnW85IFd0oQ04i2VAqVEuwJPM9+USSIk8C2CBy465hbgI3gS2Lxfhyoaf7fxgLxDXs+aoDn
	xWCI/vieZVwl9OYihYfC+OflU4uNAJEixm3qBWgjJGddf43xmR9sdRogYctozFHLoAtqwNnCNAQw4
	QIT19pHFw7lJGmVKtLGBVtXfvucfxWDAtUFQQAvDE7XR4NlMZCdJyErhEu9+DivPz+BrN9bB3qqEq
	uKne66+wgQ9NilbuL4kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2wY-0003WS-Gj; Fri, 11 Jan 2019 19:58:14 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2wV-0003Vl-60
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:58:12 +0000
Received: from zn.tnic (p200300EC2BCAC500F59AF9850531CFF6.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bca:c500:f59a:f985:531:cff6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D99B1EC08EA;
 Fri, 11 Jan 2019 20:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547236688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Rsih9Wi6EFS5Az6A/UXXcyQNg3m0CEQ5xqJvmIT7MTE=;
 b=l6Ml0Ca/7z/aJ/wsTQ03LER6SB60mDuzoR2xq033EmVsIf3BL5qQHRQXZ5rW7Uv/yzhnzU
 vnk9sycOv/UE8ZYw9J4lnwYXuiYH30h3fh5kQwMPIIcAjLW8cln63CxR+twji4ZXc1tj6A
 8zIaeqzH15zzC2J5hqZx4SZzxiJih+Q=
Date: Fri, 11 Jan 2019 20:58:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Message-ID: <20190111195800.GA11723@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <20190111174532.GI4729@zn.tnic>
 <32025682-f85a-58ef-7386-7ee23296b944@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32025682-f85a-58ef-7386-7ee23296b944@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_115811_379442_F6C008DF 
X-CRM114-Status: GOOD (  12.02  )
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

On Fri, Jan 11, 2019 at 06:25:21PM +0000, James Morse wrote:
> We ack it in the corrupt-record case too, because we are done with the
> memory.

Ok, so the only thing that we need to do unconditionally is ACK in order
to free the memory. Or is there an exception to that set of steps in
error handling?

> I think it is. 18.3.2.8 of ACPI v6.2 (search for Generic Hardware Error Source
> version 2", then below the table):
> * OSPM detects error (via interrupt/exception or polling the block status)
> * OSPM copies the error status block
> * OSPM clears the block status field of the error status block
> * OSPM acknowledges the error via Read Ack register
> 
> The ENOENT case is excluded by 'polling the block status'.

Ok, so we signal the absence of an error record with ENOENT.

        if (!buf_paddr)
                return -ENOENT;

Can that even happen?

Also, in that case, what would happen if we ACK the error anyway? We'd
confuse the firmware?

I sure hope firmware is prepared for spurious ACKs :)

> Unsurprisingly the spec doesn't consider the case that firmware generates
> corrupt records!

You mean the EIO case?

Not surprised at all. But we do not report that record so all good.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
