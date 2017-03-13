From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 13 Mar 2017 08:51:52 +0100
Subject: [PATCH v2] ARM: pxa: magician: Add support for ADS7846 touchscreen
In-Reply-To: <65621425-91ac-1726-88ba-4626c85e7981@tul.cz>
References: <65621425-91ac-1726-88ba-4626c85e7981@tul.cz>
Message-ID: <f309f049-a0df-fcd5-efca-b7c4125cc6cc@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 13.3.2017 v 01:25 Petr Cvek napsal(a):
> This patch adds a support for ADS7846 touchscreen driver.
> 
> The basic functionality was tested, x_plate_ohms and y_plate_ohms were
> physically measured. The value pressure_max was empirically set to match
> the measured range, which is affected by x_plate_ohms and ADS samples.
> 
> The value of keep_vref_on doesn't seem to have any effect on measurements
> (at least on T-Mobile MDA Compact PM10A device). Leave it to zero so
> the internal and external Vref sources will not collide.

Actually not, without vref on the touchscreen seems to be highly jittery.

Sending version 3 (fixed patch and a new commit message).

Petr
