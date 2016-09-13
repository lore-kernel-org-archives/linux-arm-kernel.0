From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 13 Sep 2016 07:19:53 -0700
Subject: [PATCH v2 0/4] ARM: amlogic: Add spifc support to Amlogic's GXBB
 family
In-Reply-To: <1473753807.2662.12.camel@baylibre.com> (jbrunet@baylibre.com's
 message of "Tue, 13 Sep 2016 10:03:27 +0200")
References: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com>
 <7heg4oq2es.fsf@baylibre.com> <1473753807.2662.12.camel@baylibre.com>
Message-ID: <7h4m5jq3ue.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jbrunet <jbrunet@baylibre.com> writes:

> On Mon, 2016-09-12 at 13:38 -0700, Kevin Hilman wrote:
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>> 
>> > 
>> > This patch series adds the necessary pins, clocks and device tree
>> > nodes to
>> > enable the spifc controller on the GXBB family. I had to add the
>> > nand pins
>> > in pintctrl as the pinmux setting left by u-boot was conflicting
>> > with the
>> > spifc pinmux during my test on the P200.
>> 
>> This series seems to be missing a patch which enables the SPIfc on
>> the
>> P200 board for use with the on-board NOR flash.
>> 
>
> Indeed, I did not provide this patch, on purpose.
> The SPI-NOR at 4U2 on the P200 schematics was not present on the board
> I have. I assumed this was the case for all other P200 as well.
>
> In addition, to enable the SPI-NOR, you would also need to solder
> something at 4R3 (SPI_CS signal disconnected by default)

OK, that makes seense.  I thought the NOR was on the board by default.

> Finally, all the SPIfc lines are shared with the NAND controller which,
> like the SPI-NOR, appears on the schematics (4CCN1) but is not soldered
> on the actual hardware.
>
> Of course, I can share such patch for testing purposes if you would
> like me to.

Yeah, having a testing patch in the list archives would be useful.

Thanks,

Kevin
