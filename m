From: drake@endlessm.com (Daniel Drake)
Date: Thu, 18 Feb 2016 15:27:06 -0600
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <CAOQ7t2aqZj3STFsdTSQZMTK5U+8Oem8oFroxHKWkt=AeP+Zczg@mail.gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <4158343.mkrTsd5B4G@wuerfel>
 <CAOQ7t2byFoW657-1xnsBpeyPkB6K25R=_pPmRDmT32Sjef=kUw@mail.gmail.com>
 <4136837.fyWFbJqZfO@wuerfel>
 <CAOQ7t2aqZj3STFsdTSQZMTK5U+8Oem8oFroxHKWkt=AeP+Zczg@mail.gmail.com>
Message-ID: <CAD8Lp47LGUc3-MFpU+3iNjXJL0i4nLTY_49NUxFXeZ2SokDuaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 3:04 PM, Carlo Caione <carlo@caione.org> wrote:
>> However, if some or all of the other devices actually are entirely
>> made up of register ranges within cbus, that would indicate that
>> cbus itself is not just a collection of random registers but something
>> that could be considered a bus of itself in hardware, and then
>> we could represent the other devices as children of this bus.
>
> I think that this is exactly the case. We are missing this cbus in the
> DTS because (for lacking of proper documentation) we are not sure
> about start / end / size.

Here's a hint from the vendor kernel
https://github.com/endlessm/linux-meson/blob/master/arch/arm/mach-meson8b/iomapping.c#L87

Having a cbus bus node with child devices does sound like it would
reflect this particular view of the hardware design. How would we then
represent the hwrev registers under that?

I am also curious if this is the common practice. We were working with
Exynos devices before, and even though many of the components are on
the AXI bus there, there is no AXI bus representation in the DT. But
now that I go digging, I see other SoCs that do have a DT bus
representation very similar to what's being described, such as the apb
and axi busses in mmp2.dtsi. Is one approach preferred over the other
for new SoC support?

Daniel
