From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Mar 2014 13:42:29 -0700
Subject: [PATCH RFC] ixp4xx_eth: Allow setting the MDIO bus name in
 platform data
In-Reply-To: <m3r45r72u9.fsf@intrepid.localdomain>
References: <20140324151729.1b8e3bb5@marrow.netinsight.se>
 <m3r45r72u9.fsf@intrepid.localdomain>
Message-ID: <CAGVrzcaJ5LKE_HAvsmbnFxYsLbNwi9h9UYrz60AQ3z4DOZKwYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-24 13:34 GMT-07:00 Krzysztof Halasa <khc@pm.waw.pl>:
> Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:
>
>> Allows using e.g., a fixed MDIO bus with the ixp4xx_eth driver.
>> Example:
>>
>>   static struct eth_plat_info board_plat_eth_internal[] = {
>>       {
>>               .mdio_bus_id    = "fixed-0",
>>               .phy            = 31,
>>               .rxq            = 4,
>>               .txreadyq       = 21,
>>               .hwaddr         = {0x02, 0x00, 0x00, 0x00, 0x00, 0x00},
>>       }
>>   };
>
> Why do we need it? I'm not sure I know what constitutes a "fixed MDIO
> bus".

This is a software emulation MDIO bus for when your Ethernet MAC is
connected to a PHY which does not appear on the MDIO bus. This is
typically used to provide the Ethernet driver with a link that is
always seen as UP, when you cannot directly query it via MDIO/MDC.
-- 
Florian
