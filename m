Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9536C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:12:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAED521473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s43y3RaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAED521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solinno.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v9P5u7Ed9oJJ6D7nOD2Lh+C9zhe0KQpR96dqKFdpIlo=; b=s43y3RaPY2Lk1flYLhwwMnf3F
	R0dDoq7OHqW2yOnrVMUdwiZHRWUCYLYPuWgxEh2NUNK9ggnXKbKcAh3yT4DYHQE/vaGLlkqUrzyio
	ID54Zs60O+534WN975O0xl5UK7t3bz9nlHHoBIysN/fEQ7hv1T/dBgsq3HIE2jbxiLL0bQpjgQQaH
	nrZDkGhRDHBs6IqyMMpWh4urPhxzRDaIpyellITKsZ7jl6kSVFQ+XCkf5nbdUiREHE3etGZOOYSHI
	hK5ysQpMUowBpDWZMiaXBFY8Vdc8U3vZPijUipx/5K5jGz4ejOY1vfoobQ34FLALj/QkTIAa7d+50
	CoW48LLQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goU7L-0006ZD-OS; Tue, 29 Jan 2019 14:11:59 +0000
Received: from doppler.thel33t.co.uk ([185.153.207.61])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goU7G-0006Yo-Dx
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:11:57 +0000
Received: from doppler.thel33t.co.uk (localhost [127.0.0.1])
 by doppler.thel33t.co.uk (Postfix) with ESMTP id C59BC2099F;
 Tue, 29 Jan 2019 14:11:52 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 29 Jan 2019 14:11:52 +0000
From: Leigh Brown <leigh@solinno.co.uk>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: Out-of-tree mwlwifi driver crashes
In-Reply-To: <20190129135346.tg2cefmyfvq2dxc5@e5254000004ec.dyn.armlinux.org.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
 <20190129135346.tg2cefmyfvq2dxc5@e5254000004ec.dyn.armlinux.org.uk>
Message-ID: <9ba66e5b5d20ecfbf8641898b543161c@solinno.co.uk>
X-Sender: leigh@solinno.co.uk
User-Agent: Roundcube Webmail/1.3.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_061154_756293_FA3BF8E4 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-29 13:53, Russell King - ARM Linux admin wrote:
> On Tue, Jan 29, 2019 at 01:47:38PM +0000, Leigh Brown wrote:
>> Hi Thomas,
>> 
>> The following commit causes the out-of-tree mwlwifi driver [1] to 
>> crash,
>> which
>> I have found with git bisect.
>> 
>> commit 1f08673eef1236f7d02d93fcf596bb8531ef0d12
>> Author: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>> Date:   Thu Oct 18 17:37:18 2018 +0200
>> 
>>     PCI: mvebu: Convert to PCI emulated bridge config space
>> 
>>     Convert the pci-mvebu driver to use the pci-bridge-emul logic, 
>> that
>>     helps emulating a root port PCI bridge configuration space.
>> 
>>     Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>>     [lorenzo.pieralisi@arm.com: updated commit log]
>>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> 
>> I have raised the issue with the driver maintainers but they responded 
>> that
>> this is a kernel regression [2].
>> 
>> Do you think this is a driver issue or a regression? I am happy to 
>> test
>> proposed
>> fixes but I don't understand enough about the driver or PCI to 
>> investigate.
>> 
>> If I revert that single commit, the issue goes away.
>> 
>> Any help would be gratefully received.
>> 
>> The crash dump is as follows:
>> 
>> pgd = f47c1616
> 
> All crash dumps have a line before this which describes why the crash
> dump is being produced - cutting it out of the crash dump makes it
> much harder to know what happened.  Please re-post with the full crash
> dump.  Thanks.
> 
[snip incorrect dump]

Woops, sorry. Here is another dump, hopefully I haven't missed anything.
If you need any more information, please let me know.

[....] Waiting for /dev to be fully populated...sd 2:0:0:0: Attached 
scsi generic sg0 type 0
<<Marvell Mac80211 Wireless PCIE Network Driver version 
10.3.8.0-20181210>>
pci 0000:00:01.0: enabling device (0140 -> 0142)
ieee80211 phy0: priv->pcmd_buf = 26d7c639  priv->pphys_cmd_buf = 
3c1b4384
Unhandled fault: external abort on non-linefetch (0x1008) at 0xd1480c14
pgd = cf4c3420
[d1480c14] *pgd=1ea6b811, *pte=e0100243, *ppte=e0100013
Internal error: : 1008 [#1] SMP THUMB2
Modules linked in: mwlwifi(+) sg
CPU: 0 PID: 421 Comm: systemd-udevd Not tainted 5.0.0-rc3 #2
Hardware name: Marvell Armada 380/385 (Device Tree)
PC is at pcie_reset+0xc/0x40 [mwlwifi]
LR is at pcie_download_firmware+0x19/0x2fc [mwlwifi]
pc : [<af815c0c>]    lr : [<af815c59>]    psr: 60070033
sp : ce2a5c58  ip : ce9ff0c0  fp : b0808c08
r10: 000029a8  r9 : ce9ff080  r8 : 000029a4
r7 : 00000000  r6 : cdcc0480  r5 : cdcc0e20  r4 : cdcc57e0
r3 : cdcc0e20  r2 : d1480000  r1 : cdcc0e20  r0 : cdcc0480
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
Control: 50c5387d  Table: 1620004a  DAC: 00000051
Process systemd-udevd (pid: 421, stack limit = 0x9ec239b5)
Stack: (0xce2a5c58 to 0xce2a6000)
5c40:                                                       cdcc57e0 
af815c59
5c60: cf447070 000029a4 00000000 000029a8 00000000 cdcc0e20 af81e372 
00000000
5c80: 00000000 000029a4 00000000 000029a8 b0808c08 af80e87d 1ea60000 
ce87c940
5ca0: cdcc0480 b0808c08 cf447070 bf9649ae 00100000 cdcc57e0 cf447000 
cdcc0480
5cc0: cdcc0e20 cf447000 af81d298 cf447070 b084adfc af815515 00019100 
af820104
5ce0: af820104 cf447070 cf447000 00000000 af8200b4 af82007c 00000013 
b026372b
5d00: b02636bf cf447070 00000000 00000000 b084adf0 00000000 af8200b4 
b028f6b7
5d20: 00000000 cf447070 af8200b4 af8200b4 b028f9b1 00000000 00000024 
00000028
5d40: ce9ffee4 b028f993 af8200b4 cf447070 00000000 cf447070 cf4470a4 
af8200b4
5d60: b028f9b1 00000000 00000024 b028f9fb cf447070 b0808c08 af8200b4 
b028e755
5d80: ce2a5da8 cf414358 ce99de34 bf9649ae 00000000 af8200b4 ce87c380 
00000000
5da0: b081ac50 b028ec2f af81e0e3 af81e0e4 0000006d af8200b4 b0808c08 
af826001
5dc0: ffffe000 b028fe89 af8200fc b0834680 b0808c08 b0102601 00000001 
006000c0
5de0: b082ffc0 cfce6560 0000762b b017c98d 00000001 b0808c08 8040003f 
cfeaa3e4
5e00: cfce6564 bf9649ae cf6190c0 cffe6320 00000001 00000001 cffe6320 
00000001
5e20: 00000001 bf9649ae af820580 af820580 ce9ff640 ce9ffec0 00000001 
b0160e4d
5e40: af820580 b072f6fc ce2a5f40 af820580 00000001 b016049f af82058c 
00007fff
5e60: af820580 b015e8a9 cf1415c0 af8205c8 b015e7e9 b08134d0 b05029fc 
d129a4bc
5e80: a6eecbb8 000001d6 ffffe000 ce2a4000 af000000 00000000 b0808c08 
b01a42a3
5ea0: 00000000 00000000 00000000 00000000 00000000 00000000 6e72656b 
00006c65
5ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
5ee0: 00000000 00000000 00000000 00000000 00000000 bf9649ae 7fffffff 
00000000
5f00: b0808c08 a6eecbb8 0000000c b0101224 ce2a4000 0000017b 00a6b0d8 
b0160943
5f20: 7fffffff 00000000 00000003 00000000 0001a534 d1280000 0001a534 
00000000
5f40: d128ff78 d1290580 d1280000 0001a534 d1299fbc d1299e58 d1294088 
00013000
5f60: 00014d70 00000000 00000000 00000000 00005ea8 00000020 00000021 
00000017
5f80: 00000000 00000013 00000000 bf9649ae 0000000c 00a6b0d8 00a6a3c8 
941a5c00
5fa0: 0000017b b0101001 00a6b0d8 00a6a3c8 0000000c a6eecbb8 00000000 
a6eed398
5fc0: 00a6b0d8 00a6a3c8 941a5c00 0000017b 00020000 0051e6c4 00000000 
00a6b0d8
5fe0: aeab5948 aeab5938 a6ee6aeb a6df6fc2 600f0030 0000000c 00000000 
00000000
[<af815c0c>] (pcie_reset [mwlwifi]) from [<af815c59>] 
(pcie_download_firmware+0x19/0x2fc [mwlwifi])
[<af815c59>] (pcie_download_firmware [mwlwifi]) from [<af80e87d>] 
(mwl_init_hw+0x101/0x8b8 [mwlwifi])
[<af80e87d>] (mwl_init_hw [mwlwifi]) from [<af815515>] 
(pcie_probe+0x169/0x1bc [mwlwifi])
[<af815515>] (pcie_probe [mwlwifi]) from [<b026372b>] 
(pci_device_probe+0x6d/0xb6)
[<b026372b>] (pci_device_probe) from [<b028f6b7>] 
(really_probe+0x137/0x1c4)
[<b028f6b7>] (really_probe) from [<b028f993>] 
(driver_probe_device+0xef/0x10c)
[<b028f993>] (driver_probe_device) from [<b028f9fb>] 
(__driver_attach+0x4b/0x6e)
[<b028f9fb>] (__driver_attach) from [<b028e755>] 
(bus_for_each_dev+0x31/0x5c)
[<b028e755>] (bus_for_each_dev) from [<b028ec2f>] 
(bus_add_driver+0xd7/0x130)
[<b028ec2f>] (bus_add_driver) from [<b028fe89>] 
(driver_register+0x5b/0x8a)
[<b028fe89>] (driver_register) from [<b0102601>] 
(do_one_initcall+0x45/0xfc)
[<b0102601>] (do_one_initcall) from [<b0160e4d>] 
(do_init_module+0x39/0x134)
[<b0160e4d>] (do_init_module) from [<b016049f>] 
(load_module+0x1141/0x1492)
[<b016049f>] (load_module) from [<b0160943>] 
(sys_finit_module+0x53/0x6c)
[<b0160943>] (sys_finit_module) from [<b0101001>] 
(ret_fast_syscall+0x1/0x62)
Exception stack(0xce2a5fa8 to 0xce2a5ff0)
5fa0:                   00a6b0d8 00a6a3c8 0000000c a6eecbb8 00000000 
a6eed398
5fc0: 00a6b0d8 00a6a3c8 941a5c00 0000017b 00020000 0051e6c4 00000000 
00a6b0d8
5fe0: aeab5948 aeab5938 a6ee6aeb a6df6fc2
Code: 727c 6b43 589c 68e2 (f8d2) 2c14
---[ end trace e65bfe3eaf372676 ]---
Kernel panic - not syncing: Fatal exception
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.0.0-rc3 #2
Hardware name: Marvell Armada 380/385 (Device Tree)
[<b010a6ad>] (unwind_backtrace) from [<b010800f>] (show_stack+0xb/0xc)
[<b010800f>] (show_stack) from [<b04408d7>] (dump_stack+0x5b/0x70)
[<b04408d7>] (dump_stack) from [<b0109ba5>] (handle_IPI+0x95/0x118)
[<b0109ba5>] (handle_IPI) from [<b0251655>] (gic_handle_irq+0x59/0x68)
[<b0251655>] (gic_handle_irq) from [<b0101a65>] (__irq_svc+0x65/0x94)
Exception stack(0xcf469f60 to 0xcf469fa8)
9f60: 00000000 00037908 cfbe43a0 b010e0e1 00000000 cf468000 b0808c08 
00000000
9f80: 00000002 cf469fb8 b0808c68 00000000 00000008 cf469fb0 b0106367 
b010635e
9fa0: 40070033 ffffffff
[<b0101a65>] (__irq_svc) from [<b010635e>] (arch_cpu_idle+0xc/0x1e)
[<b010635e>] (arch_cpu_idle) from [<b01330a7>] (do_idle+0xd7/0x17c)
[<b01330a7>] (do_idle) from [<b01332b7>] (cpu_startup_entry+0x13/0x14)
[<b01332b7>] (cpu_startup_entry) from [<001023b1>] (0x1023b1)
Rebooting in 1 seconds..

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
