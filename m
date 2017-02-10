From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Feb 2017 09:05:14 +0100
Subject: [PATCH v3 2/3] nvmem: sunxi-sid: add support for H3's SID
 controller
In-Reply-To: <4664661486474595@web28j.yandex.ru>
References: <20170202131338.20234-1-icenowy@aosc.xyz>
 <20170202131338.20234-2-icenowy@aosc.xyz>
 <20170206085416.4qtd3wfhtinp42xv@lukather>
 <5119511486371415@web15m.yandex.ru>
 <20170207092503.3nh2g6orkgjgdi7q@lukather>
 <4664661486474595@web28j.yandex.ru>
Message-ID: <20170210080514.nrryisw4y2wbs5wk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 09:36:35PM +0800, Icenowy Zheng wrote:
> >> ?>> ?@@ -51,7 +64,8 @@ static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
> >> ?>> ??{
> >> ?>> ??????????u32 sid_key;
> >> ?>>
> >> ?>> ?- sid_key = ioread32be(sid->base + round_down(offset, 4));
> >> ?>> ?+ sid_key = ioread32be(sid->base + sid->value_offset +
> >> ?>> ?+ round_down(offset, 4));
> >> ?>
> >> ?> This would probably be more logical to have this in sunxi_sid_read.
> >>
> >> ?But it's here which really access the memory...
> >
> > This function is made to read a single register. What you want is to
> > offset all reads, and all the reads are made in sunxi_sid_read.
> 
> I think the semantic of this function is to read out one byte from SID,
> not read out a single register from SID; the parameter passed into it is
> also a const struct *sunxi_sid, so I think make the offset here is right.

You need to offset *all* register reads, it makes much more sense to
do that offset in the function that reads all the registers, and not
just one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/616ea9da/attachment.sig>
