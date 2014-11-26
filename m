From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 26 Nov 2014 13:49:01 +0100
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <2A7C987F-15E0-46FD-A711-E7F5BA9893FC@gmail.com>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com>
 <20141122181229.GB9698@katana>
 <2A7C987F-15E0-46FD-A711-E7F5BA9893FC@gmail.com>
Message-ID: <20141126124901.GB4397@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 03:25:29PM +0300, Alexander Kochetkov wrote:
> 
> 22 ????. 2014 ?., ? 21:12, Wolfram Sang <wsa@the-dreams.de> ???????(?):
> 
> > IMO a repeated start is to ensure that two messages arrive at the slave
> > without interruption from another master. I can't think why a slave
> > should know which type of start that was. In fact, if it does that would
> > raise an eyebrow for me. Do you have an example?
> 
> It is used to implement Device ID reading.

Yes and no, I'd say :) Technically, it needs repeated start. But really,
the hardware should handle this (and I know one IP core which has
support for it). One could try to simulate the behaviour in the bus
driver IF a second slave address AND detection of repeated start is
available, but I doubt this combination exists.

Still, all the _slave driver_ needs to handle is an
I2C_SLAVE_EVENT_DEVICE_ID which should return the apropriate value.

That being said, I have never seen querying Device ID in action.

> Not sure, that the feature is really needed for the first release.

I am sure it is not :D

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/cc018256/attachment.sig>
