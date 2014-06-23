From: john.tobias.ph@gmail.com (John Tobias)
Date: Mon, 23 Jun 2014 14:29:37 -0700
Subject: SD50 freq clock -> wifi sd8797
Message-ID: <CACUGKYPKxh0MseMDhdk1ZP_aCeMMCAMq+V0MEfCzrQVHUjkdLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guys,

I am using kernel 3.13 for iMX6SL and my wifi is a Marvell SD8797
wifi/bluetooth module.
The sdhci-esdhc-imx controller configured it as follows:

clock:          100000000 Hz
actual clock:   99000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    5 (sd uhs SDR50)
signal voltage: 0 (1.80 V)

The above configuration works, but running (continuously) the wifi and
the bluetooth at the same time (e.g. ping google.com and hcitool scan)
caused it to get "mmc1: Timeout waiting for hardware interrupt." after
80+ loops.

I used an SDIO 3 analyzer and I got a frequency captured 99Mhz and
102Mhz. But, I found a lot of CRC16 errors when the above frequency
setting is being used.

Then, I changed the frequency value to 90000000 (see below) in device
tree. I pinging google.com and running hcitool scan  (continuously)
for
almost 4 days and did not get the mmc1 timeout.

Updated clock:

clock:          90000000 Hz
actual clock:   66000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    5 (sd uhs SDR50)
signal voltage: 0 (1.80 V)


Is there any existing issue/errata that I should aware of with regards
to the sdhci-esdhc-imx controller particularly to those device need a
100Mhz frequency clock?.


Regards,

john
