From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 17 Dec 2010 18:22:47 +0530
Subject: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <874oadfuq9.fsf@deeprootsystems.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
	<87d3p3kobt.fsf@deeprootsystems.com>
	<AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
	<874oadfuq9.fsf@deeprootsystems.com>
Message-ID: <AANLkTinBafsUsNuxc25sTEBPX=fD-=StRHF8-jL+mqCc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 11:47 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Govindraj,
>
> "Raja, Govindraj" <govindraj.raja@ti.com> writes:
>
>> On Wed, Dec 15, 2010 at 9:42 PM, Kevin Hilman <khilman@deeprootsystems.com>
>> wrote:
>>
>> ? ? "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>> ? ? > Changes invloves:
>> ? ? > ----------------
>> ? ? > 1) Addition of hwmod data for omap2/3/4.
>> ? ? > 1) McSPI driver hwmod adaptation with cleanup of base address
>> ? ? > ? ?macros and using omap-device API's.
>> ? ? > 2) Runtime Conversion of McSPI driver
>> ? ? >
>> ? ? > Changes from v1:
>> ? ? > ---------------
>> ? ? > 1) Fixing patch 5/5 comments for hwmod+runtime
>> ? ? > ? ?Split the patch 5/5 to hwmod adaptation
>> ? ? > ? ?and then runtime conversion
>> ? ? > ? ?http://www.mail-archive.com/linux-omap at vger.kernel.org/msg33387.html
>> ? ? >
>> ? ? > Testing Updates:
>> ? ? > ----------------
>> ? ? > Was tested using data transfer test module available at:
>> ? ? > http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/
>> ? ? test_code/
>> ? ? > utils/mcspi_modules/omap_mcspi_datatest.c;
>> ? ? > h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
>> ? ? > hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>>
>> ? ? Can you summarize what this test does?
>>
>> ? ? On what platforms was this tested?
>>
>> ? ? How was it tested for OMAP1 and OMAP2?
>>
>>
>>
>> Using the above mentioned test module we had done some
>> data transfer tests.
>> Platforms used used where :
>> 1) OMAP2430 SDP.
>> 2) OMAP3 (ZOOM boards zoom2/3).
>> 3) OMAP4430 SDP [ Here even basic?Ethernet?functionality?was checked which is
>> over SPI interface]
>
> Can you describe a little more about the testing please? ?What exactly
> does the data transfer test do? ?Is it a loopback test? ?Does it use
> on-board SPI peripherals? ?If so, which ones, etc.
>

Yes its an loopback test based on SPI interface available from
development board expansion connector.

MISO <---> MOSI [Loopback test]

So basically looking into the Board schematics we decide
which SPI interface is available on the board expansion connector
and use SPI interface available.

On zoom boards SPI3 was available on expansion connector
and same was used. On 4430SDP SPI2 interface was used.
On 2430SDP SPI2.

Also for testing, spi_board_info was populated in board file
and spi_register_board_info was done, here bus info was populated
based on spi bus available on the board. In spi_board_info structure
we initialize spi_bus and name as spitst and speed and chip-select
later once test module is loaded word-length, speed etc is modified
from proc interface available from the test module and data test
is done.

--
Thanks,
Govindraj.R


>> We boot tested on 2420/n800.
>>
>> Coming to omap1,
>>
>> This driver[omap2_mcspi.c] is applicable only from omap2_plus
>> for omap1?omap_uwire.c is the spi driver file.
>
> OK, thanks for clarification.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
