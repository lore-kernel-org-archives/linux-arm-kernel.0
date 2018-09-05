From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 05 Sep 2018 15:46:41 +0800
Subject: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
In-Reply-To: <20180905071435.lgsogpzmh5nw6bcy@flea>
References: <20180903133434.58188-1-icenowy@aosc.io>
 <20180903133434.58188-2-icenowy@aosc.io>
 <20180905071435.lgsogpzmh5nw6bcy@flea>
Message-ID: <3D28A45F-D67D-4388-9FB7-2A2763955398@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?9?5? GMT+08:00 ??3:14:35, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
>> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
>> introduced in R40, although it has two PLL-VIDEOs.
>> 
>> Change the A64 HDMI PHY binding to R40 one.
>> 
>> This binding is introduced in v4.19, which is still in RC stage, so
>we
>> have change to fix it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>That doesn't make much sense. The A64 doesn't have any particular
>reason to behave like the R40, and the R40 can definitely use a
>different compatible if it has a different behaviour. But I don't see
>*why* the A64 not behaving like the R40 is a justification to remove
>the A64 compatible. Especially when the R40 was released later.
>
>Add a new compatible, and leave the A64 compatible alone.

But the behavior of A64 compatible will change from double
PLL to single PLL, because the A64 HDMI PHY is proven
to have no double PLL.

Should I then change the A64 compatible behavior and import R40 compatible at the same time?

In addition maybe I can just drop A64 compatible, and let A64
use H3 one. Then I will add a R40 compatible to catch
dual PLL behavior.

>
>Maxime
