From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 05 Sep 2018 16:05:18 +0800
Subject: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
In-Reply-To: <20180905075601.32kzkd3is2gpa3ft@flea>
References: <20180903133434.58188-1-icenowy@aosc.io>
 <20180903133434.58188-2-icenowy@aosc.io>
 <20180905071435.lgsogpzmh5nw6bcy@flea>
 <3D28A45F-D67D-4388-9FB7-2A2763955398@aosc.io>
 <20180905075601.32kzkd3is2gpa3ft@flea>
Message-ID: <1CE38B34-005F-4E49-B9B5-48EDFA56EFE5@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?9?5? GMT+08:00 ??3:56:01, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Wed, Sep 05, 2018 at 03:46:41PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> ? 2018?9?5? GMT+08:00 ??3:14:35, Maxime Ripard
><maxime.ripard@bootlin.com> ??:
>> >On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
>> >> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
>> >> introduced in R40, although it has two PLL-VIDEOs.
>> >> 
>> >> Change the A64 HDMI PHY binding to R40 one.
>> >> 
>> >> This binding is introduced in v4.19, which is still in RC stage,
>so
>> >we
>> >> have change to fix it.
>> >> 
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >
>> >That doesn't make much sense. The A64 doesn't have any particular
>> >reason to behave like the R40, and the R40 can definitely use a
>> >different compatible if it has a different behaviour. But I don't
>see
>> >*why* the A64 not behaving like the R40 is a justification to remove
>> >the A64 compatible. Especially when the R40 was released later.
>> >
>> >Add a new compatible, and leave the A64 compatible alone.
>> 
>> But the behavior of A64 compatible will change from double
>> PLL to single PLL, because the A64 HDMI PHY is proven
>> to have no double PLL.
>> 
>> Should I then change the A64 compatible behavior and import R40
>> compatible at the same time?
>
>I don't see why you should do both at the same time. Fix the A64, and
>add the support for the R40, those are two orthogonal changes.

Then how to deal with double PLL support? Make them temporarily
dead during 4.19?

>
>> In addition maybe I can just drop A64 compatible, and let A64
>> use H3 one.
>
>No, that break the backward compatibility.

As I said A64 compatible is just introduced in 4.19-rc.

So if we finish before 4.19.0 we break nothing.

>
>Maxime
