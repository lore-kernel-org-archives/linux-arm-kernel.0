From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 23 Jul 2014 14:49:15 -0700
Subject: iMX6Q - PCIe
Message-ID: <CACUGKYP9w+qUUtp2LRKgD-Dz+2pubFeX82dGQ6tiv2Ji6VgVig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am trying to use the PCIe on iMX6Q and I am using kernel 3.15.2 and
AEH-AR9462-LC WFI-BT module.

The said module were able to detect by the kernel, able to bring up
the wifi and bluetooth interface and able to scan bluetooth devices as
as scan wifi.

When, I run /usr/sbin/wpa_supplicant -Dnl80211 -iwlp1s0
-c/tmp/wpa_supplicant.conf, I got the following logs (please see
below). The wpa supplicant keeps trying to connect but for unknown
reason, it keeps disconnecting.


Any idea?.

Regards,

john

[  572.744649] IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
wlp1s0: CTRL-EVENT-SCAN-STARTED
wlp1s0: SME: Trying to authentica[  576.314045] wlp1s0: authenticate
with d8:c7:c8:3b:e0:72
te with d8:c7:c8:3b:e0:72 (SSID='MySSID' freq=5580 MHz)
[  576.334915] wlp1s0: direct probe to d8:c7:c8:3b:e0:72 (try 1/3)
[  576.541579] wlp1s0: direct probe to d8:c7:c8:3b:e0:72 (try 2/3)
[  576.748576] wlp1s0: direct probe to d8:c7:c8:3b:e0:72 (try 3/3)
[  576.955575] wlp1s0: authentication with d8:c7:c8:3b:e0:72 timed out
wlp1s0: CTRL-EVENT-SCAN-STARTED
wlp1s0: SME: Trying to authentica[  577.469346] wlp1s0: authenticate
with d8:c7:c8:3b:e0:62
te with d8:c7:c8:3b:e0:62 (SSID='MySSID' freq=2462 MHz)
[  577.489959] wlp1s0: direct probe to d8:c7:c8:3b:e0:62 (try 1/3)
[  577.696656] wlp1s0: direct probe to d8:c7:c8:3b:e0:62 (try 2/3)
[  577.903586] wlp1s0: direct probe to d8:c7:c8:3b:e0:62 (try 3/3)
[  578.110586] wlp1s0: authentication with d8:c7:c8:3b:e0:62 timed out
wlp1s0: CTRL-EVENT-SCAN-STARTED
wlp1s0: SME: Trying to authentica[  578.565037] wlp1s0: authenticate
with 6c:f3:7f:1a:22:2a
te with 6c:f3:7f:1a:22:2a (SSID='MySSID' freq=5240 MHz)
[  578.586309] wlp1s0: direct probe to 6c:f3:7f:1a:22:2a (try 1/3)
[  578.792580] wlp1s0: direct probe to 6c:f3:7f:1a:22:2a (try 2/3)
[  578.999627] wlp1s0: direct probe to 6c:f3:7f:1a:22:2a (try 3/3)
[  579.206576] wlp1s0: authentication with 6c:f3:7f:1a:22:2a timed out
wlp1s0: CTRL-EVENT-SCAN-STARTED
wlp1s0: SME: Trying to authentica[  579.594670] wlp1s0: authenticate
with 24:de:c6:18:36:52
te with 24:de:c6:18:36:52 (SSID='MySSID' freq=5660 MHz)
[  579.615907] wlp1s0: direct probe to 24:de:c6:18:36:52 (try 1/3)
[  579.822587] wlp1s0: direct probe to 24:de:c6:18:36:52 (try 2/3)
[  580.029587] wlp1s0: direct probe to 24:de:c6:18:36:52 (try 3/3)
[  580.236582] wlp1s0: authentication with 24:de:c6:18:36:52 timed out
wlp1s0: CTRL-EVENT-SCAN-STARTED
wlp1s0: SME: Trying to authentica[  580.510611] wlp1s0: authenticate
with 6c:f3:7f:1a:2a:6a
te with 6c:f3:7f:1a:2a:6a (SSID='MySSID' freq=5200 MHz)
[  580.532053] wlp1s0: direct probe to 6c:f3:7f:1a:2a:6a (try 1/3)
[  580.539067] wlp1s0: aborting authentication with 6c:f3:7f:1a:2a:6a
by local choice (Reason: 3=DEAUTH_LEAVING)
wlp1s0: CTRL-EVENT-DISCONNECTED bssid=6c:f3:7f:1a:2a:6a reason=3
locally_generated=1
