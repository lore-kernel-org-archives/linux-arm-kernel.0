From: monstr@monstr.eu (Michal Simek)
Date: Fri, 14 Feb 2014 09:55:26 +0100
Subject: [PATCH v2] can: xilinx CAN controller support.
In-Reply-To: <52FD1B16.6020600@pengutronix.de>
References: <\> <0dc128ac-e5cd-47bd-9ab1-3a545c3e2043@CO9EHSMHS012.ehs.local>
 <52FD1B16.6020600@pengutronix.de>
Message-ID: <52FDD9FE.8040908@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

>> +	int waiting_ech_skb_num;
>> +	int xcan_echo_skb_max_tx;
>> +	int xcan_echo_skb_max_rx;
>> +	struct napi_struct napi;
>> +	spinlock_t ech_skb_lock;
>> +	u32 (*read_reg)(const struct xcan_priv *priv, int reg);
>> +	void (*write_reg)(const struct xcan_priv *priv, int reg, u32 val);
> 
> Please remove read_reg, write_reg, as long as there isn't any BE support
> in the driver, call them directly.

That's not entirely truth. If you look at Microblaze then you will see
that Microblaze can be BE and LE.
There is just missing endian detection which we will add to the next version.

But because MB io helper functions are broken for a while you should be
able to use this driver on both endianess.

btw: I would prefer to use ioread32 and ioread32be instead of readl.
Is it OK for you?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/5d8e681c/attachment.sig>
