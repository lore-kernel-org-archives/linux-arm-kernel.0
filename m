From: sr@denx.de (Stefan Roese)
Date: Wed, 23 Mar 2016 12:59:40 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160323113316.GH2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com> <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
Message-ID: <56F2852C.5010006@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 23.03.2016 12:33, Mark Brown wrote:
> On Tue, Mar 22, 2016 at 05:44:52PM +0100, Stefan Roese wrote:
>> On 22.03.2016 17:35, Thomas Petazzoni wrote:
> 
>>> Has there been any discussion on whether dynamically adding the MBus
>>> window is a good idea, as opposed to statically defining it in the
>>> board .dts ?
> 
>> Yes. My 1st patch version (still RFC) used fixed MBus windows instead:
> 
>> http://www.spinics.net/lists/linux-spi/msg06536.html
> 
>> Mark suggested to use dynamic windows, so that one area could be
>> used for all SPI devices by switching (re-configuring) the MBus
>> window:
> 
>> http://www.spinics.net/lists/linux-spi/msg06537.html
> 
> No, there's two separate things here.  The big problem with what you
> originally sent was that you were defining a window per SPI device but
> this is a part of the SPI controller so having to change windows per
> device is just going to make the code more complex.

I'm sorry, but this sentence is not totally clear to me: Do you mean
that the "more complex" code in v2 with the MBus window reconfiguration
is not good? Or do you mean that in the RFC version, the switching
between the SPI devices was too complex?

To sum it up, in the RFC version, I had one MBus window per SPI
device (using this direct access mode). Resulting in multiple MBus
windows and more resource "wastage" than necessary. In v2, I now
have one MBus window per SPI controller. Which needs to get
re-configured upon CS change.

>  There's also the
> separate issue of where any MBus windows we get come up with.

Could you also please explain this in more detail? What do you mean
with that? Do you mean the physical address, that is defined in the
DT for this MBus window?

Thanks,
Stefan
