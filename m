From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 12 Sep 2018 23:37:24 +0800
Subject: [linux-sunxi] Re: [PATCH 02/27] arm64: allwinner: h6: add system
 controller device tree node
In-Reply-To: <CAGb2v64t40yTbrnkg33N2=jBdnvV45H1XSCF8U230LGAyuVySw@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-3-jernej.skrabec@siol.net>
 <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
 <9915D9F1-1C60-4AEF-9074-CE040FCD7BF0@aosc.io>
 <CAGb2v64t40yTbrnkg33N2=jBdnvV45H1XSCF8U230LGAyuVySw@mail.gmail.com>
Message-ID: <B9D0F336-B0C0-453C-AD56-325DAA9883A0@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?9?12? GMT+08:00 ??10:49:12, Chen-Yu Tsai <wens@csie.org> ??:
>On Tue, Sep 4, 2018 at 4:44 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>>
>>
>> ? 2018?9?4? GMT+08:00 ??4:40:56, Chen-Yu Tsai <wens@csie.org> ??:
>> >On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec
><jernej.skrabec@siol.net>
>> >wrote:
>> >>
>> >> From: Icenowy Zheng <icenowy@aosc.io>
>> >>
>> >> As we have already binding for the H6 system controller, add its
>node
>> >> to the device tree.
>> >>
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> [fixed compatible string]
>> >> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >
>> >Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>>
>> By the way can these patches be applied first? (patches
>> related to syscon).
>>
>> They're also needed for EMAC.
>
>Applied.
>
>BTW, the H6 system control EMAC register also has the internal PHY
>related controls seen on H3/H5. IIRC you previously mentioned that
>they have no effect?

Yes, because the "internal PHY" on H6 is on AC200.

The internal/external mux bit has effect (although it will mux
to a non-existent PHY when switching to "internal", render
EMAC not usable), but it also has effect on A64 (same effect
with H6), on which it's not documented.

>
>ChenYu
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
