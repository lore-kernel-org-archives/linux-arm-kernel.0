From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 20:16:47 +0900
Subject: [PATCH] ARM: shmobile: Remove __init from
 rcar_gen2_read_mode_pins()
In-Reply-To: <1453243.5L1W6bkVz8@avalon>
References: <20140217063510.21892.52120.sendpatchset@w520>
 <1453243.5L1W6bkVz8@avalon>
Message-ID: <CANqRtoR7C_v+PQt3J1tjSxvFcX87NZqZZ16tBULBYBz=_F-rFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, Feb 17, 2014 at 7:59 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Monday 17 February 2014 15:35:10 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Remove __init from rcar_gen2_read_mode_pins() to allow
>> it to be used after boot. For instance the R-Car Gen2
>> MD21 check is needed even in the case of CPU Hotplug.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  Written against renesas-devel-v3.14-rc2-20140213
>>
>>  arch/arm/mach-shmobile/setup-rcar-gen2.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c     2014-02-17
>> 15:02:48.000000000 +0900 @@ -28,7 +28,7 @@
>>
>>  #define MODEMR 0xe6160060
>>
>> -u32 __init rcar_gen2_read_mode_pins(void)
>> +u32 rcar_gen2_read_mode_pins(void)
>>  {
>>       void __iomem *modemr = ioremap_nocache(MODEMR, 4);
>>       u32 mode;
>
> Should we read the value once at boot time and cache it ?

Seems a bit of a micro-optimization to me, but sure, it can't hurt.

Care to cook up an incremental patch implementing that? =)

Cheers,

/ magnus
