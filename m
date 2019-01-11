Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:09:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327A020652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CA/Dwh5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327A020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+to/3gyFNHiG1f8tUKRhrve8VtoctSOz8/kcRnpaP0=; b=CA/Dwh5+TQa5gA
	wx6Gwfy8PWZnaHjJ90xHW/iVuynx0eSLI13KiHXvc0VH1S7ozau7WayOCyZZZvZbFyzyB2wCqdX0b
	RmbyI+6kNKt3lczfTaWeAm+JJaoAX0daCDJnDvpEDXj3eXNMlNpyCGeUOMhJgVNTbGI+wvC2kpv9i
	tfTHCHedFCgMBOyWeHoOfEaKC/mOUAI9dwLW0VsiK/WfGjTtL135i7D+1M3JTXlaI8hhxzbI7iLiS
	enJuO1nGB0xe4u4JkBft/ssHGCn9k1tQSRkvj+wfeKy0rGfjiiz6m6EJv0Z7zhZd/eNvLfJITRFqg
	n+w+bPKGeK69smZz+fjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1FV-0005tL-Gv; Fri, 11 Jan 2019 18:09:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1FR-0005si-Vu
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:09:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1421596;
 Fri, 11 Jan 2019 10:09:33 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 487213F6CF;
 Fri, 11 Jan 2019 10:09:30 -0800 (PST)
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: Tyler Baicar <baicar.tyler@gmail.com>, Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <0939c14d-de58-f21d-57a6-89bdce3bcb44@arm.com>
Date: Fri, 11 Jan 2019 18:09:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_100938_178324_04FBF8A2 
X-CRM114-Status: GOOD (  24.76  )
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
 Dongjiu Geng <gengdongjiu@huawei.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

On 11/01/2019 15:32, Tyler Baicar wrote:
> On Fri, Jan 11, 2019 at 7:03 AM Borislav Petkov <bp@alien8.de> wrote:
>> On Thu, Jan 10, 2019 at 04:01:27PM -0500, Tyler Baicar wrote:
>>> On Thu, Jan 10, 2019 at 1:23 PM James Morse <james.morse@arm.com> wrote:
>>>>>>
>>>>>> +    if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
>>>>>
>>>>> Since ghes_ack_error() is always prepended with this check, you could
>>>>> push it down into the function:
>>>>>
>>>>> ghes_ack_error(ghes)
>>>>> ...
>>>>>
>>>>>       if (!is_hest_type_generic_v2(ghes))
>>>>>               return 0;
>>>>>
>>>>> and simplify the two callsites :)
>>>>
>>>> Great idea! ...
>>>>
>>>> .. huh. Turns out for ghes_proc() we discard any errors other than ENOENT from
>>>> ghes_read_estatus() if is_hest_type_generic_v2(). This masks EIO.
>>>>
>>>> Most of the error sources discard the result, the worst thing I can find is
>>>> ghes_irq_func() will return IRQ_HANDLED, instead of IRQ_NONE when we didn't
>>>> really handle the IRQ. They're registered as SHARED, but I don't have an example
>>>> of what goes wrong next.
>>>>
>>>> I think this will also stop the spurious handling code kicking in to shut it up
>>>> if its broken and screaming. Unlikely, but not impossible.

[....]

>>> Looks good to me, I guess there's no harm in acking invalid error status blocks.

Great, I didn't miss something nasty...


>> Err, why?
> 
> If ghes_read_estatus() fails, then either there was no error populated or the
> error status block was invalid.
> If the error status block is invalid, then the kernel doesn't know what happened
> in hardware.

What do we mean by 'hardware' here? We're receiving a corrupt report of
something via memory.
The GHESv2 ack just means we're done with the memory. I think it exists because
the external-agent can't peek into the CPU to see if its returned from the
notification.


> I originally thought this was changing what's acked, but it's just changing the
> return value of ghes_proc() when ghes_read_estatus() returns -EIO.

Sorry, that will be due to my bad description.


>> I don't know what the firmware glue does on ARM but if I'd have to
>> remain logical - which is hard to do with firmware - the proper thing to
>> do would be this:
>>
>>         rc = ghes_read_estatus(ghes, &buf_paddr);
>>         if (rc) {
>>                 ghes_reset_hardware();
> 
> The kernel would have no way of knowing what to do here.

Is there anything wrong with what we do today? We stamp on the records so that
we don't processes them again. (especially if is polled), and we tell firmware
it can re-use this memory.

(I think we should return an error, or print a ratelimited warning for corrupt
records)


>>         }
>>
>>         /* clear estatus and bla bla */
>>
>>         /* Now, I'm in the success case: */
>>          ghes_ack_error();
>>
>>
>> This way, you have the error path clear of something unexpected happened
>> when reading the hardware, obvious and separated. ghes_reset_hardware()
>> clears the registers and does the necessary steps to put the hardware in
>> good state again so that it can report the next error.
>>
>> And the success path simply acks the error and does possibly the same
>> thing. The naming of the functions is important though, to denote what
>> gets called when.

I think this duplicates the record-stamping/acking. If there is anything in that
memory region, the action for processed/copied/ignored-because-its-corrupt is
the same.

We can return on ENOENT out earlier, as nothing needs doing in that case. Its
what the GHES_TO_CLEAR spaghetti is for, we can probably move the ack thing into
ghes_clear_estatus(), that way that thing means 'I'm done with this memory'.

Something like:
-------------------------
rc = ghes_read_estatus();
if (rc == -ENOENT)
	return 0;

if (!rc) {
	ghes_do_proc() and friends;
}

ghes_clear_estatus();

return rc;
-------------------------

We would no longer return errors from the ack code, I suspect that can only
happen for a corrupt gas, which we would have caught earlier as we rely on the
mapping being cached.



Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
