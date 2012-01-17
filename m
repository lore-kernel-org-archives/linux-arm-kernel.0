From: rob.lee@linaro.org (Rob Lee)
Date: Mon, 16 Jan 2012 22:51:37 -0600
Subject: [RFC PATCH v2] ARM: imx: Add basic imx6q thermal management
In-Reply-To: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
References: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
Message-ID: <CAMXH7KEhv9LgvvJ-FnLfaFZNgvJu2gOhFDwpYHDzN9iCDXHjJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

link to v1 submission:

http://www.spinics.net/lists/arm-kernel/msg155111.html

Based on v3.2 plus recently submitted cpu_cooling functionality here:

http://www.spinics.net/lists/linux-pm/msg26500.html

Changes since v1:
1. Cleaned up some style issue pointed out in v1
2. Made various other code cleanup and re-organizing
3. Added temperature sensor calibration
4. Created platform driver and device to hook into pm suspend.

Performed some basic testing to ensure proper cooling operating.  If
you want to test this, full testing requires imx6q cpufreq
implementation (not yet in v3.2) and requires an imx6q part that has
temperature sensor calibration fuse correctly burned.
