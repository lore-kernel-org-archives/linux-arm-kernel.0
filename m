From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 13 Jul 2010 23:12:55 +0300
Subject: [PATCH v3 0/5] s3c24xx: iPAQ rx1950 series 
Message-ID: <1279051980-6316-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds more support for iPAQ rx1950 PDA to linux:
1. LEDs driver -- it controls blue, green and red LEDs on rx1950
2. Battery driver -- adds ability to monitor and charge battery.
This driver is suitable for H1940 PDA aswell (just need to write
some machine specific callbacks and get voltage LUTs)

v2: removed ac registration from s3c_adc_battery driver, use
pda_power instead for ac support

v3: split LEDs patch to driver and machine parts,
split battery patch into battery + LED trigger parts,
now battery driver can skip gpio/callbacks usage
(if there's no gpio pin to determine that battery is
full or if charger is enabled automatically)
