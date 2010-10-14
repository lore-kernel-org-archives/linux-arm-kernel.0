From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 15 Oct 2010 10:57:47 +1300
Subject: [PATCH v3 2/3] ARM: ep93xx: add AC97 platform support
In-Reply-To: <0D753D10438DA54287A00B02708426976450C42B0E@AUSP01VMBX24.collaborationhost.net>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
	<14a8c7ea0482375fa32a022ea7e318ea4feae6f1.1287066937.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976450C42B0E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4CB77CDB.6050908@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2010 10:46 AM, H Hartley Sweeten wrote:
> On Thursday, October 14, 2010 7:49 AM, Mika Westerberg wrote:

>> +void __init ep93xx_register_ac97(void)
>> +{
>> +	/*
>> +	 * Make sure that the AC97 pins are not used by I2S.
>> +	 */
>> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
> 
> This is fine for now.
> 
> Eventually some thought should go into a proper iomux to prevent
> loading drivers with conflicting pin requirements.  Currently, depending
> on the configuration, this could break if a user should try to use the
> ac97 and i2s audio at the same time (I2SONAC97 mode).  But, the same
> problem already exists if a user tries using spi and i2s audio (I2SONSSP
> mode).

I initially suggested this also, since we have acquire/release functions
for some other drivers, but I now think this is fine as is. It's highly
unlikely that a board is going to have both I2S and AC97 audio. We can
change this later if such a board shows up, no need to make the code
more complicated for hypothetical boards :-).

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
