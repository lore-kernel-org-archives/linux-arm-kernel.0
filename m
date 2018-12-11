Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8281C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980B1205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tWQBRtju";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bmSI3smI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980B1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3gT5PUoAW2uQzfdWKvRncYRhVGi+h9vf6H9p7hhSrOY=; b=tWQBRtjuLiiiMtPdxRvItAkJS
	Fvw9RFck19HavTkXmujSonzhHdyOt+N394xUIeoUWd3n11VPBn4A9KeLpkPPuiwmfm7/dW+ixFRnG
	XbNyTJ0vBgWFXJvncCdd4sRGJOFuK8dOYqs9vj72Mgg0kk+vvOk3C7qeywN0RMQMFzYASk5zfgTEY
	rLv4yWDuqtAMFG38/4P+KOs8Xzku4nYCyniW6RkpjZiMSRwRSuG6E4jyPpkiD4bEd2jGah+TFBY0b
	gkLaJDPREjObcjWIb/bLV66aI5/oSvs7cpfpIL/1oMmv20qIY9xxt4DBVq5s9G4SNZVI0mEOjubj7
	4vGTFHXaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVtB-0006xx-Rp; Tue, 11 Dec 2018 00:27:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVt7-0006xH-KR; Tue, 11 Dec 2018 00:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1544488021; x=1576024021;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Yu/UGOFjGVp/CZUqSFRBTuTeDAXC3xQlnIWp9srtFm0=;
 b=bmSI3smILeaYRJYmosdn0TM477KCQrnR629caQK50gN7WdwHDNpNgTGi
 Lhpe9WQXxZdc9VSGxOFQLX0Mg72AWBAPtlulZlVnU0NrMg47T1ljNLHF1
 eM+ZwdswPtnkCk0o1egpkSkolyjHrqXguekcIoLGF/+wtP1arGNEjwNeM
 d1tLfnuyZZIj94mTDEOjL/i3C0oR1yBis66AmxnvjFjGXQwSyTAVDxsWH
 BLgL7akejOPrsa1S7IZVAEj4uQNiAHqYn4EMKgZ2UY96ynC3fE15rpWHp
 PlSlSO1CjyE/GaO/Zu3WsyVt4Dn/wXNXLwusd5M/C4EoyG3zqIcDdBM1D g==;
X-IronPort-AV: E=Sophos;i="5.56,340,1539619200"; d="scan'208";a="101173183"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2018 08:26:50 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 10 Dec 2018 16:08:35 -0800
Received: from colley-l-lt.ad.shared (HELO [10.86.57.118]) ([10.86.57.118])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Dec 2018 16:26:49 -0800
Subject: Re: [RFT PATCH v1 0/4] Unify CPU topology across ARM64 & RISC-V
To: Jeffrey Hugo <jhugo@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <d72a87f4-8dc1-2ec7-b602-0135c5e4c3a7@codeaurora.org>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <131ba08d-a31f-601d-eb40-9d2e8007d948@wdc.com>
Date: Mon, 10 Dec 2018 16:26:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d72a87f4-8dc1-2ec7-b602-0135c5e4c3a7@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_162701_782403_EDAB2D11 
X-CRM114-Status: GOOD (  21.87  )
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
 Albert Ou <aou@eecs.berkeley.edu>, Juri Lelli <juri.lelli@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>,
 Will Deacon <will.deacon@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>,
 Anup Patel <anup@brainfault.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/5/18 9:53 AM, Jeffrey Hugo wrote:
> On 11/29/2018 4:28 PM, Atish Patra wrote:
>> The cpu-map DT entry in ARM64 can describe the CPU topology in
>> much better way compared to other existing approaches. RISC-V can
>> easily adopt this binding to represent it's own CPU topology.
>> Thus, both cpu-map DT binding and topology parsing code can be
>> moved to a common location so that RISC-V or any other
>> architecture can leverage that.
>>
>> The relevant discussion regarding unifying cpu topology can be
>> found in [1].
>>
>> arch_topology seems to be a perfect place to move the common
>> code. I have not introduced any functional changes in the moved
>> code. The only downside in this approach is that the capacity
>> code will be executed for RISC-V as well. But, it will exit
>> immediately after not able to find the appropriate DT node. If
>> the overhead is considered too much, we can always compile out
>> capacity related functions under a different config for the
>> architectures that do not support them.
>>
>> The patches have been tested for RISC-V and compile tested for
>> ARM64 & x86.
>>
>> The socket change[2] is also now part of this series.
>>
>> [1] https://lkml.org/lkml/2018/11/6/19
>> [2] https://lkml.org/lkml/2018/11/7/918
>>
>> QEMU changes for RISC-V topology are available at
>>
>> https://github.com/atishp04/riscv-qemu/tree/cpu_topo
>>
>> Apologies for the previous patch series with incorrect title and
>> was sent only to kernel mailing list due to a bug in my config.
>> Please ignore that.
>>
>> Atish Patra (3):
>> dt-binding: cpu-topology: Move cpu-map to a common binding.
>> cpu-topology: Move cpu topology code to common code.
>> RISC-V: Parse cpu topology during boot.
>>
>> Sudeep Holla (1):
>> Documentation: DT: arm: add support for sockets defining package
>> boundaries
>>
>> .../{arm/topology.txt => cpu/cpu-topology.txt}     | 133 +++++++--
>> arch/arm64/include/asm/topology.h                  |  22 --
>> arch/arm64/kernel/topology.c                       | 303 +--------------------
>> arch/riscv/Kconfig                                 |   1 +
>> arch/riscv/kernel/smpboot.c                        |   3 +
>> drivers/base/arch_topology.c                       | 294 ++++++++++++++++++++
>> include/linux/arch_topology.h                      |  26 ++
>> include/linux/topology.h                           |   1 +
>> 8 files changed, 435 insertions(+), 348 deletions(-)
>> rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
>>
>> --
>> 2.7.4
>>
> 
> Seems to test fine on QDF2400.
> 
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>


Thanks for verifying the patches.

> I did see that git am complained about patch #2 -
> 
> patch:103: space before tab in indent.
>                           };
> patch:114: space before tab in indent.
>           };
> warning: 2 lines add whitespace errors.
> 
> 

Thanks for pointing it out. For some reason, cherry-pick did not 
complain about these. I will fix them.

Regards,
Atish

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
