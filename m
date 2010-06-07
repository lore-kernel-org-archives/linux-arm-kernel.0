From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 08 Jun 2010 08:38:19 +1200
Subject: [alsa-devel] [RFC PATCH v3 0/3] ep93xx i2s audio
In-Reply-To: <1275914732.3045.105.camel@odin>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275914732.3045.105.camel@odin>
Message-ID: <4C0D58BB.5030505@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Liam Girdwood wrote:
> On Fri, 2010-06-04 at 17:11 +1200, Ryan Mallon wrote:
>> The following patch series adds support for i2s audio on the ep93xx,
>> with the Snapper CL15 used as an example implementation.
>>
>> This version fixes a number of things from the previous round:
>>  - Removed unused #defines
>>  - Set symmetric rates for the cpu dai
>>  - Fixed the sdiv/lrdiv calculation loop
>>  - Moved the cpu dai registration
>>  - Removed empty ep93xx_pcm_prepare callback
>>  - Fixed enable/disable when both capture and playback are running
>>  
>> Capture still does not work. The dma is running, but the captured data
>> is all zeros (tested used arecord and loopback). I have a 2.6.20
>> kernel with ep93xx i2s audio working an capture works there on the
>> same hardware. I have spent sometime looking into this, but can't see
>> the problem. Would appreciate if someone can lend some insight as to
>> what I have done wrong.
>>
>> Ryan Mallon (3):
>>   ep93xx i2s core support
>>   ep93xx i2s audio driver
>>   Snapper cl15 audio support
> 
> All
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Russell, Mark has picked up patch 2/3 via the alsa tree. Should I submit
1/3 and 3/3 via the arm patch system with Liam's ack?

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
