Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:36:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE6B21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JNrzscOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE6B21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CNeEwpD5p6KFQJHwKU6txZUtqR5g1LH9Lh9h2+TEFGQ=; b=JNrzscOv2vRoN4
	uoeKUM67b+KvM7Y+M6sPjHPstx+YxwdEGwLMHxiWd0z4JnaFkXEOtyWC94T4/WEO1nzvtjV6Mq4hM
	Mmkiqdqd9RqviDeTaojBmNVq9NZOh3islvQFqR8d9SnJ/9Y7H2oSZ5VerRMnbBnVm8oZyh/rUbEve
	HMDXjiZ6euN64UT5sjzWoPoV1JKtpRQqKqssXHcSByJzjH2WoXKXT5v+ypa7IGAu4/i1YPh6vvVbK
	bTbbIcaFZX1tgmsdb4F5WJcZckeetAOwnDWJa7ra4u0mx6ab0Qkkii2k4h1WqhcH4TDSvFCuHu2Oa
	Z6iApTvYnOx62Zt+ExDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmNOI-0007xj-Sd; Wed, 23 Jan 2019 18:36:46 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNOF-0007x2-2g
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 18:36:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D54EBD;
 Wed, 23 Jan 2019 10:36:42 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8BA3F237;
 Wed, 23 Jan 2019 10:36:39 -0800 (PST)
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <20190111174532.GI4729@zn.tnic>
 <32025682-f85a-58ef-7386-7ee23296b944@arm.com>
 <20190111195800.GA11723@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <18138b57-51ba-c99c-5b8d-b263fb964714@arm.com>
Date: Wed, 23 Jan 2019 18:36:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111195800.GA11723@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_103643_127167_0C445EED 
X-CRM114-Status: GOOD (  17.56  )
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

Hi Boris,

On 11/01/2019 19:58, Borislav Petkov wrote:
> On Fri, Jan 11, 2019 at 06:25:21PM +0000, James Morse wrote:
>> We ack it in the corrupt-record case too, because we are done with the
>> memory.
> 
> Ok, so the only thing that we need to do unconditionally is ACK in order
> to free the memory. Or is there an exception to that set of steps in
> error handling?

Do you consider ENOENT an error? We don't ack in that case as the memory wasn't
in use.

For the other cases its because the records are bogus, but we still
unconditionally tell firmware we're done with them.


>> I think it is. 18.3.2.8 of ACPI v6.2 (search for Generic Hardware Error Source
>> version 2", then below the table):
>> * OSPM detects error (via interrupt/exception or polling the block status)
>> * OSPM copies the error status block
>> * OSPM clears the block status field of the error status block
>> * OSPM acknowledges the error via Read Ack register
>>
>> The ENOENT case is excluded by 'polling the block status'.
> 
> Ok, so we signal the absence of an error record with ENOENT.
> 
>         if (!buf_paddr)
>                 return -ENOENT;
> 
> Can that even happen?

Yes, for NOTIFY_POLLED its the norm. For the IRQ flavours that walk a list of
GHES, all but one of them will return ENOENT.


> Also, in that case, what would happen if we ACK the error anyway? We'd
> confuse the firmware?

No idea.

> I sure hope firmware is prepared for spurious ACKs :)

We could try it and see. It depends if firmware shares ack locations between
multiple GHES. We could ack an empty GHES, and it removes the records of one we
haven't looked at yet.


>> Unsurprisingly the spec doesn't consider the case that firmware generates
>> corrupt records!
> 
> You mean the EIO case?

Yup,

> Not surprised at all. But we do not report that record so all good.



Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
