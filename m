Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00708C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:46:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E0B218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lTLN6+uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E0B218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0FHNV2lTNxBRcHFdYk0Zljm9NUIeiYthknOsou8eqzM=; b=lTLN6+uuJ1vR1t
	jGOOKnTtsMsqSPX+smknCVfvzdCoGPQUuZP4t1VRw2jf8Rev6atFDO50CvqEWnWWXJV2Gley3yWfE
	o/cFr/ljnxrqE/qsUJZrPoS5KU2QfsGr4AK+5u/Z1OWiPh5lzZGjeQ1GKy5edYCBQND9aUJao1Itu
	Oqsm3++TNUY8WJr17k5Tr1opM1Nsfyx9SRNuIkn2LvHTzqO7a0nGejlgZkM4XrB6iFiaJeZp8GCjv
	/Z6ivwhSfFKXm/vGX0yjqnIXf8X0hlloZ9dhFJESCa7K4/PX2zwq6gWrGRbONyebltt4WtLVPOJup
	FUdwJjbUWXneRh+LEY1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXHS-0007qw-2I; Fri, 01 Feb 2019 11:46:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXHO-0007qY-Nl
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 11:46:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF7A80D;
 Fri,  1 Feb 2019 03:46:37 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9943F59C;
 Fri,  1 Feb 2019 03:46:36 -0800 (PST)
Date: Fri, 1 Feb 2019 11:46:32 +0000
From: Will Deacon <will.deacon@arm.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: ARM64 boot failure on Macchiatobin with Marvell 18.12 firmware
Message-ID: <20190201114552.GA29903@fuggles.cambridge.arm.com>
References: <20190201111917.y6vv6ouh7esf5uiw@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201111917.y6vv6ouh7esf5uiw@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_034642_784293_060D4B68 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Ard]

On Fri, Feb 01, 2019 at 11:19:18AM +0000, Russell King - ARM Linux admin wrote:
> I've updated the ATF, DDR and Marvell binaries firmware from 17.10
> to 18.12 on a Macchiatobin Single-shot board, while keeping u-boot
> the same version (17.10).
> 
> When booting a previously working 4.20 kernel, I now get:
> 
> Booting Linux on physical CPU 0x0000000000 [0x410fd081]
> Linux version 4.20.0+ (rmk@rmk-PC.armlinux.org.uk) (gcc version 4.9.2
> (GCC)) #212 SMP PREEMPT Thu Jan 31 15:33:31 GMT 2019
> Machine model: Marvell 8040 MACCHIATOBin Single-shot
> earlycon: uart0 at MMIO 0x00000000f0512000 (options '115200n8')
> printk: bootconsole [uart0] enabled
> SError Interrupt on CPU0, code 0xbf000002 -- SError
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.20.0+ #212
> Hardware name: Marvell 8040 MACCHIATOBin Single-shot (DT)
> pstate: 00400085 (nzcv daIf +PAN -UAO)
> pc : setup_arch+0xe8/0x56c
> lr : setup_arch+0xe0/0x56c
> sp : ffffff8008b03f10
> x29: ffffff8008b03f10 x28: 0000000000a50018
> x27: 0000000000000000 x26: 000000007ffa2e88
> x25: 000000007f7a2c68 x24: 0000000000000003
> x23: 0000000000000000 x22: ffffffbefe90005c
> x21: 0000000000000001 x20: ffffff8008b46000
> x19: ffffff8008080000 x18: 00000000000000ff
> x17: 0000000000001000 x16: 0000000000001000
> x15: 446e1c00644a0615 x14: 2e392e34206e6f69
> x13: 7372657620636367 x12: 0000000000000008
> x11: 0000000000000007 x10: 0101010101010101
> x9 : fffffffffffffffb x8 : 0000000000000008
> x7 : 0000000000000003 x6 : 0080000000008080
> x5 : 000000000000005f x4 : 000000000000006c
> x3 : 0000000000000063 x2 : 000000000000006c
> x1 : ffffff8008961ff9 x0 : 0000000000000080
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.20.0+ #212
> Hardware name: Marvell 8040 MACCHIATOBin Single-shot (DT)
> Call trace:
>  dump_backtrace+0x0/0x158
>  show_stack+0x14/0x1c
>  dump_stack+0x90/0xb0
>  panic+0x148/0x2b8
>  print_tainted+0x0/0xa8
>  arm64_serror_panic+0x74/0x80
>  do_serror+0x5c/0xb8
>  el1_error+0xb4/0x144
>  setup_arch+0xe8/0x56c
>  start_kernel+0x64/0x408
> 
> If I'm reading the Cortex-A72 ESR information correctly, this is a
> Slave Error SError interrupt.
> 
> The failing code sequence appears to be:
> 
> ffffff8008a53098:       9401506a        bl      ffffff8008aa7240 <dump_stack_set_arch_desc>
> ffffff8008a5309c:       97fff636        bl      ffffff8008a50974 <parse_early_param>
> ffffff8008a530a0:       d2801000        mov     x0, #0x80
> // #128
> ffffff8008a530a4:       d51b4220        msr     daif, x0
> ffffff8008a530a8:       d0fffcdb        adrp    x27, ffffff80089ed000 <kallsyms_token_index+0x8b300>
> 
> If I downgrade the firmware back to 17.10, the kernel boots fine again.
> 
> Any ideas what's going on here?

Looks like you're taking the SError as soon as we unmask them, so it
could've been pending for ages. It would be interesting to see if it's
actually caused by the kernel, or if the firmware triggers it beforehand.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
