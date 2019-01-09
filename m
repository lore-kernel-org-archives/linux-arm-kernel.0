Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:14:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E12520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHfWdXwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E12520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:To:References:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AiLp87SeJ92diDFG0wAB6KS5Fq5FwlIZvadhzOJb9uU=; b=GHfWdXwj+l6z9b
	DBSJXTv4mJD151djrhCMT6VWww1XQJaedYQH6GEwtWMngLHGh1EqrgmF6qPrpVIUhXqtShUJxkmHj
	0NMeMZOOvdBMYe3fFHzrJCHBaSn9weYXbbDsZDs9GNHp9l9iyK7K+k4+VwLmC7k8BD8IT9xL6EuFY
	21EwcJNsUGJvP1F26qWjDXEMFSLHMStWO2X5oKItsVQxbeJGpvkKXgmiMlyaIU28hve2PnjcERkX1
	m7ODlBBtL9au/NMV1KHKVESGiYXlEgvpjrUgzWsvXJzn26ncK8JIX6kcYNJJ/MyX6vAx2kPuJx6He
	roaMHEszBhxoufM7CVSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh9wv-00072l-76; Wed, 09 Jan 2019 09:14:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh9wr-00071y-05
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:14:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6320B80D;
 Wed,  9 Jan 2019 01:14:50 -0800 (PST)
Received: from [192.168.3.111] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5A03F70D;
 Wed,  9 Jan 2019 01:14:49 -0800 (PST)
Subject: Re: [kvmarm:kvm-arm64/nv-wip-v5.0-rc1 4/75]
 arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:700:7: error:
 'SYS_CNTP_TVAL_EL0' undeclared
References: <201901091219.igdmvhpC%fengguang.wu@intel.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <a82a7868-f3c0-0b3e-d0b7-182992c268fa@arm.com>
Date: Wed, 9 Jan 2019 09:13:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <201901091219.igdmvhpC%fengguang.wu@intel.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_011453_054556_3E2BE1FB 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09/01/2019 04:40, kbuild test robot wrote:

Marc, Christoffer,

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git kvm-arm64/nv-wip-v5.0-rc1
> head:   688c386ca096f2c1f2eee386697586c88df5d5bc
> commit: 2b1265c58a873d917e99ac762e243c1274481dbf [4/75] KVM: arm/arm64: consolidate arch timer trap handlers
> config: arm-axm55xx_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2b1265c58a873d917e99ac762e243c1274481dbf
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):

I was looking at this yesterday: It's a bit nasty, don't know a good
solution beside bringing back this part of my original timer rework series.
The problem is that those symbols contains the Aarch64 specific
(instruction) encoding of the timer registers, plus we need the AArch32
encodings for 32-on-64 guests.

That's why I used the generic UAPI encoding for the registers, because
we only need *some* identification for them, it doesn't need to be
something defined by the architecture.
Since arch_timer.c is shared, but sys_regs.c and coproc.c are arch
specific already, it seems natural to do the conversion in the trap
handler and keep the arch_timer code generic.

Does that make sense? I was a bit hesitant as it works against some of
your changes.

Cheers,
Andre.

> 
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c: In function 'get_timer_from_sysreg':
>>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:700:7: error: 'SYS_CNTP_TVAL_EL0' undeclared (first use in this function)
>      case SYS_CNTP_TVAL_EL0:
>           ^~~~~~~~~~~~~~~~~
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:700:7: note: each undeclared identifier is reported only once for each function it appears in
>>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:701:7: error: 'SYS_CNTP_CTL_EL0' undeclared (first use in this function); did you mean 'SYS_CNTP_TVAL_EL0'?
>      case SYS_CNTP_CTL_EL0:
>           ^~~~~~~~~~~~~~~~
>           SYS_CNTP_TVAL_EL0
>>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:702:7: error: 'SYS_CNTP_CVAL_EL0' undeclared (first use in this function); did you mean 'SYS_CNTP_TVAL_EL0'?
>      case SYS_CNTP_CVAL_EL0:
>           ^~~~~~~~~~~~~~~~~
>           SYS_CNTP_TVAL_EL0
>>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:703:7: error: 'SYS_AARCH32_CNTP_TVAL' undeclared (first use in this function)
>      case SYS_AARCH32_CNTP_TVAL:
>           ^~~~~~~~~~~~~~~~~~~~~
>>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:704:7: error: 'SYS_AARCH32_CNTP_CTL' undeclared (first use in this function); did you mean 'SYS_AARCH32_CNTP_TVAL'?
>      case SYS_AARCH32_CNTP_CTL:
>           ^~~~~~~~~~~~~~~~~~~~
>           SYS_AARCH32_CNTP_TVAL
>>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:705:7: error: 'SYS_AARCH32_CNTP_CVAL' undeclared (first use in this function); did you mean 'SYS_AARCH32_CNTP_TVAL'?
>      case SYS_AARCH32_CNTP_CVAL:
>           ^~~~~~~~~~~~~~~~~~~~~
>           SYS_AARCH32_CNTP_TVAL
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c: In function 'kvm_arm_timer_read_sysreg':
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:723:7: error: 'SYS_CNTP_TVAL_EL0' undeclared (first use in this function)
>      case SYS_CNTP_TVAL_EL0:
>           ^~~~~~~~~~~~~~~~~
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:724:7: error: 'SYS_AARCH32_CNTP_TVAL' undeclared (first use in this function)
>      case SYS_AARCH32_CNTP_TVAL:
>           ^~~~~~~~~~~~~~~~~~~~~
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:728:7: error: 'SYS_CNTP_CTL_EL0' undeclared (first use in this function); did you mean 'SYS_CNTP_TVAL_EL0'?
>      case SYS_CNTP_CTL_EL0:
>           ^~~~~~~~~~~~~~~~
>           SYS_CNTP_TVAL_EL0
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:729:7: error: 'SYS_AARCH32_CNTP_CTL' undeclared (first use in this function); did you mean 'SYS_AARCH32_CNTP_TVAL'?
>      case SYS_AARCH32_CNTP_CTL:
>           ^~~~~~~~~~~~~~~~~~~~
>           SYS_AARCH32_CNTP_TVAL
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:733:7: error: 'SYS_CNTP_CVAL_EL0' undeclared (first use in this function); did you mean 'SYS_CNTP_TVAL_EL0'?
>      case SYS_CNTP_CVAL_EL0:
>           ^~~~~~~~~~~~~~~~~
>           SYS_CNTP_TVAL_EL0
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:734:7: error: 'SYS_AARCH32_CNTP_CVAL' undeclared (first use in this function); did you mean 'SYS_AARCH32_CNTP_TVAL'?
>      case SYS_AARCH32_CNTP_CVAL:
>           ^~~~~~~~~~~~~~~~~~~~~
>           SYS_AARCH32_CNTP_TVAL
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c: In function 'kvm_arm_timer_write_sysreg':
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:758:7: error: 'SYS_CNTP_TVAL_EL0' undeclared (first use in this function)
>      case SYS_CNTP_TVAL_EL0:
>           ^~~~~~~~~~~~~~~~~
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:759:7: error: 'SYS_AARCH32_CNTP_TVAL' undeclared (first use in this function)
>      case SYS_AARCH32_CNTP_TVAL:
>           ^~~~~~~~~~~~~~~~~~~~~
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:763:7: error: 'SYS_CNTP_CTL_EL0' undeclared (first use in this function); did you mean 'SYS_CNTP_TVAL_EL0'?
>      case SYS_CNTP_CTL_EL0:
>           ^~~~~~~~~~~~~~~~
>           SYS_CNTP_TVAL_EL0
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:764:7: error: 'SYS_AARCH32_CNTP_CTL' undeclared (first use in this function); did you mean 'SYS_AARCH32_CNTP_TVAL'?
>      case SYS_AARCH32_CNTP_CTL:
>           ^~~~~~~~~~~~~~~~~~~~
>           SYS_AARCH32_CNTP_TVAL
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:768:7: error: 'SYS_CNTP_CVAL_EL0' undeclared (first use in this function); did you mean 'SYS_CNTP_TVAL_EL0'?
>      case SYS_CNTP_CVAL_EL0:
>           ^~~~~~~~~~~~~~~~~
>           SYS_CNTP_TVAL_EL0
>    arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:769:7: error: 'SYS_AARCH32_CNTP_CVAL' undeclared (first use in this function); did you mean 'SYS_AARCH32_CNTP_TVAL'?
>      case SYS_AARCH32_CNTP_CVAL:
>           ^~~~~~~~~~~~~~~~~~~~~
>           SYS_AARCH32_CNTP_TVAL
> 
> vim +/SYS_CNTP_TVAL_EL0 +700 arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c
> 
>    695	
>    696	static struct arch_timer_context *get_timer_from_sysreg(struct kvm_vcpu *vcpu,
>    697								u32 sr)
>    698	{
>    699		switch (sr) {
>  > 700		case SYS_CNTP_TVAL_EL0:
>  > 701		case SYS_CNTP_CTL_EL0:
>  > 702		case SYS_CNTP_CVAL_EL0:
>  > 703		case SYS_AARCH32_CNTP_TVAL:
>  > 704		case SYS_AARCH32_CNTP_CTL:
>  > 705		case SYS_AARCH32_CNTP_CVAL:
>    706			return vcpu_ptimer(vcpu);
>    707		default:
>    708			BUG();
>    709		}
>    710	}
>    711	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
