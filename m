From: caesar.upstream@gmail.com (Caesar Wang)
Date: Thu, 22 Oct 2015 09:56:38 +0800
Subject: [PATCH 1/3] dt-bindings: Add document of Rockchip mailbox
In-Reply-To: <CAL_Jsq+36CqbUnccU_LKgmeswoPgr0vBzh4PLM4nOtsCAYE0SA@mail.gmail.com>
References: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
 <1442228798-15191-2-git-send-email-wxt@rock-chips.com>
 <CAL_Jsq+36CqbUnccU_LKgmeswoPgr0vBzh4PLM4nOtsCAYE0SA@mail.gmail.com>
Message-ID: <56284256.1020205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I'm missing this patch for long time.

? 2015?10?06? 22:50, Rob Herring ??:
> On Mon, Sep 14, 2015 at 6:06 AM, Caesar Wang <wxt@rock-chips.com> wrote:
>> This add the necessary binding documentation for mailbox
>> found on RK3368 SoC.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   .../bindings/mailbox/rockchip-mailbox.txt          | 33 ++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt b/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
>> new file mode 100644
>> index 0000000..b9b4768
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
>> @@ -0,0 +1,33 @@
>> +Rockchip mailbox
>> +
>> +The Rockchip mailbox is used by the Rockchip CPU cores to communicate
>> +requests to MCU processor.
>> +
>> +Refer to ./mailbox.txt for generic information about mailbox device-tree
>> +bindings.
>> +
>> +Required properties:
>> +
>> + - compatible: should be one of the following.
>> +   - "rockchip,rk3368-mbox" for rk3368
>> + - reg: physical base address of the controller and length of memory mapped
>> +       region.
>> +       physical base address of the share buffer and length of memory mapped
> s/share/shared/

Done.

>
>> +       region.
>> + - interrupts: The interrupt number to the cpu. The interrupt specifier format
>> +       depends on the interrupt controller.
> Need to specify the value of #mbox-cells.

Done.
>> +
>> +Example:
>> +--------
>> +
>> +/* RK3368 */
>> +mbox: mbox at ff6b0000 {
>> +       compatible = "rockchip,rk3368-mailbox";
>> +       reg = <0x0 0xff6b0000 0x0 0x1000>,
>> +             <0x0 0xff8cf000 0x0 0x1000>; /* the end 4k of sram */
> If this is just onchip SRAM usable for anything, then use the SRAM
> binding (misc/sram.txt). It has provisions for defining the use.

Okay,  we don't need define the shared-sram in this document.

>> +       interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
>> +       #mbox-cells = <1>;
>> +};
>> --
>> 1.9.1
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
