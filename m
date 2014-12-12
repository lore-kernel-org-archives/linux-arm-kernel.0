From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Dec 2014 11:17:01 +0530
Subject: [PATCH v6 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <CAD=FV=XTYmzxvteNip2gtuDSSEWph-vY=BOPejHa1Z5KS2Kf6Q@mail.gmail.com>
References: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>	<1418291722-25448-2-git-send-email-lyz@rock-chips.com>	<548971AF.1020506@ti.com>
 <CAD=FV=XTYmzxvteNip2gtuDSSEWph-vY=BOPejHa1Z5KS2Kf6Q@mail.gmail.com>
Message-ID: <548A8155.8080809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 12 December 2014 12:11 AM, Doug Anderson wrote:
> Kishon,
> 
> On Thu, Dec 11, 2014 at 2:27 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> I didn't mean that. You can get rid of this entire xlate stuff if you use
>> something like below
>>
>> phy at xxx {
>>         compatible = "";
>>         phy1:usb_phy {
>>         }
>>         phy2:usb_phy {
>>         };
>> };
>>
>>
>> usb at xx {
>>         compatible = "";
>>         phys = <&phy1>; //doesn't need xlate
>>         /* this needs xlate
>>            phys = <&phy 1>;
>>         */
>>         phy-names = "phy";
>> };
> 
> Is the syntax you proposed really better?  Are you saying that you
> advocate never using "#phy-cells" other than 0 for new bindings?  Is

No. It can still be used for configuring the PHY. For example, in the case of
PIPE3 PHY we configure it to USB PHY, SATA PHY or PCIE PHY depending on to
which controller the PHY is connected to.

I feel using phy-cells just for differentiating the PHY is pointless when you
have a separate node for each PHY.

Thanks
Kishon
