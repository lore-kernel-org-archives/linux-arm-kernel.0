From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Thu, 24 Sep 2009 12:51:54 +0200
Subject: SPI, DMA and an i.MX31
In-Reply-To: <59b21cf20909221245i355ccea0r44737e9112fd17c0@mail.gmail.com>
References: <4AB8F9AE.1070006@billgatliff.com>
	<59b21cf20909221245i355ccea0r44737e9112fd17c0@mail.gmail.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E06@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all.

Yesterday I was trying to reorganize the newly added sdma stuff. Up till
then it was just a dirty hack, now it got better structure. As I don't
know much on the organization of the kernel I cannot say if I did it the
right way. As a template I tried to match the structure of the dma driver
for the mx1/mx2 SoCs.

@Andy
The drivers/mmc/host/mxcmmc.c from 2.6.31 uses some different dma api: all
those fkt start with 'imx_', the sdma's from the ltib have a 'mxc' prefix.
I tried to match them and wrap those 'mxc' in defines, mapping them to the
'imx' ones. Unfortunately for some fkts I didn't find a matching 'mxc' one.
The driver compiles, but I guess it's pretty useless the way it is. May be
I should have looked to the driver version in ltib, instead.

After that I tried to register a SDMA channel with a device. As far as I
can see that works. The Registered channel shows under
'/proc/sdma/channels'. Freeing that also works.

Next: Will try to start a SDMA transfer with SPI.

ToDo: One with found knowledge about that should check if the new stuff
is placed correctly. Then there seams to be effort to define a global
DMA interface, for more than buffer allocation (at least for the i.MX
series). So the SDMA stuff should be made complaint with that (I guess
those 'imx' fkts are ones to go). Further there are structures that are
passed to some of the SDMA functions to set up a transfer for a device.
Those structures are incomplete. For my test I added one for CSPI3 TX in
8Bit mode. For all other cspi in all other modes, they are missing. There
should be some for 8/16/32 bit for cspi 1/2/3 in rx/tx direction.

@Bill and Magnus
Would it be ok if there was an assembler for the sdma, and the 'firmware'
could be in assembler? (I don't know how this would work, just curious :-)

Thanks again! Unfortunately by next Monday I'm out of time. Hopefully I
will be able to post the stuff I've done so far, on this list. Together
with an evaluation if the current port 'works' or not.


Cheers
Rene 



Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
