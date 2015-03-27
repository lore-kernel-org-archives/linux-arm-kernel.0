From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Mar 2015 10:53:18 -0700
Subject: [PATCH] spi: xilinx: Use standard num-cs binding
In-Reply-To: <2a81c738-f7e2-4387-b04c-05c9892ba8e4@BN1AFFO11FD026.protection.gbl>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
 <20150308190012.GV28806@sirena.org.uk>
 <2a81c738-f7e2-4387-b04c-05c9892ba8e4@BN1AFFO11FD026.protection.gbl>
Message-ID: <20150327175318.GG1743@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 11:55:49AM +0100, Michal Simek wrote:

Please fix your mail client to word wrap within paragraphs at less than
80 columns - this makes your mails easier to read and reply to.

> On 03/08/2015 08:00 PM, Mark Brown wrote:
> > On Fri, Jan 16, 2015 at 01:55:14PM +0100, Michal Simek wrote:
> >> Use standard num-cs binding property and setup
> >> "xlnx,num-ss-bits" as deprecated.

> > Why?  These properties mean different things - num-cs is a bit confused
> > and is the total number of available chip selects for the system (which
> > could include GPIOs) while num-ss-bits is the size of the bitfield
> > (which could include things not actually mapped out properly/successfully 
> > or something if the hardware designers were feeling particularly inspired).

> I was checking meaning of num-ss-bits and meaning is Number of slaves (taking
> explanation from Vivado 2014.4) Range 1-32.
> http://www.xilinx.com/support/documentation/ip_documentation/axi_spi/v1_02_a/axi_spi_ds742.pdf
> Table 1 - page 4

> Checking through the hw design every pin is connected to device to do chip select.
> That's why I think that num-cs (based on spi-bus.txt) is the right property.

Remember that we can at least in theory have additional chip selects
that aren't controlled by the IP block but are instead GPIOs.  There's
also some potential confusion for users between the number of chip
selects in use in a given system and the size of the bitfield that the
driver needs to take care of.

> > I'm not convinced num-cs ever made any sense.

> Does it mean that num-cs property used by 11 SPI drivers is just incorrect?

> Based on Documentation/devicetree/bindings/spi/spi-bus.txt it is the part of binding
> - num-cs : total number of chipselects

> Please let me know what you think.

I don't think it has any value.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150327/fcc8a0f3/attachment-0001.sig>
