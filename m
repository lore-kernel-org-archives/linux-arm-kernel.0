From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Fri, 11 May 2018 18:09:33 +0200
Subject: [PATCH v2 3/4] Documentation: bindings: add phy_config for
 Rockchip USB Type-C PHY
In-Reply-To: <20180511144305.GP33053@art_vandelay>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
 <1525861364-26323-3-git-send-email-hl@rock-chips.com>
 <20180511144305.GP33053@art_vandelay>
Message-ID: <CAFqH_51esHUZP4htLYYqHTCotb6P=fA4ozpENU7bXTaCBg8Cbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

2018-05-11 16:43 GMT+02:00 Sean Paul <seanpaul@chromium.org>:
> On Wed, May 09, 2018 at 06:22:43PM +0800, Lin Huang wrote:
>> If want to do training outside DP Firmware, need phy voltage swing
>> and pre_emphasis value.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>
> Adding Rob Herring so he has a hope of seeing this.
>

And adding the devicetree ML, otherwise Rob will probably ignore the patch.

>> ---
>> Changes in v2:
>> - rebase
>>
>>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> index 960da7f..eda26dd 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> @@ -17,7 +17,9 @@ Required properties:
>>
>>  Optional properties:
>>   - extcon : extcon specifier for the Power Delivery
>> -
>> + - rockchip,phy_config : That's phy voltage swing and pre_emphasis
>> +                      setting, if want to do dp training outside
>> +                      dp firmware, need to add these value.
>
> What are the units?
>

Also, I think that will be good add an example or include the property
in the current examples to see how works. It's not clear from the
property description. I suppose it is an array of pairs <swing
pre-emphasis>?

nit:

-rockchip,phy_config: A list of voltage swing (unit) and pre-emphasis
(unit) pairs. Use this property to enable software link training
instead of hardware link training.

Best regards,
 Enric

> Sean
>
>>  Required nodes : a sub-node is required for each port the phy provides.
>>                The sub-node name is used to identify dp or usb3 port,
>>                and shall be the following entries:
>> --
>> 2.7.4
>>
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
