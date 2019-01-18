Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B524F20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n3oFk582"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B524F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVpjbNdxKEgs/CcJSWfPcaCUHZL1H2e/nCZ5ixvMENI=; b=n3oFk582hK2R0t
	Rm6xb8bSHA15JfbB3FHq99mQokqbnYY3ysq3nPbo7s7VcEXC1CUbJazEQlG08IBY82G+LDnRZmPyf
	sr0FuhIAd7I6jnPgRuT4X7e2T+cacw1Pckc36ojfKIYCa4H4fFnxV/XiHCma+WpOuxwc1Y5OsONLZ
	EspxWBCR3aD1HuoSV6OwRqqUQCJr+byY005c4QX6x5HXsGR75t4I5+Bd7Nvtmb4Y7WYwaB6tASK4W
	2rmMCAPi5BX2CT5dC9q5NsWzRl4Y6d6p+k4HStjnuucJPmpn06SqdrLNNXUdJncwkYjNiVVjNQQ6t
	MKD9jY1Wl0BPZI8gPewA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUrT-0007kd-9a; Fri, 18 Jan 2019 14:11:07 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUrQ-0007k0-Bf
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:11:06 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id DD9E813F8CC;
 Fri, 18 Jan 2019 15:10:47 +0100 (CET)
Subject: Re: kmemleak panic
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Catalin Marinas <catalin.marinas@arm.com>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
Message-ID: <42010974-018e-5fed-3465-6dc6eb7390e2@free.fr>
Date: Fri, 18 Jan 2019 15:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_061104_548267_D150D175 
X-CRM114-Status: GOOD (  11.51  )
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

On 18/01/2019 14:36, Marc Gonzalez wrote:

> Hello Catalin,
> 
> Trying to diagnose a separate issue(*) I enabled a raft of debugging options,
> including kmemleak. However, it looks like kmemleak itself is crashing?
> 
> (*) https://lwn.net/ml/linux-block/f792574c-e083-b218-13b4-c89be6566015%40free.fr/
> 
> Did I do something wrong?
> 
> We seem to be crashing on this code:
> 
> 		kasan_disable_current();
> 		pointer = *ptr;
> 		kasan_enable_current();
> 
> Note: I had just disabled KASAN. Maybe Kconfig got confused.
> Will try building a fresh kernel.

So much for that theory... I rebuilt everything from scratch, and still:

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
CPU: 3 PID: 524 Comm: kmemleak Tainted: G S                5.0.0-rc1 #11
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x190
lr : scan_block+0x6c/0x190
sp : ffffff8012cc3d20
x29: ffffff8012cc3d20 x28: ffffffc0fdbaf018 
x27: ffffffc022000000 x26: 0000000000000080 
x25: ffffff80118bdf70 x24: ffffffc0f8cc8000 
x23: ffffff8010bd8000 x22: ffffff8010bd8830 
x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050 
x19: ffffffc021e00000 x18: 00000000000022f9 
x17: 0000000000000200 x16: 0000000000000000 
x15: ffffff8010c24dd8 x14: 00000000000022f6 
x13: 0000000069e360c8 x12: ffffffc0f5979a58 
x11: 0000000000000001 x10: ffffff8010bae688 
x9 : ffffff8010baf000 x8 : ffffff8010bae688 
x7 : 0000000000000002 x6 : 0000000000000000 
x5 : ffffff8011321c20 x4 : 00000000000025b1 
x3 : ffffff8010c24d88 x2 : 5b36396f4e7d4000 
x1 : 0000000000208040 x0 : 0000000000000000 
Process kmemleak (pid: 524, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x190
 scan_gray_list+0x108/0x1c0
 kmemleak_scan+0x33c/0x7c0
 kmemleak_scan_thread+0x98/0xf0
 kthread+0x11c/0x120
 ret_from_fork+0x10/0x1c
Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260) 
---[ end trace a48465a27899d668 ]---
note: kmemleak[524] exited with preempt_count 2


I do have a few patches on top of v5.0-rc1
I'll try reproducing on a truly vanilla kernel.

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
