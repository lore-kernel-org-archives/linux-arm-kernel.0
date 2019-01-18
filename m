Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F24C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:37:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2792087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fSMb7E3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2792087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JY7iFl93YSU9J7ZQ1lIuTJfhr5JvA7MP1/gJSYonxiU=; b=fSMb7E3Lhey+UH
	iV3UeregJY+ZvvqCL3iiyS+1G+/HYLkfeTT9aL/JTQecpA3mpVSnLA6auYwaDJNu3qsFiCHMOsBOB
	DOSzw3ReHp69PK9iHBc4feJqwpU2CMiG/xTBmTgYi50KpWhulBcwOV9vg9BD5bo7ZUZKwhsrxjbrV
	hY6v1J6BU7msQDmJrEI13x1UhHPg+EygUl4P2bFcXJMBcxP7feDwe4L8YJMog8Owa7iLrkUW1Gsec
	78sWLT1+xCMTc+NM2iG0YK5cMiczcqrGKVRusxRLEGHwasfsx4szSuZ+EgJyY+pToQSxBOcXu1AIM
	sdHuhildPvs/l6ELh1kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUKc-0003wp-1C; Fri, 18 Jan 2019 13:37:10 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUKX-0003wS-2d
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:37:07 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 69C9413F86F;
 Fri, 18 Jan 2019 14:36:46 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: kmemleak panic
Message-ID: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
Date: Fri, 18 Jan 2019 14:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_053705_427030_7DE484D9 
X-CRM114-Status: UNSURE (   7.46  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Catalin,

Trying to diagnose a separate issue(*) I enabled a raft of debugging options,
including kmemleak. However, it looks like kmemleak itself is crashing?

(*) https://lwn.net/ml/linux-block/f792574c-e083-b218-13b4-c89be6566015%40free.fr/

Did I do something wrong?

We seem to be crashing on this code:

		kasan_disable_current();
		pointer = *ptr;
		kasan_enable_current();

Note: I had just disabled KASAN. Maybe Kconfig got confused.
Will try building a fresh kernel.

Regards.


Unable to handle kernel paging request at virtual address ffffffc021e00000
Mem abort info:
  ESR = 0x96000006
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
[ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 6 PID: 523 Comm: kmemleak Tainted: G S      W         5.0.0-rc1 #13
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x190
lr : scan_block+0x6c/0x190
sp : ffffff8012e8bd20
x29: ffffff8012e8bd20 x28: ffffffc0fdbaf018 
x27: ffffffc022000000 x26: 0000000000000080 
x25: ffffff8011aadf70 x24: ffffffc0f8cc8000 
x23: ffffff8010dc8000 x22: ffffff8010dc8830 
x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050 
x19: ffffffc021e00000 x18: 0000000000002409 
x17: 0000000000000200 x16: 0000000000000000 
x15: ffffff8010e14dd8 x14: 0000000000002406 
x13: 000000004c4dd0c6 x12: ffffffc0f77dad58 
x11: 0000000000000001 x10: ffffff8010d9e688 
x9 : ffffff8010d9f000 x8 : ffffff8010d9e688 
x7 : 0000000000000002 x6 : 0000000000000000 
x5 : ffffff8011511c20 x4 : 00000000000026d1 
x3 : ffffff8010e14d88 x2 : 5b36396f4e7d4000 
x1 : 0000000000208040 x0 : 0000000000000000 
Process kmemleak (pid: 523, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x190
 scan_gray_list+0x108/0x1c0
 kmemleak_scan+0x33c/0x7c0
 kmemleak_scan_thread+0x98/0xf0
 kthread+0x11c/0x120
 ret_from_fork+0x10/0x1c
Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260) 
---[ end trace 176d6ed9d86a0c33 ]---
note: kmemleak[523] exited with preempt_count 2



ffffff80101e4e10 <scan_block>:
ffffff80101e4e10:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
ffffff80101e4e14:	910003fd 	mov	x29, sp
ffffff80101e4e18:	a9025bf5 	stp	x21, x22, [sp, #32]
ffffff80101e4e1c:	f9000bf3 	str	x19, [sp, #16]
ffffff80101e4e20:	a90363f7 	stp	x23, x24, [sp, #48]
ffffff80101e4e24:	f90027fa 	str	x26, [sp, #72]
ffffff80101e4e28:	aa0003f3 	mov	x19, x0
ffffff80101e4e2c:	aa0103f5 	mov	x21, x1
ffffff80101e4e30:	aa1e03e0 	mov	x0, x30
ffffff80101e4e34:	aa0203f8 	mov	x24, x2
ffffff80101e4e38:	90005f37 	adrp	x23, ffffff8010dc8000 <slab_attrs+0xc8>
ffffff80101e4e3c:	9120c2f6 	add	x22, x23, #0x830
ffffff80101e4e40:	97fac264 	bl	ffffff80100957d0 <_mcount>
ffffff80101e4e44:	91001e73 	add	x19, x19, #0x7
ffffff80101e4e48:	927df273 	and	x19, x19, #0xfffffffffffffff8
ffffff80101e4e4c:	d1001eb5 	sub	x21, x21, #0x7
ffffff80101e4e50:	910142c0 	add	x0, x22, #0x50
ffffff80101e4e54:	9408f627 	bl	ffffff80104226f0 <_raw_read_lock_irqsave>
ffffff80101e4e58:	eb15027f 	cmp	x19, x21
ffffff80101e4e5c:	aa0003fa 	mov	x26, x0
ffffff80101e4e60:	540006a2 	b.cs	ffffff80101e4f34 <scan_block+0x124>  // b.hs, b.nlast
ffffff80101e4e64:	f90023b9 	str	x25, [x29, #64]
ffffff80101e4e68:	b000c659 	adrp	x25, ffffff8011aad000 <memblock_reserved_init_regions+0x908>
ffffff80101e4e6c:	913dc339 	add	x25, x25, #0xf70
ffffff80101e4e70:	f9000fb4 	str	x20, [x29, #24]
ffffff80101e4e74:	d503201f 	nop
ffffff80101e4e78:	97ffffd2 	bl	ffffff80101e4dc0 <scan_should_stop>
ffffff80101e4e7c:	35000580 	cbnz	w0, ffffff80101e4f2c <scan_block+0x11c>
*** ffffff80101e4e80:	f9400260 	ldr	x0, [x19]
ffffff80101e4e84:	f94046c2 	ldr	x2, [x22, #136]
ffffff80101e4e88:	eb00005f 	cmp	x2, x0
ffffff80101e4e8c:	540004a8 	b.hi	ffffff80101e4f20 <scan_block+0x110>  // b.pmore
ffffff80101e4e90:	f9401f21 	ldr	x1, [x25, #56]
ffffff80101e4e94:	eb00003f 	cmp	x1, x0
ffffff80101e4e98:	54000449 	b.ls	ffffff80101e4f20 <scan_block+0x110>  // b.plast
ffffff80101e4e9c:	52800021 	mov	w1, #0x1                   	// #1
ffffff80101e4ea0:	97fffce0 	bl	ffffff80101e4220 <lookup_object>
ffffff80101e4ea4:	f100001f 	cmp	x0, #0x0
ffffff80101e4ea8:	aa0003f4 	mov	x20, x0
ffffff80101e4eac:	fa581004 	ccmp	x0, x24, #0x4, ne  // ne = any
ffffff80101e4eb0:	54000380 	b.eq	ffffff80101e4f20 <scan_block+0x110>  // b.none
ffffff80101e4eb4:	52800021 	mov	w1, #0x1                   	// #1
ffffff80101e4eb8:	9408f4de 	bl	ffffff8010422230 <_raw_spin_lock_nested>
ffffff80101e4ebc:	b940aa80 	ldr	w0, [x20, #168]
ffffff80101e4ec0:	3100041f 	cmn	w0, #0x1
ffffff80101e4ec4:	540004e0 	b.eq	ffffff80101e4f60 <scan_block+0x150>  // b.none
ffffff80101e4ec8:	f9002bbb 	str	x27, [x29, #80]
ffffff80101e4ecc:	b940ae81 	ldr	w1, [x20, #172]
ffffff80101e4ed0:	6b00003f 	cmp	w1, w0
ffffff80101e4ed4:	5400044b 	b.lt	ffffff80101e4f5c <scan_block+0x14c>  // b.tstop
ffffff80101e4ed8:	f940529b 	ldr	x27, [x20, #160]
ffffff80101e4edc:	aa1403e0 	mov	x0, x20
ffffff80101e4ee0:	9408f578 	bl	ffffff80104224c0 <_raw_spin_unlock>
ffffff80101e4ee4:	b40004fb 	cbz	x27, ffffff80101e4f80 <scan_block+0x170>
ffffff80101e4ee8:	52800001 	mov	w1, #0x0                   	// #0
ffffff80101e4eec:	aa1b03e0 	mov	x0, x27
ffffff80101e4ef0:	97fffccc 	bl	ffffff80101e4220 <lookup_object>
ffffff80101e4ef4:	f100001f 	cmp	x0, #0x0
ffffff80101e4ef8:	aa0003f4 	mov	x20, x0
ffffff80101e4efc:	fa401304 	ccmp	x24, x0, #0x4, ne  // ne = any
ffffff80101e4f00:	54000400 	b.eq	ffffff80101e4f80 <scan_block+0x170>  // b.none
ffffff80101e4f04:	52800021 	mov	w1, #0x1                   	// #1
ffffff80101e4f08:	9408f4ca 	bl	ffffff8010422230 <_raw_spin_lock_nested>
ffffff80101e4f0c:	aa1403e0 	mov	x0, x20
ffffff80101e4f10:	97ffff2c 	bl	ffffff80101e4bc0 <update_refs>
ffffff80101e4f14:	aa1403e0 	mov	x0, x20
ffffff80101e4f18:	9408f56a 	bl	ffffff80104224c0 <_raw_spin_unlock>
ffffff80101e4f1c:	f9402bbb 	ldr	x27, [x29, #80]
ffffff80101e4f20:	91002273 	add	x19, x19, #0x8
ffffff80101e4f24:	eb1302bf 	cmp	x21, x19
ffffff80101e4f28:	54fffa88 	b.hi	ffffff80101e4e78 <scan_block+0x68>  // b.pmore
ffffff80101e4f2c:	f9400fb4 	ldr	x20, [x29, #24]
ffffff80101e4f30:	f94023b9 	ldr	x25, [x29, #64]
ffffff80101e4f34:	9120c2e0 	add	x0, x23, #0x830
ffffff80101e4f38:	aa1a03e1 	mov	x1, x26
ffffff80101e4f3c:	91014000 	add	x0, x0, #0x50
ffffff80101e4f40:	9408f6b8 	bl	ffffff8010422a20 <_raw_read_unlock_irqrestore>
ffffff80101e4f44:	f9400bf3 	ldr	x19, [sp, #16]
ffffff80101e4f48:	a9425bf5 	ldp	x21, x22, [sp, #32]
ffffff80101e4f4c:	a94363f7 	ldp	x23, x24, [sp, #48]
ffffff80101e4f50:	f94027fa 	ldr	x26, [sp, #72]
ffffff80101e4f54:	a8c67bfd 	ldp	x29, x30, [sp], #96
ffffff80101e4f58:	d65f03c0 	ret
ffffff80101e4f5c:	f9402bbb 	ldr	x27, [x29, #80]
ffffff80101e4f60:	aa1403e0 	mov	x0, x20
ffffff80101e4f64:	97ffff17 	bl	ffffff80101e4bc0 <update_refs>
ffffff80101e4f68:	aa1403e0 	mov	x0, x20
ffffff80101e4f6c:	91002273 	add	x19, x19, #0x8
ffffff80101e4f70:	9408f554 	bl	ffffff80104224c0 <_raw_spin_unlock>
ffffff80101e4f74:	eb1302bf 	cmp	x21, x19
ffffff80101e4f78:	54fff808 	b.hi	ffffff80101e4e78 <scan_block+0x68>  // b.pmore
ffffff80101e4f7c:	17ffffec 	b	ffffff80101e4f2c <scan_block+0x11c>
ffffff80101e4f80:	91002273 	add	x19, x19, #0x8
ffffff80101e4f84:	f9402bbb 	ldr	x27, [x29, #80]
ffffff80101e4f88:	eb1302bf 	cmp	x21, x19
ffffff80101e4f8c:	54fff768 	b.hi	ffffff80101e4e78 <scan_block+0x68>  // b.pmore
ffffff80101e4f90:	17ffffe7 	b	ffffff80101e4f2c <scan_block+0x11c>
ffffff80101e4f94:	d503201f 	nop
ffffff80101e4f98:	d503201f 	nop
ffffff80101e4f9c:	d503201f 	nop

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
