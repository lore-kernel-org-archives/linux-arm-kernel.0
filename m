Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1858C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919A620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAQcY9OL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="0fZQ7Ctp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919A620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bs02WO2j3meSEpDeIRQp+hhKx7M6GvPx1CBh5/j4eRk=; b=LAQcY9OLSnaOZfyNmXbV9hu1R
	cILaCd3K5Jgmp7twCO1f5EtcX5uJ9UyXZGwwtqK+rHY8pRumXWJGH5qSLNEnLxBlMGGcE4lsvass+
	I2IhjvoX0y2tKoVo26GLC6PWnv+noGyCngVe7q3GXWkMT+1hk7m63ODk/b9IL8w6Kt3Swca8T+AHP
	Rj7Trh19v/57Fk/Ow62a+4N5sEXDYp+TURBWnrwuqtBvQO8IxTZQD2j/Bejgp3v5Irusl4HVyJ1Td
	uqcjtjMjRPQ+ybWGhOvwwWGrQKdkOLBvQHaag/2q8HaAPSZLY4GNVs4VEkJd4O2QrrNxpYJA5B2Ag
	kCRqGbTSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV9Uq-0000GZ-NS; Fri, 07 Dec 2018 06:20:20 +0000
Received: from mail.kapsi.fi ([2001:67c:1be8::25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV9Um-0007TX-3B
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 06:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jXSqUtn2VG/YoSbZWvqgwiGbIdy2mVav2I9+iQYs+58=; b=0fZQ7CtpYSP2qWNlOTISJx/+0w
 NvUpyorY22BCqm61brUjx6wF4OKbBjcnb0etiu+CSsP1y22Z2YHeDNIzOB0enRKUt4xvfDWcbMbOH
 7HWx0qtsCUDOPXwLIix9VnFJtJqpskaeN0RL3S9ter0umFO1v/dq4A7HpgvMdmr51nnRkFGE2YqEL
 uqkaeThDJsry9/pT9/afGlXf4esQLpPLHdeh/MkyTVHGx2G0tnq4E8uvx4ip9K65nPyzB5lpX7Mhc
 jA5SNPZMN0iVGuO7oa6uNPMQ0+ltLsk7aqD5QYDWQqX0jdId7uZKrNP/6LTZNH7/mhtmQOv4pWi+q
 ZDf+nP3g==;
Received: from [121.244.166.165] (helo=[10.24.44.196])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1gV9UR-0006MP-Ns; Fri, 07 Dec 2018 08:19:55 +0200
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
To: Jassi Brar <jassisinghbrar@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <4f7a4211-47ee-1114-0974-a3b402178106@kapsi.fi>
Date: Fri, 7 Dec 2018 11:49:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 121.244.166.165
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_222016_476341_1B13D41E 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07/12/2018 11.26, Jassi Brar wrote:
>> I thought that I could also mitigate 2) by busy looping in the TCU driver,
>> but it turns out that that doesn't work. The reason is that since we are
>> in atomic context with all interrupts disabled, the mailbox won't ever
>> consume any new characters, so the read pointer in the circular buffer
>> won't increment, leaving me with no condition upon which to loop that
>> would work.
>>
> So you want to be able to rely on an emulated console (running on a
> totally different subsystem) to dump development-phase early-boot
> logs? At the cost of legitimizing busy looping in atomic context - one
> random driver messing up the api for ever. Maybe you could have the
> ring buffer in some shmem and only pass the number of valid characters
> in it, to the remote?
> 

I would like to note that this is the one and only console interface 
that exists on these systems, for both development phase and production. 
Other UARTs are not externally accessible on the systems, or they are 
comparatively difficult to access as they aren't intended to be used as 
consoles in the system design. The combination of hardware and firmware 
implementing the console is black box from software's point of view 
(similarly to any other UART HW). The interface has also been fixed at 
an early system design phase, as there are many operating systems 
running on these boards, each with their own drivers.

Cheers,
Mikko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
