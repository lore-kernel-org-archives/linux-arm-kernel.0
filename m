Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:04:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D76B21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AQA27p+5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DfFjQzR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D76B21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nqku7BL85PxWZUWPJaLxd4IlNF5yQzsksqrMcDQDgrg=; b=AQA27p+5XrBln+
	7+bB/arUmKgtTX5VTog/CKdbBD6j8to3PcOburaPd6W9+c+zaMMYP8XwCwSEDUtvaFt5ppszj8Vc2
	Y9HpOQxLRzcM1MPltdvf+6izwad7PUhHUdqk6cPR/q2QjaBMbHm518/asIaPFVWrtOOQcKQH1Xkod
	4zq4p+3qFwYzoWxrdhQieF6zdk7sFNUw72FY1bwbIcs5j/4aI3ZHO33SapV/GSxuNndb9wLGEChAa
	+1E01TpUgJd3Ig4q53EZ2Cl+9e5HFAPMCaeXObaXX3+nDB24hPriuKivkbTBrK2WCGuovCRpZGAY0
	kDm0VhgaNfvzgXO4NaMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guUjt-0007ht-AD; Fri, 15 Feb 2019 04:04:37 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guUjp-0007hY-6m
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 04:04:35 +0000
Received: by mail-qt1-x844.google.com with SMTP id p25so9229255qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 20:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ehj9Gd/Zu8nFNl8rJb6KsCoMFJoBx3BSVEQUn1IxDlA=;
 b=DfFjQzR69XoMzPjsLUlJRt2OC0rRbz4fdn6sJKRK+W8NJNMMin4x5bsewW0/8TMF/A
 rPOXfsN5S7dkaz03DFQ4TP/00Pu0ldFBvyn3PFLnFW0SrKS9N+k4rwvfwxaJ2U6LSBYK
 sTqW1EN+Y4lEP2CfXxPVw3C2Vz9X6wFpVvBiJAD58ZEAdY9CylDciWNlv63BhazPx4wo
 0puJK7L4RjRmCdsszythvTd/VH0UnGGIMJx2OJgwHEyz3Un579D4tAGErPN+3GJPTKdH
 R6/FL5jmX0J3EUasrQyaaA2iKw/STqIUz9+AoafoZjkxe0YauoMLa/pME66H1fK4eap+
 qRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ehj9Gd/Zu8nFNl8rJb6KsCoMFJoBx3BSVEQUn1IxDlA=;
 b=AV9v9Rcirsn2PADwAxZhPqSCyok7mNZ4JEG+1PMjHzxWwPyGa3PnChWt3o0Lte6O1R
 Jvr51S92otKFC993ELW9jqv9/oVLCbd9wq3dsp/YQI2pP8OrgR4Xbbd0XoC2Lf3sethr
 YbxPCrJOmlE+TwzgiNLKU2ePcZrvG2rpDHaBTs9MQPqn3krxIxj2CoF84qgUsfoSPuBP
 E0/Dhs6bvgO0+qD0/WGz8BUblfyM8qTEBaZ5tMH2S8uxQl9NGCMjfAZiryptq5O3UwbA
 lXN16OyhmT3Ki8lXhc8zVKkCFE+BClerZ+rmxqMjA7F20Pr9Xxa1cT2oIV2qYM1Eic2Y
 h92Q==
X-Gm-Message-State: AHQUAuZX2BXL6TlsHNqgq2c9nn6gkzx0ZC0iRzAsN68wsl7mv1MUB+YH
 m67qqELyNCtmUZKa5Ii0Vp+E0Apu8Nw=
X-Google-Smtp-Source: AHgI3IZZAgNMgGQysAcgldjpC8NTW2nJY9Ml2f7ESUiY2W3A0JifohgCtoJwOVXgV9e2xhk94GRnCA==
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr5833525qtl.343.1550203468479; 
 Thu, 14 Feb 2019 20:04:28 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id b66sm2386465qkf.64.2019.02.14.20.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 20:04:27 -0800 (PST)
Subject: Re: livelock with KASAN_SW_TAGS
To: Will Deacon <will.deacon@arm.com>
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
 <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
 <20190214180125.GH2475@fuggles.cambridge.arm.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <a31780dc-2fac-734e-61b8-8bdedaca2f05@lca.pw>
Date: Thu, 14 Feb 2019 23:04:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190214180125.GH2475@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_200433_392320_83FF1F5A 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>, aryabinin@virtuozzo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/14/19 1:01 PM, Will Deacon wrote:
> On Thu, Feb 14, 2019 at 11:50:59AM -0500, Qian Cai wrote:
>> On 2/14/19 11:35 AM, Will Deacon wrote:
>>> On Wed, Feb 13, 2019 at 10:32:11PM -0500, Qian Cai wrote:
>>>> Running LTP msgstress03 [1] triggers endless soft lockups below after a few
>>>> minutes on a ThunderX2 server. It works fine with KASAN_GENERIC and finish the
>>>> test in roughly 11 minutes.
>>>
>>> I've not been able to reproduce this failure under KVM, however the test
>>> only takes around 18s to complete on the host and the guest, so it feels
>>> like something is amiss here. Please could you share more information about
>>> how you're triggering this problem? For example:
>>>
>>>   - Kernel version and .config
>>
>> Latest mainline at 1f947a7a01 ("Merge branch 'akpm' (patches from Andrew)") plus
>> a few KASAN_SW_TAGS patches in order to boot.
>>
>> https://marc.info/?l=linux-mm&m=155006632110129&w=2 (all 5)
>> https://marc.info/?l=linux-mm&m=154968731424637&w=2
>> https://marc.info/?l=linux-mm&m=155010395725051&w=2
>>
>> https://git.sr.ht/~cai/linux-debug/tree/master/config
> 
> I struggled to get this config to boot under KVM :(
> 
>>>   - Clang version
>>
>> clang-7.0.1
> 
> It would be helpful to know if the issue persists with the latest nightly
> build of clang.
> 
> Anyway, please could you annotate the goto loop in free_debug_processing()
> so that the object and tail pointer are printed each time around? It would
> be useful to know if we're failing to exit that.
>

Well, I am not sure I understand what your debugging strategy. Maybe, you can
send along a debug patch you have in mind for me to run.

From the trace, it definitely exit the "goto next_object" and reached further in
this line in free_debug_processing(),

spin_unlock_irqrestore(&n->list_lock, flags);

Once the machine is restricted to 16 CPUs (nr_cpus=16), although it still
trigger soft lockups and msgstress03 would seem running forever, the machine is
still responsible and is able to login via ssh. Hence, it is possible to capture
a task dump (echo t >/proc/sysrq-trigger) while this is happening.

https://git.sr.ht/~cai/linux-debug/tree/master/console

Some traces looks strange that looks like running free_debug_processing() in a loop,

[ 1986.002139] Call trace:
[ 1986.002145]  _raw_spin_unlock_irqrestore+0x44/0xac
[ 1986.002152]  free_debug_processing+0x2f4/0x3e4
[ 1986.002157]  kmem_cache_free+0x44c/0x870
[ 1986.002163]  free_object_rcu+0x200/0x228
[ 1986.002169]  rcu_process_callbacks+0xb00/0x12c0
[ 1986.002175]  __do_softirq+0x644/0xfd0
[ 1986.002181]  irq_exit+0x29c/0x370
[ 1986.002187]  __handle_domain_irq+0xe0/0x1c4
[ 1986.002192]  gic_handle_irq+0x1c4/0x3b0
[ 1986.002197]  el1_irq+0xb0/0x140
[ 1986.002203]  lock_release+0x660/0x7dc
[ 1986.002209]  rcu_lock_release+0x20/0x28
[ 1986.002214]  do_msgrcv+0x708/0xed0
[ 1986.002219]  ksys_msgrcv+0x4c/0x60
[ 1986.002224]  __arm64_sys_msgrcv+0xb8/0x194
[ 1986.002230]  el0_svc_handler+0x230/0x3bc
[ 1986.002236]  el0_svc+0x8/0xc
[ 1986.007106]  OUTLINED_FUNCTION_169+0x4/0xc
[ 1986.011885]  free_debug_processing+0x2f4/0x3e4
[ 1986.017186]  load_msg+0x4c/0x324
[ 1986.021617]  kmem_cache_free+0x44c/0x870
[ 1986.026917]  ksys_msgsnd+0x1e0/0xe5c
[ 1988.050035]  _raw_spin_unlock_irqrestore+0x44/0xac
[ 1988.054821]  free_debug_processing+0x2f4/0x3e4
[ 1988.059260]  kfree+0x3f8/0x7ac
[ 1988.062313]  free_msg+0x50/0xb0
[ 1988.065450]  do_msgrcv+0xd80/0xed0
[ 1988.068846]  ksys_msgrcv+0x4c/0x60
[ 1988.072243]  __arm64_sys_msgrcv+0xb8/0x194
[ 1988.076336]  el0_svc_handler+0x230/0x3bc
[ 1988.080255]  el0_svc+0x

Occasionally, msgstress03 would trigger a panic.

[  997.982080] Internal error: synchronous external abort: 96000610 [#1] SMP
[  997.988886] Modules linked in: thunderx2_pmu efivarfs ip_tables xfs libcrc32c
sd_mod ahci libahci mlx5_core libata dm_mirror dm_region_hash dm_log dm_mod
[  998.002665] CPU: 229 PID: 1323 Comm: kworker/229:1 Kdump: loaded Tainted: G
     W         5.0.0-rc6+ #57
[  998.012402] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
BIOS L50_5.13_1.0.6 07/10/2018
[  998.022243] Workqueue: events free_obj_work
[  998.026434] pstate: 00400009 (nzcv daif +PAN -UAO)
[  998.031229] pc : kmem_cache_free+0x410/0x870
[  998.035500] lr : free_obj_work+0x92c/0xa44
[  998.039592] sp : 29ff808baebefb50
[  998.042908] x29: 29ff808baebefca0 x28: 73ff808a939eb6e0
[  998.048223] x27: 33ff800820013488 x26: 73ff808a939eb710
[  998.053537] x25: 0000000000a3008e x24: ffff100014b73000
[  998.058850] x23: 00000000000000ff x22: dead000000000100
[  998.064164] x21: efff100000000000 x20: efff100000000000
[  998.069480] x19: ffff100014b73d70 x18: ffff1000148a5538
[  998.074795] x17: 000000000000001b x16: 0000000000a3008d
[  998.080108] x15: b1ff808a939ee2a0 x14: 0000000000000000
[  998.085421] x13: 9dff808ba9713850 x12: 0000000000000000
[  998.090737] x11: 007ffffffc000201 x10: ffff1000138d4000
[  998.096055] x9 : 0000000000000000 x8 : 9dff808ba9713840
[  998.101371] x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000008
[  998.106686] x5 : 000000000000005a x4 : 0000000000000000
[  998.111999] x3 : 29ff808baebef9f4 x2 : 0000000000000003
[  998.117312] x1 : cbff80082000df18 x0 : ffff808a939eb710
[  998.122632] Process kworker/229:1 (pid: 1323, stack limit = 0x00000000d1a3376a)
[  998.129937] Call trace:
[  998.132388]  kmem_cache_free+0x410/0x870
[  998.136320]  process_one_work+0x894/0x1280
[  998.140418]  worker_thread+0x684/0xa1c
[  998.144174]  kthread+0x2cc/0x2e8
[  998.147409]  ret_from_fork+0x10/0x18
[  998.150989] Code: a94b7bfd a94a4ff4 a94957f6 a9485ff8 (a94767fa)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
