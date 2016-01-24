From: rbthomas@pobox.com (Rick Thomas)
Date: Sun, 24 Jan 2016 12:56:09 -0800
Subject: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
In-Reply-To: <20160124173701.GU3880@lunn.ch>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
 <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
 <20160124173701.GU3880@lunn.ch>
Message-ID: <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 24, 2016, at 9:37 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Jan 24, 2016 at 12:36:39AM +0200, Aaro Koskinen wrote:
>> Fix audio on kirkwood-openrd-client:
>> 
>> 1) The audio-controller was left disabled.
>> 
>> 2) The probe fails because cs42l51 is missing #sound-dai-cells.
>> 
>> 	/sound/simple-audio-card,codec: could not get #sound-dai-cells for /ocp at f1000000/i2c at 11000/cs42l51 at 4a
>> 	asoc-simple-card sound: parse error -22
>> 	asoc-simple-card: probe of sound failed with error -22
>> 
>> 3) The mapping is incorrect:
>> 
>> 	asoc-simple-card sound: cs42l51-hifi <-> spdif mapping ok
>> 
>>   should be:
>> 
>> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
>> 
>> Reported-by: Rick Thomas <rbthomas@pobox.com>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> It would be good to have a Tested-by: from Rick.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> 	     Andrew


If someone will make a .deb I can download, I'll be happy to install it and test it.  Please be explicit in describing what and how you want tested.


Rick
