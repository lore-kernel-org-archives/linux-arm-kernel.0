Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A273AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6F0205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JGE4a1mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6F0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4BnZyq4UKlcy/DKEKd/Hf4BrNJbfdJwsTzeVVgxxE/o=; b=JGE4a1mLBUOmdH
	qADhW04uwLgxva7mUZXShkojXXjlkHG97LsfnBpCKNc/MawSAhaRtppj2odvnmEA28hvJh79F2xIa
	5252+v29bhMORC9kS4ICFpo09jqcblePDW3i/DgnIcMBMXwYXBd7LyB2MJQJ8Uukqk0P86mn3uxDp
	yfF7jrNhVqTLIA0Xg3lX9tHciD1dNcyc1VJrIuCclosj1CJ+e/GwJ6XnJ+jEeNfvK8PUmO6SUeLf+
	ReNATI+xmfwipt8aWgD3s9vPQXIL1BhQw5XQrvVuKYe1fLtYyzMRIhh4iwM3qYo022HtFnyqx18yT
	CmBf9BzQqDYysgkLfftQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjoMp-0008P3-6L; Wed, 16 Jan 2019 16:48:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjoMa-0008KN-E4
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:48:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7696A78;
 Wed, 16 Jan 2019 08:48:23 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E5093F5AF;
 Wed, 16 Jan 2019 08:48:21 -0800 (PST)
Date: Wed, 16 Jan 2019 16:48:18 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kassey <kassey1216@gmail.com>
Subject: Re: arm64: copy_from_user access the last page of ddr has problem on
 4.14 kernel
Message-ID: <20190116164817.GG1910@brain-police>
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_084824_937958_32D8E5A6 
X-CRM114-Status: GOOD (  16.84  )
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
Cc: mark.rutland@arm.com, kassey@126.com, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[I'm due to get on a long flight shortly, so I've added LAKML and a few
others to CC]

On Wed, Jan 16, 2019 at 11:25:15AM +0800, Kassey wrote:
> Hi, Will and team:
> 
>    we met a issue when copy_from_user to access the last page of DDR
> on 4.14 kenrel, below is the detail steps,
>    can you help to suggest if there is know fix or debug something ?
> 
> 1. we mmap ( in userspace)  a region of  phy address that is not
> continous  but include the last page of ddr
> 
>   for example our ddr end is 0x200000000
>   the last page is fall in below addr:
>   0x1fffff000  to  0x200000000
> 
> 2. we using copy_from_user to copy these mmap address to kernel buffer
> 
> 3. and we find everytime when trying to copy_from_user  the last page
> in phy of ddr,
>     the dst kernel buffer is looks overwrite by some same patten start
> with "mmap" in this last page ,but the src in the last page of ddr is
> still correct.
> 
> is there any know issue for copy_from_user to accces the last page of
> phy ddr mmaped by userspace  ?

Not that I'm aware of. Are you using defconfig and can you reproduce the
problem with mainline (e.g. v5.0-rc2)? What exactly do you mean by:

  "the fst kernel buffer is looks overwrite by some same patten start with
  "mmap""?

Does the copy_from_user fail (what does it return?) or does it succeed but
the data copied appears to be junk? Is it deterministic? Could you share an
example of what the corrupted data looks like, please?

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
