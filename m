From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 07 Oct 2017 20:31:59 +0800
Subject: [PATCH v3 1/2] dt-bindings: add device tree binding for Allwinner
 XR819 SDIO Wi-Fi
In-Reply-To: <878tgq5beu.fsf@codeaurora.org>
References: <20171003165944.13056-1-icenowy@aosc.io>
 <20171003165944.13056-2-icenowy@aosc.io>
 <871smjxp46.fsf@kamboji.qca.qualcomm.com>
 <E46F3A20-294A-497E-AF71-C77A67AFDB8C@aosc.io>
 <59D4B1C8.8020105@broadcom.com> <20171004101145.kgjufpcktodppuy3@flea>
 <C4895259-FCDE-4B21-BB15-8F150FC53BE3@aosc.io>
 <878tgq5beu.fsf@codeaurora.org>
Message-ID: <19ECFB2A-CA47-401A-AAB2-42967C381EA7@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?10?5? GMT+08:00 ??2:58:01, Kalle Valo <kvalo@codeaurora.org> ??:
>Icenowy Zheng <icenowy@aosc.io> writes:
>
>> ? 2017?10?4? GMT+08:00 ??6:11:45, Maxime Ripard
>> <maxime.ripard@free-electrons.com> ??:
>>>On Wed, Oct 04, 2017 at 10:02:48AM +0000, Arend van Spriel wrote:
>>>> On 10/4/2017 11:03 AM, Icenowy Zheng wrote:
>>>> > 
>>>> > 
>>>> > ? 2017?10?4? GMT+08:00 ??5:02:17, Kalle Valo
><kvalo@codeaurora.org>
>>>??:
>>>> > > Icenowy Zheng <icenowy@aosc.io> writes:
>>>> > > 
>>>> > > > Allwinner XR819 is a SDIO Wi-Fi chip, which has the
>>>functionality to
>>>> > > use
>>>> > > > an out-of-band interrupt pin instead of SDIO in-band
>interrupt.
>>>> > > > 
>>>> > > > Add the device tree binding of this chip, in order to make it
>>>> > > possible
>>>> > > > to add this interrupt pin to device trees.
>>>> > > > 
>>>> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> > > > Acked-by: Rob Herring <robh@kernel.org>
>>>> > > > ---
>>>> > > > Changes in v3:
>>>> > > > - Renames the node name.
>>>> > > > - Adds ACK from Rob.
>>>> > > > Changes in v2:
>>>> > > > - Removed status property in example.
>>>> > > > - Added required property reg.
>>>> > > > 
>>>> > > >   .../bindings/net/wireless/allwinner,xr819.txt      | 38
>>>> > > ++++++++++++++++++++++
>>>> > > >   1 file changed, 38 insertions(+)
>>>> > > >   create mode 100644
>>>> > >
>>>Documentation/devicetree/bindings/net/wireless/allwinner,xr819.txt
>>>> > > 
>>>> > > Like I asked already last time, AFAICS there is no upstream
>xr819
>>>> > > wireless driver in drivers/net/wireless directory. Do we still
>>>accept
>>>> > > bindings like this for out-of-tree drivers?
>>>> > 
>>>> > See esp8089.
>>>> > 
>>>> > There's also no in-tree driver for it.
>>>> 
>>>> The question is whether we should. The above might be a precedent,
>>>but it
>>>> may not necessarily be the way to go. The commit message for
>esp8089
>>>seems
>>>> to hint that there is intent to have an in-tree driver:
>>>> 
>>>> """
>>>>     Note that at this point there only is an out of tree driver for
>>>this
>>>>     hardware, there is no clear timeline / path for merging this.
>>>Still
>>>>     I believe it would be good to specify the binding for this in
>>>tree
>>>>     now, so that any future migration to an in tree driver will not
>>>cause
>>>>     compatiblity issues.
>>>> 
>>>>     Cc: Icenowy Zheng <icenowy@aosc.xyz>
>>>>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>     Signed-off-by: Rob Herring <robh@kernel.org>
>>>> """
>>>> 
>>>> Regardless the bindings are in principle independent of the kernel
>>>and just
>>>> describing hardware. I think there have been discussions to move
>the
>>>> bindings to their own repository, but apparently it was decided
>>>otherwise.
>>>
>>>Yeah, I guess especially how it could be merged with the cw1200
>driver
>>>would be very relevant to that commit log.
>>
>> The cw1200 driver seems to still have some legacy platform
>> data. Maybe they should also be convert to DT.
>> (Or maybe compatible = "allwinner,xr819" is enough, as
>> xr819 is a specified variant of cw1200 family)
>
>Ah, so the upstream cw1200 driver supports xr819? Has anyone tested
>that? Or does cw1200 more changes than just adding the DT support?

I think the cw1200 driver currently lacks maintain, and
the product is already discontinued by ST-E.

>
>-- 
>Kalle Valo
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
