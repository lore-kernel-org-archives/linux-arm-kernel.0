Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F5CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:14:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9EA2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZ4B0RDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9EA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Fue+ur4lsvPCa3HJ12fukPVKvttdDWUHFDxxuFEaso=; b=PZ4B0RDRZCSzuP
	nuHMdmmCeRETMxkwfWdpZiXLWtDjuw8s0NjxvcDAAdkUBh16a+pqxma908HutfgD+/zteDMQiCUi4
	VBMy+gYSBP3wtq9JBX5SFV/viVsIJXOFO156uOC7h1PCIxZFhr5cWcVVBoha1ZdO673MBpVluN9KC
	VoWlvgi6RphvRIy+mFpfPMFXDtAJQ9qSNKrO2e5eJ+vWYeMquUZxbugBNidu0O1AQw+T3QKm7prMt
	KiDaXNqN1ycdzs+UojHGsnEaWprJWyzCD4OUqZQzpGDX7Cno0aGOWNeBCyGb7g/sNEIVob7CAVw8i
	I3Iv3+xdvHIn4vRkF65g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzcy-0001xw-FY; Tue, 22 Jan 2019 17:14:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzcv-0001xQ-U9
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:14:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA4BA78;
 Tue, 22 Jan 2019 09:14:17 -0800 (PST)
Received: from [10.1.29.146] (e121487-lin.cambridge.arm.com [10.1.29.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8C63F6A8;
 Tue, 22 Jan 2019 09:14:16 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: mps2: use list instead of tuple for uart
 interrupts
To: Sudeep Holla <sudeep.holla@arm.com>
References: <1548066939-20880-1-git-send-email-vladimir.murzin@arm.com>
 <20190122115517.GB2656@e107155-lin>
 <3de06852-597b-06dd-a2d1-8b0830a7869f@arm.com>
 <20190122135105.GB18606@e107155-lin>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <49f2c64c-7b65-8ce2-89b2-0eeae2551c36@arm.com>
Date: Tue, 22 Jan 2019 17:14:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122135105.GB18606@e107155-lin>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_091417_973464_D60F3686 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/22/19 1:51 PM, Sudeep Holla wrote:
> On Tue, Jan 22, 2019 at 01:32:26PM +0000, Vladimir Murzin wrote:
>> On 1/22/19 11:55 AM, Sudeep Holla wrote:
>>> On Mon, Jan 21, 2019 at 10:35:39AM +0000, Vladimir Murzin wrote:
>>>> MPS2 UART requires dedicated interrupts for RX, TX and overflow, which
>>>> obviously should be expressed as a list. Current form uses tuple and
>>>> it has worked so far because NVIC has interrupt-cells equal to 1.
>>>
>>> Applied for v5.1
>>>
>>> Just saw couple of other instances that can be fixed to elsewhere in
>>> vexpress DTS files. Will post it soon with your reported by(though
>>> you didn't report them directly but this patch made me look around)
>>
>> Thanks!
>>
>> Now I'm wondering if it is something dtc can warn about?
>>
> 
> Not sure if it's already in place at different warning level.
> I generally try W=1 which itself produces quite a lot of warning, but
> yes good if this can be detected by compiler.

I did some experiments and it looks like it doesn't really distinguish
list from tuple, at least it happily accepts:

/dts-v1/;

/ {
	interrupt-parent = <&intc>;
	intc: interrupt-controller {
		interrupt-controller;
		#interrupt-cells = <2>;
	};

	node0 {
		interrupts = <1 2>;
	};

	node1 {
		interrupts = <1>, <2>;
	};
};


Cheers
Vladimir

> 
> --
> Regards,
> Sudeep
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
