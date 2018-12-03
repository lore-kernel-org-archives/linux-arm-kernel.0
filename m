Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880DDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3FB20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mkv2lRQT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mhH/6f/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3FB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CqQjfLItTX8nJOTV2YWZfpvaI5+FgNJqY3bDHIUzPCM=; b=mkv2lRQTH5LrWD34LKZmnQOhC
	JN0eM4lWiQsJ0SLY7Jyl2W7fpyjVtPmFQYcp+IluB/EpK/pjlfXC8XqtLJQHf/yKGYtmUbrJkilKY
	l2keEQvIRUlErzehK+UQjgeTFkMgr5xDth5CHNoEDnXKZALnSRLZTLg1WzsjuW2fRRiJRCUKWv8y3
	3jl6UoZU1Xf7vK31j/kSXDrDOW15gYV/rLbx7qvhLVbSX6BQn0yHhNbfVp7vmhZMniJlufpPLO5mb
	OYjhDpw9Ip3yAkw0YdraG+5daPDBuFVI7/LfLo9wsOmmuzSSOVl51V/Bmt8uqNTOyoIBDgpRiBFkD
	nSoVSpSkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTs4J-00050O-QM; Mon, 03 Dec 2018 17:31:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTs4F-0004yG-8P; Mon, 03 Dec 2018 17:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1543858295; x=1575394295;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=8TCu3Sd7qsPWvRMySkaqsG2A5lI5wsjaimKIPdz9VJI=;
 b=mhH/6f/UZFymljdyIzZLWFrVpg2pOhs6Qn809I9joPb0amexfGFoMZsj
 fUM+A53IOScemQ1cTFv0NW9Yg5TQMPOWPo9RH5KVdj/2l7Ru9wl4Iujeo
 enyK4n/Kts4EEudgW89b5LRW9zZQ/M7s4r6uGfZCdsgb9hSN2g3db+0wZ
 3senTHQwwaWrVd7sp6F6HRPTXgsOoXqD/iqHbw/SGU2UKucyX3U8GCup0
 b1krI3B2GQt0AdmjUGNi16jSr51c08Pn8dei3ncorHRBkUkpPyiRQEe6r
 bog/lKbt6NrRB4m3HAV5fJADddHZN6UtQeS4dzvpB29f6V5yDvVXZ078C g==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; d="scan'208";a="95675124"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 01:31:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 03 Dec 2018 09:13:35 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98])
 ([10.111.72.98])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 09:31:18 -0800
Subject: Re: [RFT PATCH v1 3/4] cpu-topology: Move cpu topology code to common
 code.
To: Sudeep Holla <sudeep.holla@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-4-git-send-email-atish.patra@wdc.com>
 <20181203171619.GE17883@e107155-lin>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <f71fd03d-e5a7-0e79-9273-367db2354777@wdc.com>
Date: Mon, 3 Dec 2018 09:31:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203171619.GE17883@e107155-lin>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_093135_615009_B4102007 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/3/18 9:16 AM, Sudeep Holla wrote:
> On Thu, Nov 29, 2018 at 03:28:19PM -0800, Atish Patra wrote:
>> Both RISC-V & ARM64 are using cpu-map device tree to describe
>> their cpu topology. It's better to move the relevant code to
>> a common place instead of duplicate code.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/arm64/include/asm/topology.h |  22 ---
>>   arch/arm64/kernel/topology.c      | 303 +-------------------------------------
>>   drivers/base/arch_topology.c      | 294 ++++++++++++++++++++++++++++++++++++
>>   include/linux/arch_topology.h     |  26 ++++
>>   include/linux/topology.h          |   1 +
>>   5 files changed, 325 insertions(+), 321 deletions(-)
>>
>  From a quick look and diffstat, it looks like a simple move. However
> I would like to throw this at 0-day bot to test various build configurations
> so that it's not breaking anything. I can push to a branch in my git
> @kernel.org but not sure on the build coverage. Anyways will update
> with any results on build and testing on my side ASAP.
> 
Thanks. It definitely need to rigorous build testing for different 
configurations.

What is the best practice to trigger expansive build tests?
linux-kernel@vger.kernel.org is in CC.

Regards,
Atish
> --
> Regards,
> Sudeep
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
