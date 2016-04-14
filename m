From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 14 Apr 2016 10:23:28 +0200
Subject: [next] Failing Odroid XU3 boot due to missing MMC device
Message-ID: <570F5380.7010103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Anyone also observed recent failures of linux-next (20160413, 20160414)
on booting from SD card? On my Odroid XU3 exynos and multi_v7 configs
fail with:

Apr 14 07:52:53 starting version 229
Apr 14 07:52:53 :: running hook [udev]
Apr 14 07:52:53 :: Triggering uevents...
Apr 14 07:52:54 Waiting 10 seconds for device /dev/mmcblk0p1 ...
Apr 14 07:53:05 ERROR: device '/dev/mmcblk0p1' not found. Skipping fsck.
Apr 14 07:53:05 ERROR: Unable to find root device '/dev/mmcblk0p1'.
Apr 14 07:53:05 You are being dropped to a recovery shell
Apr 14 07:53:05     Type 'exit' to try and continue booting
Apr 14 07:53:05 sh: can't access tty; job control turned off

I didn't start bisecting yet... maybe this is known?

Full logs:
http://www.krzk.eu/builders/boot-odroid-xu3-exynos/builds/673/steps/Boot%20odroid/logs/serial


Best regards,
Krzysztof
