From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 16 Dec 2010 10:17:18 -0800
Subject: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
	(Govindraj Raja's message of "Thu, 16 Dec 2010 14:57:46 +0530")
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
	<87d3p3kobt.fsf@deeprootsystems.com>
	<AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
Message-ID: <874oadfuq9.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

> On Wed, Dec 15, 2010 at 9:42 PM, Kevin Hilman <khilman@deeprootsystems.com>
> wrote:
>
>     "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>     > Changes invloves:
>     > ----------------
>     > 1) Addition of hwmod data for omap2/3/4.
>     > 1) McSPI driver hwmod adaptation with cleanup of base address
>     > ? ?macros and using omap-device API's.
>     > 2) Runtime Conversion of McSPI driver
>     >
>     > Changes from v1:
>     > ---------------
>     > 1) Fixing patch 5/5 comments for hwmod+runtime
>     > ? ?Split the patch 5/5 to hwmod adaptation
>     > ? ?and then runtime conversion
>     > ? ?http://www.mail-archive.com/linux-omap at vger.kernel.org/msg33387.html
>     >
>     > Testing Updates:
>     > ----------------
>     > Was tested using data transfer test module available at:
>     > http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/
>     test_code/
>     > utils/mcspi_modules/omap_mcspi_datatest.c;
>     > h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
>     > hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>
>     Can you summarize what this test does?
>
>     On what platforms was this tested?
>
>     How was it tested for OMAP1 and OMAP2?
>
>
>
> Using the above mentioned test module we had done some
> data transfer tests.
> Platforms used used where :
> 1) OMAP2430 SDP.
> 2) OMAP3 (ZOOM boards zoom2/3).
> 3) OMAP4430 SDP [ Here even basic?Ethernet?functionality?was checked which is
> over SPI interface]

Can you describe a little more about the testing please?  What exactly
does the data transfer test do?  Is it a loopback test?  Does it use
on-board SPI peripherals?  If so, which ones, etc.

> We boot tested on 2420/n800.
>
> Coming to omap1,
>
> This driver[omap2_mcspi.c] is applicable only from omap2_plus
> for omap1?omap_uwire.c is the spi driver file.

OK, thanks for clarification.

Kevin
