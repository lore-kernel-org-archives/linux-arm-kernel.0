Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E94C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:36:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2983320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EVKo/mI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2983320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pYdr7Sh99xThP/wfKctoyBHK1aHklllnbhuLmifRfSM=; b=EVKo/mI+Z7Q5su
	pPdGlHfAxwCtlmlO4WO/jdKosjzrzcvHszddWsV13SifpxO49XsmLUm2h7EvGTdxQGDU9PutMenSG
	EmHKKQpS+nIhlCdeZ9Q+nGrH9fConErc3iaEeK5g50GUG+HnzCHlT4LGVyZRruZ1vsRD9nw6k/7Ij
	KtDDnyPegCcENHUuixWvbJuupqVNXc3/xo5mdBadH13gNJAht1uaJP9pO8dCeEUnC4gt3rpgDzWzh
	RQbubrFr7hAg8gXHRX7f9TlbtUZGnAnClNT1Nqk6PkDIL/5ZBrYHNquZhim8QoM5eGxLz58tzk8vX
	lqY9Tbdml1QBQRnm3U+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpY3x-0002fh-QY; Fri, 01 Feb 2019 12:36:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpY3u-0002fJ-OD
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:36:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828A980D;
 Fri,  1 Feb 2019 04:36:50 -0800 (PST)
Received: from [10.1.25.162] (e121487-lin.cambridge.arm.com [10.1.25.162])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA8C3F59C;
 Fri,  1 Feb 2019 04:36:47 -0800 (PST)
Subject: Re:
To: Souptick Joarder <jrdr.linux@gmail.com>
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
 <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
 <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
Date: Fri, 1 Feb 2019 12:36:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_043650_792746_2F3D09CF 
X-CRM114-Status: GOOD (  14.79  )
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
Cc: Michal Hocko <mhocko@suse.com>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 rppt@linux.vnet.ibm.com, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/1/19 12:32 PM, Souptick Joarder wrote:
> On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> Hi Souptick,
>>
>> On 1/31/19 5:54 AM, Souptick Joarder wrote:
>>> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>>
>>>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
>>>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>>>>
>>>>>> Remove duplicate headers which are included twice.
>>>>>>
>>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>>
>>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>>> Any comment on this patch ?
>>>
>>> If no further comment, can we get this patch in queue for 5.1 ?
>>
>> I'd be nice to use proper tags in subject
>> line. I'd suggest
>>
>> [PATCH] ARM: mm: Remove duplicate header
>>
>> but you can get some inspiration form
>>
>> git log --oneline --no-merges arch/arm/mm/
>>
>> In case you want to route it via ARM tree you need to drop it into
>> Russell's patch system [1].
> 
> How to drop it to Russell's patch system other than posting it to
> mailing list ? I don't know.

https://www.armlinux.org.uk/developer/patches/info.php

Vladimir

>>
>> [1] https://www.armlinux.org.uk/developer/patches/
>>
>> Cheers
>> Vladimir
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
