From: sr@denx.de (Stefan Roese)
Date: Tue, 5 Apr 2016 09:11:27 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <13533301.gfdhE3AuMf@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3108005.nUMWsj4kjp@wuerfel> <20160329212842.GN2350@sirena.org.uk>
 <13533301.gfdhE3AuMf@wuerfel>
Message-ID: <5703651F.4040901@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.03.2016 00:04, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 14:28:42 Mark Brown wrote:
>> On Tue, Mar 29, 2016 at 11:08:55PM +0200, Arnd Bergmann wrote:
>>> On Tuesday 29 March 2016 14:00:18 Mark Brown wrote:

<snip>

>>> not impact the binding for the SPI host controller in any way, the
>>> binding just describes how the internal addressing is wired up to
>>> the mbus in hardware, and the mbus driver takes care of mapping those
>>> into CPU addresses.
>>
>> If we're able to do it automatically without baking this into the DT and
>> there's enough space to cope with this and PCI together then that's more
>> reasonable.
> 
> Ok, good. Then let's just do the SPI host driver like all the other
> mbus slaves using whatever mbus provides, and implement dynamic remapping
> of mbus windows whenever someone gets too annoyed with having to
> come up with a mapping for their board.
> 
> At least by doing SPI like all the other devices, we don't make it
> harder to come up with a generic algorithm for assigning the windows
> at boot time.

Okay, I'll implement the static mapping as suggested by Arnd in the
'reg' property of the SPI controller (additionally to the SPI controller
register range). Which will get configured and enabled in the 'ranges'
property of the per-board 'soc' node.

This will make the SPI driver patch very simple but will generate quite
a big Armada dts change, moving all the SPI controllers from the
'internal-regs' node to the 'soc' node though.

Please let me know if this is not the consensus.

Thanks,
Stefan
