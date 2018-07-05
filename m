From: zhongmiao@hisilicon.com (Zhongmiao)
Date: Thu, 5 Jul 2018 13:19:55 +0000
Subject: full  error log //: question about : inv smmu atc all cmd timeout
 when pcie dpc occur.
Message-ID: <8CD08B4737CACA4ABE0228F45E441A9163803DCE@dggemm521-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ 3578.841549] dpc 0000:00:08.0:pcie010: DPC containment event, status:0x1f19 source:0x0000
[ 3578.858810] dpc 0000:00:08.0:pcie010: DPC unmasked uncorrectable error detected, remove downstream devices
[ 3620.881021] arm-smmu-v3 arm-smmu-v3.0.auto: unexpected global error reported (0x00000001), this could be serious
[ 3620.902125] arm-smmu-v3 arm-smmu-v3.0.auto: CMDQ error (cons 0x0300001f): ATC invalidate timeout
[ 3620.927003] iommu: Removing device 0000:01:00.3 from group 4
[ 3662.952221] watchdog: BUG: soft lockup - CPU#0 stuck for 39s! [kworker/0:0:3]
[ 3662.967078] Modules linked in: host_sdi_driver(OE) hi1620_pcie_mctp_int(OE) hi1620_pcie_pressure_task(OE) hi1620_ep_master(OE) hi1620_pcie_ep_feature(OE) hi1620_rc_master(OE) hi1620_pcie_rc_feature(OE) hi1620_pcie_feature(OE) hi1620_hal(OE) hi1620_reg_hal(O) pmu_cfg(POE) unibsp(OE)
[ 3663.019873] CPU: 0 PID: 3 Comm: kworker/0:0 Tainted: P           OEL  4.14.10 #9
[ 3663.036088] Workqueue: events interrupt_event_handler
[ 3663.046801] task: ffff80003dafa100 task.stack: ffff000008068000
[ 3663.059629] PC is at _raw_spin_unlock_irqrestore+0x2c/0x38
[ 3663.071615] LR is at arm_smmu_cmdq_issue_cmd+0x150/0x208
[ 3663.082565] pc : [<ffff000008dd24b4>] lr : [<ffff0000086ff1a0>] pstate: 40c00145
[ 3663.097667] sp : ffff00000806b990
[ 3663.104591] x29: ffff00000806b990 x28: ffff8000130b4030 
[ 3663.115773] x27: ffff000008ec44a8 x26: ffff0000096b97b0 
[ 3663.126908] x25: 0000000000000001 x24: ffff00000806ba28 
[ 3663.138020] x23: ffff8000130b4018 x22: ffff8000130b4098 
[ 3663.149149] x21: ffff000009549000 x20: ffff8000130b4098 
[ 3663.160273] x19: 0000000000000140 x18: 0000000000000006 
[ 3663.171379] x17: 0000ffffa1e9046c x16: ffff0000082b91e8 
[ 3663.182487] x15: ffff000009dab705 x14: ffff800035909998 
[ 3663.193585] x13: ffff80003a3b7d90 x12: 0000000005f5e0ff 
[ 3663.204696] x11: 0000000000000000 x10: 00000000000f2182 
[ 3663.215799] x9 : 0000000000000041 x8 : 0000000000000010 
[ 3663.226926] x7 : 0000000000000100 x6 : 0037502800000000 
[ 3663.238028] x5 : 0000000000000018 x4 : 000000000005c164 
[ 3663.249136] x3 : 00000000a0000000 x2 : 00000000000000ff 
[ 3663.260232] x1 : 0000000000000140 x0 : 0000000000000025 
[ 3663.271429] Call trace:
[ 3663.276840] Exception stack(0xffff00000806b850 to 0xffff00000806b990)
[ 3663.290138] b840:                                   0000000000000025 0000000000000140
[ 3663.306232] b860: 00000000000000ff 00000000a0000000 000000000005c164 0000000000000018
[ 3663.322299] b880: 0037502800000000 0000000000000100 0000000000000010 0000000000000041
[ 3663.338374] b8a0: 00000000000f2182 0000000000000000 0000000005f5e0ff ffff80003a3b7d90
[ 3663.354445] b8c0: ffff800035909998 ffff000009dab705 ffff0000082b91e8 0000ffffa1e9046c
[ 3663.370498] b8e0: 0000000000000006 0000000000000140 ffff8000130b4098 ffff000009549000
[ 3663.386531] b900: ffff8000130b4098 ffff8000130b4018 ffff00000806ba28 0000000000000001
[ 3663.402579] b920: ffff0000096b97b0 ffff000008ec44a8 ffff8000130b4030 ffff00000806b990
[ 3663.418625] b940: ffff0000086ff1a0 ffff00000806b990 ffff000008dd24b4 0000000040c00145
[ 3663.434673] b960: 0000034a9921fc00 0000000000000001 ffffffffffffffff ffff0000086ff220
[ 3663.450660] b980: ffff00000806b990 ffff000008dd24b4
[ 3663.460921] [<ffff000008dd24b4>] _raw_spin_unlock_irqrestore+0x2c/0x38
[ 3663.474519] [<ffff0000086ff1a0>] arm_smmu_cmdq_issue_cmd+0x150/0x208
[ 3663.487640] [<ffff0000087009b0>] arm_smmu_atc_inv_master.isra.14+0xe0/0xe8
[ 3663.501749] [<ffff000008700a28>] arm_smmu_atc_inv_master_all+0x70/0x98
[ 3663.515174] [<ffff000008700a94>] arm_smmu_detach_dev+0x44/0xa8
[ 3663.527239] [<ffff000008701068>] arm_smmu_remove_device+0x140/0x1b0
[ 3663.540184] [<ffff0000086f45b4>] iommu_bus_notifier+0xdc/0x120
[ 3663.552650] [<ffff0000080f76b4>] notifier_call_chain+0x5c/0xa0
[ 3663.564752] [<ffff0000080f7c00>] __blocking_notifier_call_chain+0x58/0xa0
[ 3663.578754] [<ffff0000080f7c84>] blocking_notifier_call_chain+0x3c/0x50
[ 3663.592583] [<ffff0000089296d4>] device_del+0x25c/0x338
[ 3663.603797] [<ffff0000085e9c70>] pci_remove_bus_device+0x80/0xf0
[ 3663.616284] [<ffff0000085e9d08>] pci_stop_and_remove_bus_device+0x28/0x38
[ 3663.630291] [<ffff000008607518>] interrupt_event_handler+0x98/0x228
[ 3663.643504] [<ffff0000080ee970>] process_one_work+0x150/0x418
[ 3663.655432] [<ffff0000080eec90>] worker_thread+0x58/0x498
[ 3663.666596] [<ffff0000080f5b48>] kthread+0x108/0x138
[ 3663.677176] [<ffff0000080856c4>] ret_from_fork+0x10/0x1c
[ 3663.690547] arm-smmu-v3 arm-smmu-v3.0.auto: unexpected global error reported (0x00000001), this could be serious
[ 3663.711644] arm-smmu-v3 arm-smmu-v3.0.auto: CMDQ error (cons 0x03000025): ATC invalidate timeout
[ 3663.741625] iommu: Removing device 0000:01:00.2 from group 3
[ 3705.742592] arm-smmu-v3 arm-smmu-v3.0.auto: unexpected global error reported (0x00000001), this could be serious
[ 3705.763739] arm-smmu-v3 arm-smmu-v3.0.auto: CMDQ error (cons 0x0300002b): ATC invalidate timeout
[ 3705.790830] iommu: Removing device 0000:01:00.1 from group 2
[ 3747.794475] arm-smmu-v3 arm-smmu-v3.0.auto: unexpected global error reported (0x00000001), this could be serious
[ 3747.815568] arm-smmu-v3 arm-smmu-v3.0.auto: CMDQ error (cons 0x03000031): ATC invalidate timeout
[ 3747.842761] iommu: Removing device 0000:01:00.0 from group 1
[ 3747.876773] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x05 received:
[ 3747.890674] arm-smmu-v3 arm-smmu-v3.0.auto: 	0x0000010000000005
[ 3747.903820] arm-smmu-v3 arm-smmu-v3.0.auto: 	0x0000000900000000
[ 3747.916533] arm-smmu-v3 arm-smmu-v3.0.auto: 	0x00000000fffff000
[ 3747.929274] arm-smmu-v3 arm-smmu-v3.0.auto: 	0x0000000035c48000


On 04/07/18 03:12, Zhongmiao wrote:
> On Mon, Jul 02, 2018 at 02:24:45PM +0000, Zhongmiao wrote:
>>       I?m testing  pcie  ats feature .     when some  error occur pcie dpc
>>  then  link down .  iommu will   remove device from iommu group and send  atc
>> inv all  cmd to  device .
>>
>>  
>>
>> But , pcie already  link down , so  atc inv all  will   time out .  I what to
>> know kernel  driver  how to think aout it  ?  thanks .  ^_^.

Thanks for the report, the interaction between ATS and DPC is an interesting one, and I hadn't been able to trigger an ATC timeout so far.

An ATC inv timeout shouldn't be fatal, and after seeing this error you should still be able to use the SMMU. It's not clear from your kernel log, does the SMMU driver recover cleanly? Can you continue using it for other endpoints?

As to the messages you're seeing, if it's just a couple of extra warnings in a situation as exceptional as DPC error, it might fine as is. But if it bothers you, maybe we could call pci_dev_is_disconnected before sending an ATC-inv-all, I think the core sets this bit before removing the device.

Thanks,
Jean
