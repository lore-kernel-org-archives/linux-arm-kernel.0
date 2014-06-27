From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Jun 2014 15:31:57 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140627130430.GH32514@n2100.arm.linux.org.uk>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk>
Message-ID: <53AD724D.4020704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 03:04 PM, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 09:01:29AM -0400, Jason Cooper wrote:
>> Sebastian Hesselbarth (2):
>>        dt-binding: add vendor prefix for SolidRun
>>        ARM: dts: mvebu: split SolidRun CuBox into variants
>
> Are we sure about this?  I mean, in order to find out whether mine is an
> engineering sample or not, I had to ask Rabeeh, and Rabeeh had to ask
> various questions about the exterior construction in order to identify
> which mine was.

Russell,

can you be more specific what bothers you about the patch?

The default dove-cubox.dts will now represent 1G production CuBox, while
there will be a dove-cubox-es.dts that you can choose if you know you
have an ES.

Actually, it isn't too hard to find out what version you have:
sdhci card detect is mis-routed on ES, if you plug-in an sdcard after
booting Linux and it doesn't get detected on dove-cubox.dts, then you
have an ES.

Also, production variants have their MAC address stored at 0xd0000 on
SPI flash. And while ES has PL2303 USB-to-UART, production use a
different brand, IIRC FTDI.

That's all about the differences - nothing serious at all.

Sebastian
