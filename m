From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 19 May 2010 09:06:20 +1200
Subject: [RFC PATCH 0/3] ep93xx i2s audio
In-Reply-To: <20100518182202.GB22554@sirena.org.uk>
References: <4BF21B67.8090404@bluewatersys.com>
	<20100518182202.GB22554@sirena.org.uk>
Message-ID: <4BF3014C.9010001@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Tue, May 18, 2010 at 04:45:27PM +1200, Ryan Mallon wrote:
> 
>> The following patch series adds support for i2s audio on the ep93xx,
>> with the Snapper CL15 used as an example implementation. The driver is
>> basically working, but still incomplete and needs some tidy up before it
>> will be accepted for mainline. I am posting the patches to get feedback
>> from others as to how well it works on their boards and ideas to improve
>> the code.
> 
> Please do always CC the maintainers for relevant subsystems and also the
> relevant mailing lists when posting patches, even if just as RFC.  In
> this case you've done neither.

Sorry about this, I was mostly getting this out to a bunch of people who
had expressed interested in it. I should have CC'ed the alsa people
though. Thanks for your comments.

>> The following issues still exist:
>>  - The setting of SDIV/LRDIV is ugly since it requires modifying one of
>> the clock registers from the audio driver.
> 
> Clock API perhaps?

Yes, Hartley has suggested the same thing.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
