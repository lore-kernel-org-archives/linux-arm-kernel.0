From: benoitm@perenite.com (Benoit Masson)
Date: Thu, 24 Jul 2014 00:56:56 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <20140723224236.GC28485@lunn.ch>
References: <1406154923-13612-1-git-send-email-yahoo@perenite.com>
 <1406154923-13612-2-git-send-email-yahoo@perenite.com>
 <20140723224236.GC28485@lunn.ch>
Message-ID: <94F87063-D717-435B-B7C5-EDAC9B26742C@perenite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No worries, sorry it makes more email for you guys, I've added the colors for power and revert order hdd:blue instead of blue:hdd for the hdd led.

For the marvell,mv78230-a0-i2c unfortunately i've spend 3 hours trying to understand this but it only works with this on the ix4-300d :(. There was multiple patch around this and maybe one broke the auto-detect part of this, I've tried compiling with some 3.10 or lower kernel but no luck here I still have to put this a0 option.

Benoit
Le 24 juil. 2014 ? 00:42, Andrew Lunn <andrew@lunn.ch> a ?crit :

>> +			i2c at 11000 {
>> +				compatible = "marvell,mv78230-a0-i2c",
>> +					"marvell,mv64xxx-i2c";
> 
> Ah sorry, i missed this first time. Do you really need
> "marvell,mv78230-a0-i2c"?
> 
> Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt says:
> 
>                     - "marvell,mv78230-a0-i2c"
>                       * Note: Only use "marvell,mv78230-a0-i2c" for a
>                         very rare, initial version of the SoC which
>                         had broken offload support.  Linux
>                         auto-detects this and sets it appropriately.
> 
> So i don't think you should have this hear.
> 
> Gregory, please could you comment.
> 
>> +		power-led {
>> +			label = "ix4-300d:power";
> 
> It is normal to include the colour, and you did for all the other
> LEDs.
> 
> 	Andrew
