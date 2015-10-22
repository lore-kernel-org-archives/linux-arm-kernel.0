From: caesar.upstream@gmail.com (Caesar Wang)
Date: Thu, 22 Oct 2015 10:07:00 +0800
Subject: [PATCH 1/3] dt-bindings: Add document of Rockchip mailbox
In-Reply-To: <CABb+yY2Z9soGR0OcCRcfr2Ei7zX29qHPhYEKf3LPe+OhAuZMjA@mail.gmail.com>
References: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
 <1442228798-15191-2-git-send-email-wxt@rock-chips.com>
 <CABb+yY2Z9soGR0OcCRcfr2Ei7zX29qHPhYEKf3LPe+OhAuZMjA@mail.gmail.com>
Message-ID: <562844C4.5040304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jassi,

Sorry for delay reply.
? 2015?10?06? 18:34, Jassi Brar ??:
> On Mon, Sep 14, 2015 at 4:36 PM, Caesar Wang <wxt@rock-chips.com> wrote:
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
>> +       region.
> Please make shared-sram a property of user drivers.

As Rob points out,
maybe, don't we need also define it in user drivers.
As the SRAM binding (misc/sram.txt) had defined.

I just make the SCPI protocol client driver to work for mailbox.
>
> Location and size of shared-memory is a platform property, mailbox
> controller doesn't need sram to function.
>    For example, protocol on some platform, with this controller, may be
> trivial enough to not need a shared sram... say only 32-bits wide
> requests and responses which can be passed via mailbox registers
> directly.   mbox_client.tx_prepare() is where the user driver sets up
> the shared-memory.
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
