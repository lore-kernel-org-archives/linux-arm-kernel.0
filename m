From: dsd@laptop.org (Daniel Drake)
Date: Fri, 28 Jun 2013 15:36:37 -0600
Subject: Armada DRM driver on OLPC XO
In-Reply-To: <20130628212723.GK4283@n2100.arm.linux.org.uk>
References: <20130625204726.BF65C12647A@dev.laptop.org>
 <20130628212723.GK4283@n2100.arm.linux.org.uk>
Message-ID: <CAMLZHHSmoxDamhW6vcdfqhWH=FKR1m5-Z95P8LSZ+SFDO=yVhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 3:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 25, 2013 at 04:47:26PM -0400, Daniel Drake wrote:
>> I have tested it on OLPC XO-1.75 (MMP2 aka Armada610) and OLPC XO-4 (MMP3
>> aka PXA2128). After a bit of fighting, I have it running. Could you share your
>> X driver, or your methodology for testing hardware cursors? I'd like to test
>> your work there too.
>
> BTW... a point on this.  As you don't have the LCD_SPU_ADV_REG register,
> you probably don't have support for ARGB cursors.  DRM only supports ARGB
> cursors.  You can't down-convert an ARGB cursor to something which looks
> reasonable in the kernel, so I'd suggest forgetting hardware cursors.
> Even converting ARGB to transparency + RGB looks rubbish and wrong.

Interesting. Yes, a previous developer battled unsuccessfully with
hardware cursors and in the end we ended up using low color depth ones
which don't look great. I was wondering if you had found something
new, but it sounds like that we really are limited by the hardware.

Thanks
Daniel
