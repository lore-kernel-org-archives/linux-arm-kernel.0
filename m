From: andrew@ncrmnt.org (Andrew)
Date: Mon, 04 May 2015 01:05:56 +0300
Subject: [PATCH v3 0/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <20150503205043.GA23342@lunn.ch>
References: <1430663256-22714-1-git-send-email-andrew@ncrmnt.org>
 <20150503205043.GA23342@lunn.ch>
Message-ID: <ad0fbb28b4b74de4c6685a5ddd21010c@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn ????? 03.05.2015 23:50:
> Hi Andrew
> 
>> DNS-327L is a 2-bay NAS with the following specs:
>>      - 512MiB RAM
>>      - 128MiB NAND Flash
>>      - 1 GbE interface (Marvell PHY)
> 
> ...
> 
>> /* Set RGMII voltage to 1.8v, according to public docs. Nice! */
>> mw.l 0xd00184e0 0xa8a;
>> /* Some weird magic that goes into phy registers, no public docs */
>> phyWrite 0 16 2;
>> phyWrite 0 19 77;
>> phyWrite 0 18 5747;
> 
> Take a look at the marvell,reg-init property. Might do what you need.
> 
>      Andrew

Thanks for the tip. So far I'm solving it via u-boot.
You have to set RGMII voltage there anyway if you want tftp for the 
updates,
so it looks like the right place to do this kind of stuff.


I'll add the proper magic to the dts file and resend tomorrow.

-- 
Regards,
Andrew
