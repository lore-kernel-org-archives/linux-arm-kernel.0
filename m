From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 05 May 2018 13:38:31 -0700
Subject: [PATCH net-next v2 03/13] net: phy: sfp: warn the user when no
 tx_disable pin is available
In-Reply-To: <20180504171425.GA17233@lunn.ch>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-4-antoine.tenart@bootlin.com>
 <ed267042-1a61-7fcc-13ee-3cad2c05c658@gmail.com>
 <20180504171425.GA17233@lunn.ch>
Message-ID: <44545AF4-64E3-4772-B5BA-43CCF2321025@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 4, 2018 10:14:25 AM PDT, Andrew Lunn <andrew@lunn.ch> wrote:
>On Fri, May 04, 2018 at 10:07:53AM -0700, Florian Fainelli wrote:
>> On 05/04/2018 06:56 AM, Antoine Tenart wrote:
>> > In case no Tx disable pin is available the SFP modules will always
>be
>> > emitting. This could be an issue when using modules using laser as
>their
>> > light source as we would have no way to disable it when the fiber
>is
>> > removed. This patch adds a warning when registering an SFP cage
>which do
>> > not have its tx_disable pin wired or available.
>> 
>> Is this something that was done in a possibly earlier revision of a
>> given board design and which was finally fixed? Nothing wrong with
>the
>> patch, but this seems like a pretty serious board design mistake,
>that
>> needs to be addressed.
>
>Hi Florian
>
>Zii Devel B is like this. Only the "Signal Detect" pin is wired to a
>GPIO.

Good point, indeed. BTW what do you think about exposing the SFF's EEPROM and diagnostics through the standard ethtool operations even if we have to keep the description of the SFF as a fixed link in Device Tree because of the unfortunate wiring?

-- 
Florian
