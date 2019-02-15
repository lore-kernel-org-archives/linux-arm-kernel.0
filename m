Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:54:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41356222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UsjQGt+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41356222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RE8TSMDm+1Kn1NrmdeksaBXpfLh3ejGV1+eq1mM1VpY=; b=UsjQGt+iizK5WVyfkMja6TSV+
	TMilrExuUJ1VEJ2Gf18G8ddYOOYTDcxcRhVJ1vRyOIwcGxWa7+sUzFE0yfgN5lNzfmhT7El7wMm0d
	0rMOkXZi0ORmBFvLCbP+ZdceiwyrNyi81ryGgYZpUrvvbW2FC2vciarwl7qiboy3mU65zHTR1Qy83
	10ONYytxRxtFP4tzZXt8CB8StCXxiRcVpKecRvnXFMbzCIH1uUYKoe+NsWndjUWRNuLye3dLozhEw
	MeHUDQvGnevDRPhi2WRqKGqCGNtkPDLRPqXpmznliBu7J1QRbItjKGRmIRoABfCbwTUeNmZ/1xb2p
	Aw8yQrdKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guidC-0007Yi-5v; Fri, 15 Feb 2019 18:54:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guid4-0007Xu-UY
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:54:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F9C2A78;
 Fri, 15 Feb 2019 10:54:29 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7BD3F589;
 Fri, 15 Feb 2019 10:54:28 -0800 (PST)
Subject: Re: [PATCH v4 03/12] arm64: Remove the ability to build a kernel
 without ssbd
To: Catalin Marinas <catalin.marinas@arm.com>,
 Andre Przywara <andre.przywara@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-4-jeremy.linton@arm.com>
 <20190130180415.0cab24e0@donnerap.cambridge.arm.com>
 <20190215182037.GI100037@arrakis.emea.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <7fa79e1a-3b35-520a-676b-031030108c50@arm.com>
Date: Fri, 15 Feb 2019 12:54:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215182037.GI100037@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_105435_072092_119BA801 
X-CRM114-Status: GOOD (  21.05  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, julien.thierry@arm.com,
 marc.zyngier@arm.com, ykaukab@suse.de, suzuki.poulose@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 Christoffer Dall <christoffer.dall@arm.com>, shankerd@codeaurora.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 dave.martin@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,


Thanks for taking a look at this:

On 2/15/19 12:20 PM, Catalin Marinas wrote:
> On Wed, Jan 30, 2019 at 06:04:15PM +0000, Andre Przywara wrote:
>> On Fri, 25 Jan 2019 12:07:02 -0600
>> Jeremy Linton <jeremy.linton@arm.com> wrote:
>>> Buried behind EXPERT is the ability to build a kernel without
>>> SSBD, this needlessly clutters up the code as well as creates
>>> the opportunity for bugs. It also removes the kernel's ability
>>> to determine if the machine its running on is vulnerable.
>>
>> I don't know the original motivation for this config option, typically
>> they are not around for no reason.
>> I see the benefit of dropping those config options, but we want to make
>> sure that people don't start hacking around to remove them again.
>>
>>> Since its also possible to disable it at boot time, lets remove
>>> the config option.
>>
>> Given the level of optimisation a compiler can do with the state being
>> known at compile time, I would imagine that it's not the same (though
>> probably very close).
>>
>> But that's not my call, it would be good to hear some maintainer's
>> opinion on this.
> 
> Having spoken to Will, we'd rather keep the config options if possible.
> Even if they are behind EXPERT and default y, they come in handy when
> debugging.
> 
> Can we still have the sysfs information regardless of whether the config
> is enabled or not? IOW, move the #ifdefs around to always have the
> detection while being able to disable the actual workarounds via config?

Yes, that is possible, but the ifdef'ing gets even worse. (see v3).

> Are the code paths between config and cmdline disabling identical? At a
> quick look I got the impression they are not exactly the same.

No, they do vary slightly. For debugging I would expect that the CONFIG 
disabled code paths to be the one that accumulates bugs over time. The 
command line options just force the runtime vulnerable/not-vulnerable 
decision, which should be the code paths in general use. For benchmark 
the run-time options are also a better choice because they don't have 
any 2nd order affects caused by code alignment/etc changes.

Maybe your implying the CONFIG_ options should basically force the 
command line? That both reduces the code paths, and simplifies the 
ifdef'ing.




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
