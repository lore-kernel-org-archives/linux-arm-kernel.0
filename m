From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 11 Nov 2013 21:40:34 -0600
Subject: [PATCH 0/4] Socfpga: clk: trivial fixes and cleanup
In-Reply-To: <1384215177.17054.2.camel@linux-builds1>
References: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
 <1384215177.17054.2.camel@linux-builds1>
Message-ID: <5281A332.6060300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/11/13 6:12 PM, Dinh Nguyen wrote:
> Hi Steffen,
>
> On Thu, 2013-11-07 at 16:07 +0100, Steffen Trumtrar wrote:
>> Hi!
>>
>> This series includes two trivial fixes to the code (1,2),
>> then goes on to split the single clk.c file up into clock-type
>> specific files (3) and finally adds a divider to the peripheral
>> clock path.
>>
>> The patches are rebased to the for-next branch of
>>
>>         git://git.rocketboards.org/linux-socfpga-next.git
>>
>> Regards,
>> Steffen
>>
>> Steffen Trumtrar (4):
>>   ARM: socfpga: clk: remove unused field
>>   ARM: socfpga: clk: fix define typo
> The first two patches are fine.
>
>>   ARM: socfpga: clk: split clk code
>>   ARM: socfpga: clk: add clk_divider to periph
> These two patches are causing the ethernet driver to not be able to grab
> the correct clock during probe.
>
> Lets wait for 3.13-rc1 and I will push a new for-next that will be more
> up-to-date.

Also the values do not look correct with your patch:

per_nand_mmc_clk         1           1            52631578
          nand_clk              0           0            13157894
          nand_x_clk            0           0            52631578
          sdmmc_clk             1           1            52631578

Without your patch:

 per_nand_mmc_clk         1           1            50000000
          nand_clk              0           0            12500000
          nand_x_clk            0           0            50000000
          sdmmc_clk             1           1            50000000

Dinh
>
> Thanks,
>
> Dinh
>>  drivers/clk/socfpga/Makefile     |   3 +
>>  drivers/clk/socfpga/clk-gate.c   | 197 ++++++++++++++++++++++++
>>  drivers/clk/socfpga/clk-periph.c |  87 +++++++++++
>>  drivers/clk/socfpga/clk-pll.c    | 114 ++++++++++++++
>>  drivers/clk/socfpga/clk.c        | 313 +--------------------------------------
>>  drivers/clk/socfpga/clk.h        |  56 +++++++
>>  6 files changed, 458 insertions(+), 312 deletions(-)
>>  create mode 100644 drivers/clk/socfpga/clk-gate.c
>>  create mode 100644 drivers/clk/socfpga/clk-periph.c
>>  create mode 100644 drivers/clk/socfpga/clk-pll.c
>>  create mode 100644 drivers/clk/socfpga/clk.h
>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
