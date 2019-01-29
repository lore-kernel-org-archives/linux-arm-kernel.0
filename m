Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A008D214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TFEn0YQm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oOKT8xnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WoXVqc17ecWaEl2tKc7Hfp2L0Br5zgaHR7sOWKPLrU0=; b=TFEn0YQmdZ3DXg
	pXTSUx7BZHuIqGYe5Y4SOZSfP1uJksL0QgXj1xt3XLIfjUG2971Ek32Ej/NZrjUw49yz9s2fzijOk
	HaB+Z4xYJiUQlAo4SqjqKfUsLMsCNIYyZkVH43bfMkx1J/JHu7Y1Hzl7QXcCCyufUe2ZqIo91OVSv
	OUoFh4sj1ciEl9D+LRdF970qfnxA4paC8mebVNdZiquVjP8WB0XNG9ONdwIB7JOySHera8jzkyDeE
	QO3A8ska9dnkHDR8RLsVx/0px15JRDr7uWFpRCaPP0Y6VmYq00EcHLqn+qkDp0+sUu2ZwN5Q60pD9
	0F1OqYvskJ9FKqZQNW8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRuE-0006OI-L3; Tue, 29 Jan 2019 11:50:18 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRuA-00066k-L3
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:50:16 +0000
Received: from zn.tnic (p200300EC2BCC5400A93DC78EB3841B4D.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5400:a93d:c78e:b384:1b4d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 729541EC0573;
 Tue, 29 Jan 2019 12:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548762604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=LCYrgx75yodWyZGmEPOpeqX5RHV1kjJgal/khS6fssg=;
 b=oOKT8xnvwyl/iMtxbVhzpSstiZI7BSD6aEqdH4UwzCWdmTm7tNTs91fJWT1uE48qnARN/S
 9iAhuef5li3aXBvKyFR1DRuIecWmJuweZgmLDNDGGaPvsTSpuDSR/zKPUkPN8veu5SFWld
 ANDiqurv7CQ7J5GcL13qPob/ohl4/Hw=
Date: Tue, 29 Jan 2019 12:49:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Message-ID: <20190129114952.GA30613@zn.tnic>
References: <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <20190111174532.GI4729@zn.tnic>
 <32025682-f85a-58ef-7386-7ee23296b944@arm.com>
 <20190111195800.GA11723@zn.tnic>
 <18138b57-51ba-c99c-5b8d-b263fb964714@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18138b57-51ba-c99c-5b8d-b263fb964714@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_035015_005865_AF1A6F95 
X-CRM114-Status: GOOD (  18.42  )
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

On Wed, Jan 23, 2019 at 06:36:38PM +0000, James Morse wrote:
> Do you consider ENOENT an error? We don't ack in that case as the
> memory wasn't in use.

So let's see:

        if (!*buf_paddr)
                return -ENOENT;

can happen when apei_read() has returned 0 but it has managed to do

	*val = 0;

Now, that function returns error values which we should be checking
but we're checking the buf_paddr pointed to value for being 0. Are
we fearing that even if acpi_os_read_memory() or acpi_os_read_port()
succeed, *buf_paddr could still be 0 ?

Because if not, we should be checking whether rc == -EINVAL and then
convert it to -ENOENT.

But ghes_read_estatus() handles the error case first *and* *then* checks
buf_paddr too, to make really really sure we won't be reading from
address 0.

> For the other cases its because the records are bogus, but we still
> unconditionally tell firmware we're done with them.

... to free the memory, yes, ok.

> >> I think it is. 18.3.2.8 of ACPI v6.2 (search for Generic Hardware Error Source
> >> version 2", then below the table):
> >> * OSPM detects error (via interrupt/exception or polling the block status)
> >> * OSPM copies the error status block
> >> * OSPM clears the block status field of the error status block
> >> * OSPM acknowledges the error via Read Ack register
> >>
> >> The ENOENT case is excluded by 'polling the block status'.
> > 
> > Ok, so we signal the absence of an error record with ENOENT.
> > 
> >         if (!buf_paddr)
> >                 return -ENOENT;
> > 
> > Can that even happen?
> 
> Yes, for NOTIFY_POLLED its the norm. For the IRQ flavours that walk a list of
> GHES, all but one of them will return ENOENT.

Lemme get this straight: when we do

	apei_read(&buf_paddr, &g->error_status_address);

in the polled case, buf_paddr can be 0?

> We could try it and see. It depends if firmware shares ack locations between
> multiple GHES. We could ack an empty GHES, and it removes the records of one we
> haven't looked at yet.

Yeah, OTOH, we shouldn't be pushing our luck here, I guess.

So let's sum up: we'll ack the GHES error in all but the -ENOENT cases
in order to free the memory occupied by the error record.

The slightly "pathological" -ENOENT case is I guess how the fw behaves
when it is being polled and also for broken firmware which could report
a 0 buf_paddr.

Btw, that last thing I'm assuming because

  d334a49113a4 ("ACPI, APEI, Generic Hardware Error Source memory error support")

doesn't say what that check was needed for.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
