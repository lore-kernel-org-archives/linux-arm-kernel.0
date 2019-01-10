Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98418C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE68214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pU8cJA0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE68214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IM9eo/6KrkUuU9lPUiUxwV2U9Ey71E+01QPbhWTjMTY=; b=pU8cJA0cii1Z0u
	XiTY7ct98D6gXpo09Oc00FdEYGYge2ucQfml33g6Hbi2Ez9o69NXcp6mSo0Ff/QkVRvZe/nKKts+e
	dpJuuHlTiNLAL1h0MzAzCaUl06oPl3bvEJtNTVoDIzRd9xYeZD3JJO1iY6uXz7eLsNtIk661Qe9Fq
	6hv+2JOiqW1airdn6UajFeTZSDQaR648RgIRMFZgWcmvdtu1kZevflT+gByD4u1LI6GY2tnmLzmAX
	V0WKaWmPd3U52TX8QUyOQrr7sI/89G4KXzd78VpYE3Je8BbxU3AWqk+/Grh1pyJb/MCZ5lfW1UMBX
	lLjQlc1HOhKD8Uia5ZPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheyu-0004sZ-Dw; Thu, 10 Jan 2019 18:23:04 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheyr-0004s4-7h
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:23:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC323A78;
 Thu, 10 Jan 2019 10:23:00 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2763F694;
 Thu, 10 Jan 2019 10:22:57 -0800 (PST)
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
Date: Thu, 10 Jan 2019 18:22:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181211183634.GO27375@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_102301_288785_4DADFC56 
X-CRM114-Status: GOOD (  21.95  )
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
 baicar.tyler@gmail.com, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

(CC: +Tyler)

On 11/12/2018 18:36, Borislav Petkov wrote:
> On Mon, Dec 03, 2018 at 06:05:58PM +0000, James Morse wrote:
>> ACPI has a GHESv2 which is used on hardware reduced platforms to
>> explicitly acknowledge that the memory for CPER records has been
>> consumed. This lets an external agent know it can re-use this
>> memory for something else.
>>
>> Previously notify_nmi and the estatus queue didn't do this as
>> they were never used on hardware reduced platforms. Once we move
>> notify_sea over to use the estatus queue, it may become necessary.
>>
>> Add the call. This is safe for use in NMI context as the
>> read_ack_register is pre-mapped by ghes_new() before the
>> ghes can be added to an RCU list, and then found by the
>> notification handler.

>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 366dbdd41ef3..15d94373ba72 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -926,6 +926,10 @@ static int _in_nmi_notify_one(struct ghes *ghes)
>>  	__process_error(ghes);
>>  	ghes_clear_estatus(ghes, buf_paddr);
>>  
>> +	if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
> 
> Since ghes_ack_error() is always prepended with this check, you could
> push it down into the function:
> 
> ghes_ack_error(ghes)
> ...
> 
> 	if (!is_hest_type_generic_v2(ghes))
> 		return 0;
> 
> and simplify the two callsites :)

Great idea! ...

.. huh. Turns out for ghes_proc() we discard any errors other than ENOENT from
ghes_read_estatus() if is_hest_type_generic_v2(). This masks EIO.

Most of the error sources discard the result, the worst thing I can find is
ghes_irq_func() will return IRQ_HANDLED, instead of IRQ_NONE when we didn't
really handle the IRQ. They're registered as SHARED, but I don't have an example
of what goes wrong next.

I think this will also stop the spurious handling code kicking in to shut it up
if its broken and screaming. Unlikely, but not impossible.

Fixed in a prior patch, with Boris' suggestion, ghes_proc()s tail ends up look
like this:
----------------------%<----------------------
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0321d9420b1e..8d1f9930b159 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -700,18 +708,11 @@ static int ghes_proc(struct ghes *ghes)

 out:
        ghes_clear_estatus(ghes, buf_paddr);
+       if (rc != -ENOENT)
+               rc_ack = ghes_ack_error(ghes);

-       if (rc == -ENOENT)
-               return rc;
-
-       /*
-        * GHESv2 type HEST entries introduce support for error acknowledgment,
-        * so only acknowledge the error if this support is present.
-        */
-       if (is_hest_type_generic_v2(ghes))
-               return ghes_ack_error(ghes->generic_v2);
-
-       return rc;
+       /* If rc and rc_ack failed, return the first one */
+       return rc ? rc : rc_ack;
 }
----------------------%<----------------------


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
