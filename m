From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 07 Aug 2017 14:44:00 -0700
Subject: [PATCH 00/14] mmc: meson-gx: driver fixups and upgrade
In-Reply-To: <1502124502.2759.32.camel@baylibre.com> (Jerome Brunet's message
 of "Mon, 07 Aug 2017 18:48:22 +0200")
References: <20170804174353.16486-1-jbrunet@baylibre.com>
 <1502124502.2759.32.camel@baylibre.com>
Message-ID: <7hshh3njdr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Fri, 2017-08-04 at 19:43 +0200, Jerome Brunet wrote:
>> The patchset features several bugfixes, rework and upgrade for the
>> meson-gx MMC driver.
>> 
>> The main goal is to improve readability and enable new high speed
>> modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
>> 
>> While full speed SDR104 is stable with most cards, a few seems to
>> require an even more precise tuning. For this, we'll probably have
>> to implement per-line delay calibration.
>> 
>> This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
>> gxl-s905x-libretech
>> 
>
> Ulf, Kevin,
>
> Please ignore this series. I'll resend it soon
>
> I've discovered new things around the tuning capabilities of the SoC.
> I'll probably rework the tuning function again.
>
> Sorry for the noise

No worries, I had a couple very minor comments on some individual
patches. Other than that, LGTM.

Feel free to add:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

to anything that doesn't need major rework.

Also, You might want to separate out the fixups/cleanups from the
voltage/clock changes stuff.

Kevin
