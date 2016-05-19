From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 19 May 2016 20:35:29 +0300
Subject: Regression: next-20160518: Clk? on BeagleBoard-X15
In-Reply-To: <20160519165719.GW5995@atomide.com>
References: <573DDFE6.8010209@ti.com> <20160519165719.GW5995@atomide.com>
Message-ID: <573DF961.4070705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/16 19:57, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160519 08:48]:
>> I have'nt bisected yet, but the platform seems to have booted on
>> next-20160517
>> https://github.com/nmenon/kernel-test-logs/blob/next-20160517/omap2plus_defconfig/am57xx-evm.txt
>>
>> https://github.com/nmenon/kernel-test-logs/blob/next-20160518/omap2plus_defconfig/am57xx-evm.txt
> 
> Seems to be commit ac78f9bdcf38 ("drivers/of: Fix depth when
> unflattening devicetree").
> 
> Rob, you need to start playing golf or something between -rc6 and
> the end of the merge window or something :)

I'm not sure if it's related, but I'm seeing this on omap4 panda, next-20160519:

[    0.000000] Unable to handle kernel paging request at virtual address af6ec820
...
[    0.000000] [<c071ced4>] (unflatten_dt_nodes) from [<c071d5a4>] (__unflatten_device_tree+0xe8/0x254)
[    0.000000]  r10:c0de3140 r9:ef6b44a4 r8:c15b77c0 r7:00000000 r6:cffee000 r5:00038358
[    0.000000]  r4:c0de00c0
[    0.000000] [<c071d4bc>] (__unflatten_device_tree) from [<c0c4a050>] (unflatten_device_tree+0x28/0x40)
[    0.000000]  r9:0000000c r8:c0d07ca8 r7:c159f4f4 r6:c0d520f8 r5:c0c5984c r4:c0c491a0
[    0.000000] [<c0c4a028>] (unflatten_device_tree) from [<c0c04754>] (setup_arch+0x770/0xbb4)
[    0.000000]  r5:c0c5984c r4:c0d02908
[    0.000000] [<c0c03fe4>] (setup_arch) from [<c0c009c8>] (start_kernel+0x50/0x3c4)
[    0.000000]  r10:00000000 r9:412fc09a r8:8000406a r7:c0d02900 r6:c0c5ba44 r5:c0d029ac
[    0.000000]  r4:c0de3214
[    0.000000] [<c0c00978>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000]  r10:00000000 r9:412fc09a r8:8000406a r7:c0d07de8 r6:c0c5ba44 r5:c0d029ac
[    0.000000]  r4:c0de3214

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160519/b70f5f89/attachment.sig>
