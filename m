Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74251C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A14F2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U1QIexwl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CjmEKbGf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n4luCbAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A14F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eDDTrA8R+YYiTnf88b+SCbVsLsecB0XxxnTsRy/mowQ=; b=U1QIexwl/ASjDqgSr5FHzy4P/
	n9KvCW9IRgmHgyJZAW08+V8jZEXNRMuca2bjLxZ+1leMwOCpLLIyW3ak7N+KUKWrXZ91KgC52GXXS
	n+ZkKWG8rBCj2XtnMmEb12FUNnOr8QilB9V0Q4fKqwAF3M3jVGz4NJzxRyxXjdnskfv8xFw7Q16TI
	hCG6KVGhShXrP+/re9gwyW0WQrst6jRNd79ivOjLKPE5EwaHZhXhUg+78M2ubLbRVhG3SE1axu2e2
	k6TNBXQZpdmQ1qSDpjXzu9EZl0Vw88AipViS4kAIEXXNqF8j5gPUrDAzV1pgt1/xxrFKA4ean/xP4
	5u+Pz7ubA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSpr8-0007GL-Uq; Fri, 30 Nov 2018 20:57:46 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSpr5-0007F8-P7
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 20:57:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 3F6D760B1E; Fri, 30 Nov 2018 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543611453;
 bh=YKLWO360MjvcXBGA/dlpjWYGyrW8nz4aloUSMNr5lVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CjmEKbGffHJQ/Fo+KBW7n9xszRunbqHGiXO6vTUOcpP3XbNWNhG50I/Lmsss29qo5
 tmLvxbWGT16OkzrqBOd6TRIRXFqJACMy0vV0S8ud9tRxKW648dHdAPhfdglcf6gsUD
 jSPccaFigI7cStmg8Hfrse6AU1A49NzpX11iwrrI=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: ilina@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CB87601C4;
 Fri, 30 Nov 2018 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543611451;
 bh=YKLWO360MjvcXBGA/dlpjWYGyrW8nz4aloUSMNr5lVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n4luCbAdSLuqq14Mubb/9FQSB/48AKyMpQww4joqbOCSUqrk8LyIY9ICElHOvBlvF
 DkRtyyhMWc87KgFRC553X77aZXSatboWBdmEVAfnI1KHelsfoxSP5h6h1C2Wkbpai1
 AVh9eF1VvxRGFR9s2C7RutrLRMokIIZO5ofyLHKc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CB87601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 30 Nov 2018 13:57:30 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
Message-ID: <20181130205730.GM18262@codeaurora.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org>
 <20181129223130.GH18262@codeaurora.org>
 <CAPDyKFqUoYXUrj9N7f0DKxeL-BikwqKRWAB9FCX2PznkgiumcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFqUoYXUrj9N7f0DKxeL-BikwqKRWAB9FCX2PznkgiumcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_125743_846470_275C5AFC 
X-CRM114-Status: GOOD (  23.29  )
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
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30 2018 at 01:25 -0700, Ulf Hansson wrote:
>On Thu, 29 Nov 2018 at 23:31, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Hi Ulf,
>>
>> On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
>> >When the hierarchical CPU topology is used and when a CPU has been put
>> >offline (hotplug), that same CPU prevents its PM domain and thus also
>> >potential master PM domains, from being powered off. This is because genpd
>> >observes the CPU's struct device to remain being active from a runtime PM
>> >point of view.
>> >
>> >To deal with this, let's decrease the runtime PM usage count by calling
>> >pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
>> >offline. Consequentially, we must then increase the runtime PM usage for
>> >the CPU, while putting it online again.
>> >
>> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >---
>> >
>> >Changes in v10:
>> >       - Make it work when the hierarchical CPU topology is used, which may be
>> >         used both for OSI and PC mode.
>> >       - Rework the code to prevent "BUG: sleeping function called from
>> >         invalid context".
>> >---
>> > drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
>> > 1 file changed, 20 insertions(+)
>> >
>> >diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>> >index b03bccce0a5d..f62c4963eb62 100644
>> >--- a/drivers/firmware/psci/psci.c
>> >+++ b/drivers/firmware/psci/psci.c
>> >@@ -15,6 +15,7 @@
>> >
>> > #include <linux/acpi.h>
>> > #include <linux/arm-smccc.h>
>> >+#include <linux/cpu.h>
>> > #include <linux/cpuidle.h>
>> > #include <linux/errno.h>
>> > #include <linux/linkage.h>
>> >@@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
>> >
>> > static int psci_cpu_off(u32 state)
>> > {
>> >+      struct device *dev;
>> >       int err;
>> >       u32 fn;
>> >
>> >+      /*
>> >+       * When the hierarchical CPU topology is used, decrease the runtime PM
>> >+       * usage count for the current CPU, as to allow other parts in the
>> >+       * topology to enter low power states.
>> >+       */
>> >+      if (psci_dt_topology) {
>> >+              dev = get_cpu_device(smp_processor_id());
>> >+              pm_runtime_put_sync_suspend(dev);
>> >+      }
>> >+
>> >       fn = psci_function_id[PSCI_FN_CPU_OFF];
>> >       err = invoke_psci_fn(fn, state, 0, 0);
>> >       return psci_to_linux_errno(err);
>> >@@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
>> >
>> > static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>> > {
>> >+      struct device *dev;
>> >       int err;
>> >       u32 fn;
>> >
>> >@@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>> >       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
>> >       /* Clear the domain state to start fresh. */
>> >       psci_set_domain_state(0);
>> >+
>> >+      /* Increase runtime PM usage count if the hierarchical CPU toplogy. */
>> >+      if (!err && psci_dt_topology) {
>> >+              dev = get_cpu_device(cpuid);
>> >+              pm_runtime_get_sync(dev);
>>
>> I booted with a single CPU on my SDM845 device and when I tried to
>> online CPU1 and I see a crash.
>
>Thanks for testing!
>
>If I understand correctly, that means that you haven't registered CPU1
>using register_cpu(), hence there are no struct device created for it.
>It sound like a special case, but on the other hand we shouldn't
>crash, or course.
This infact is pretty common. Devices boot with only with low power
cores and bring in the high perf cores only when needed.
>
>I guess a simple check like this would help.
>
>if (dev)
>    pm_runtime_get_sync(dev);
>
>...and then we need a similar check in psci_cpu_off() to deal with
>putting the CPU offline.
>
>Could you try this and see if it helps?
>
Yes, it fixes the issue.

Thanks,
Lina

>>
>> # echo 1 > /sys/devices/system/cpu/cpu1/online
>>
>> [   86.339204] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000188
>> [   86.340195] Detected VIPT I-cache on CPU1
>> [   86.348075] Mem abort info:
>> [   86.348092] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
>> [   86.352125]   ESR = 0x96000006
>> [   86.352194] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]
>> [   86.354956]   Exception class = DABT (current EL), IL = 32 bits
>> [   86.377700]   SET = 0, FnV = 0
>> [   86.380788]   EA = 0, S1PTW = 0
>> [   86.383967] Data abort info:
>> [   86.386882]   ISV = 0, ISS = 0x00000006
>> [   86.390760]   CM = 0, WnR = 0
>> [   86.393755] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>> [   86.400430] [0000000000000188] pgd=00000001f5233003, pud=00000001f5234003, pmd=0000000000000000
>> [   86.409203] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> [   86.414824] Modules linked in:
>> [   86.417915] CPU: 0 PID: 1533 Comm: sh Not tainted 4.20.0-rc3-30359-gff2e21952bd5 #782
>> [   86.425807] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
>> [   86.432387] pstate: 80400005 (Nzcv daif +PAN -UAO)
>> [   86.437233] pc : __pm_runtime_resume+0x20/0x74
>> [   86.441720] lr : psci_cpu_on+0x84/0x90
>> [   86.445498] sp : ffff00000db43a10
>> [   86.448842] x29: ffff00000db43a10 x28: ffff80017562b500
>> [   86.454200] x27: ffff000009159000 x26: 0000000000000055
>> [   86.459556] x25: 0000000000000000 x24: ffff0000092c4bc8
>> [   86.464913] x23: ffff000008fb8000 x22: ffff00000916a000
>> [   86.470269] x21: 0000000000000100 x20: ffff000009314190
>> [   86.475625] x19: 0000000000000000 x18: 0000000000000000
>> [   86.480979] x17: 0000000000000000 x16: 0000000000000000
>> [   86.486334] x15: 0000000000000000 x14: ffff000009162600
>> [   86.491690] x13: 0000000000000300 x12: 0000000000000010
>> [   86.497047] x11: ffffffffffffffff x10: ffffffffffffffff
>> [   86.502399] x9 : 0000000000000001 x8 : 0000000000000000
>> [   86.507753] x7 : 0000000000000000 x6 : 0000000000000000
>> [   86.513108] x5 : 0000000000000000 x4 : 0000000000000000
>> [   86.518463] x3 : 0000000000000188 x2 : 0000800174385000
>> [   86.523820] x1 : 0000000000000004 x0 : 0000000000000000
>> [   86.529175] Process sh (pid: 1533, stack limit = 0x(____ptrval____))
>> [   86.535585] Call trace:
>> [   86.538063]  __pm_runtime_resume+0x20/0x74
>> [   86.542197]  psci_cpu_on+0x84/0x90
>> [   86.545639]  cpu_psci_cpu_boot+0x3c/0x6c
>> [   86.549593]  __cpu_up+0x68/0x210
>> [   86.552852]  bringup_cpu+0x30/0xe0
>> [   86.556293]  cpuhp_invoke_callback+0x84/0x1e0
>> [   86.560689]  _cpu_up+0xe0/0x1d0
>> [   86.563862]  do_cpu_up+0x90/0xb0
>> [   86.567118]  cpu_up+0x10/0x18
>> [   86.570113]  cpu_subsys_online+0x44/0x98
>> [   86.574079]  device_online+0x68/0xac
>> [   86.577685]  online_store+0xa8/0xb4
>> [   86.581202]  dev_attr_store+0x18/0x28
>> [   86.584908]  sysfs_kf_write+0x40/0x48
>> [   86.588606]  kernfs_fop_write+0xcc/0x1cc
>> [   86.592563]  __vfs_write+0x40/0x16c
>> [   86.596078]  vfs_write+0xa8/0x1a0
>> [   86.599424]  ksys_write+0x58/0xbc
>> [   86.602768]  __arm64_sys_write+0x18/0x20
>> [   86.606733]  el0_svc_common+0x94/0xf0
>> [   86.610433]  el0_svc_handler+0x24/0x80
>> [   86.614215]  el0_svc+0x8/0x7c0
>> [   86.617300] Code: aa0003f3 361000e1 91062263 f9800071 (885f7c60)
>> [   86.623447] ---[ end trace 4573c3c0e0761290 ]---
>>
>> >+      }
>> >+
>> >       return psci_to_linux_errno(err);
>> > }
>> >
>> >--
>> >2.17.1
>> >
>>
>> Thanks,
>> Lina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
