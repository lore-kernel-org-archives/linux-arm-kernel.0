From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 30 Aug 2017 12:03:43 -0700
Subject: [PATCH v3 00/13] mmc: meson-gx: driver fixups and upgrades
In-Reply-To: <CAPDyKFogy=L=BDKtMhKCN0nMLi-Yy5SHgAhB_=jog+CX91breA@mail.gmail.com>
 (Ulf Hansson's message of "Wed, 30 Aug 2017 15:13:57 +0200")
References: <20170828142915.27020-1-jbrunet@baylibre.com>
 <CAPDyKFogy=L=BDKtMhKCN0nMLi-Yy5SHgAhB_=jog+CX91breA@mail.gmail.com>
Message-ID: <7hr2vsdgj4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 28 August 2017 at 16:29, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> The patchset features several bugfixes, rework and upgrade for the
>> meson-gx MMC driver.
>>
>> The main goal is to improve readability and enable new high speed
>> modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
>>
>> SDR104 is not working with a few cards on the p200 and the
>> libretech-cc. I suspect that 200Mhz might be a bit too fast for the PCB
>> of these boards, adding noise to the signal and eventually breaking
>> the communication with some cards. The same cards are working well on a
>> laptop or the nanopi-k2 at 200Mhz.
>>
>> This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
>> gxl-s905x-libretech-cc
>>
>> Changes since v2 [1]:
>> * Drop patches 1 to 3: Applied.
>> * Drop patch 4: Debug stuff which should not have been sent.
>> * Added fix to previous patch 3:
>>   If the clock register is not initialized before registering the clk
>>   with CCF, the framework will complain about an illegal divider value.
>>   This had gone unnoticed because it was later fixed by the clock init
>>   rework.
>>
>>   Ulf, I know it is getting late but it would be nice if patch #1 of
>>   this v3 could go with 3 patches you already applied. The rest can
>>   wait for the following cycle.
>
> I decided to pick them all, so applied for next!
>

Just to double-check, so I can plan for the DT patches
accordingly... you are queuing this for v4.14, right?

Kevin
