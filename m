From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 14 Oct 2010 17:07:03 -0500
Subject: [PATCH v3 2/3] ARM: ep93xx: add AC97 platform support
In-Reply-To: <4CB77CDB.6050908@bluewatersys.com>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
	<14a8c7ea0482375fa32a022ea7e318ea4feae6f1.1287066937.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976450C42B0E@AUSP01VMBX24.collaborationhost.net>
	<4CB77CDB.6050908@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B02708426976450C42B60@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 14, 2010 2:58 PM, Ryan Mallon wrote:
> On 10/15/2010 10:46 AM, H Hartley Sweeten wrote:
>> On Thursday, October 14, 2010 7:49 AM, Mika Westerberg wrote:
>>>
>>> +void __init ep93xx_register_ac97(void)
>>> +{
>>> +	/*
>>> +	 * Make sure that the AC97 pins are not used by I2S.
>>> +	 */
>>> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
>> 
>> This is fine for now.
>> 
>> Eventually some thought should go into a proper iomux to prevent
>> loading drivers with conflicting pin requirements.  Currently, depending
>> on the configuration, this could break if a user should try to use the
>> ac97 and i2s audio at the same time (I2SONAC97 mode).  But, the same
>> problem already exists if a user tries using spi and i2s audio (I2SONSSP
>> mode).
>
> I initially suggested this also, since we have acquire/release functions
> for some other drivers, but I now think this is fine as is. It's highly
> unlikely that a board is going to have both I2S and AC97 audio. We can
> change this later if such a board shows up, no need to make the code
> more complicated for hypothetical boards :-).

Agree.  That's why I said eventually.... ;-)

The only platforms I know of that have both audio systems are the EDB9307,
EDB9312, and EDB9315 boards from Cirrus.  I don't have any of these so,
unless someone steps up with one to test, Mika's implementation is fine.

Regards,
Hartley
