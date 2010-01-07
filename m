From: elpa.rizzo@gmail.com (Davide Rizzo)
Date: Thu, 7 Jan 2010 12:36:33 +0100
Subject: 2.6.32: I2C Problem on S3C2410
Message-ID: <8447d6731001070336w1bdd8e21u982f05f303a2b304@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I experienced a strange problem with I2Cbus on Samsung S3C2410, on 2.6.32
I'm using I2C to communicate with a WM8731 codec. On the same bus chain I
have a DS1338 RTC.
I typically send 3-bytes messages (write only) to the codec, to write
internal registers.
Quite often (let's say about every 20 messages) the transmission locks at
3rd (sometimes at 2nd) byte:
only 8 bits are transmitted, but no 9th clock (for ack bit) is generated.
SDA remains low and SCL remains high, so I think the problem is not on the
codec, but on the S3C2410.
Probably the codec is driving SDA low to transmit ACK, because it's waiting
for 9th SCL pulse.
After locking, the regs are:
IICCON=0xE1, IICSTAT=0x30, IICADD=0x10, IICDS=0x00.
Had anyone a similar problem ? Any hints ?
Thank you
Davide

-- 
All difficult problems have a simple solution. That is wrong. [A. Einstein]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/0d4a19d6/attachment-0001.htm>
