From: yamagata@plathome.co.jp (yamagata at plathome.co.jp)
Date: Mon, 27 May 2013 18:10:18 +0900 (JST)
Subject: [PATCH 00/21] ARM: kirkwood: improve pinmux configs in Device Tree
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130527.181018.461275386.yamagata@plathome.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Petazzoni

> The last patch finally adds support for the init button of the
> Plathome OpenBlocks A6 platform.

I have checked the init button worked well with your three patches for
linux-3.10-rc3 and 3.9.4.

Tested-by: Atsushi Yamagata <yamagata@plathome.co.jp>

BEGIN--------
root at obsa6:~# evtest /dev/input/event0
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
Input device name: "gpio_keys.2" 
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 116 (KEY_POWER)
Properties:
Testing ... (interrupt to exit)
Event: time 1369641859.652847, type 1 (EV_KEY), code 116 (KEY_POWER), value 1
Event: time 1369641859.652847, -------------- SYN_REPORT ------------
Event: time 1369641859.992842, type 1 (EV_KEY), code 116 (KEY_POWER), value 0
Event: time 1369641859.992842, -------------- SYN_REPORT ------------
Event: time 1369641860.582840, type 1 (EV_KEY), code 116 (KEY_POWER), value 1
Event: time 1369641860.582840, -------------- SYN_REPORT ------------
Event: time 1369641860.862840, type 1 (EV_KEY), code 116 (KEY_POWER), value 0
Event: time 1369641860.862840, -------------- SYN_REPORT ------------
Event: time 1369641861.332838, type 1 (EV_KEY), code 116 (KEY_POWER), value 1
Event: time 1369641861.332838, -------------- SYN_REPORT ------------
Event: time 1369641861.592839, type 1 (EV_KEY), code 116 (KEY_POWER), value 0
Event: time 1369641861.592839, -------------- SYN_REPORT ------------
^C
root at obsa6:~#
END--------

Best regards

Atsushi Yamagata
--- Atsushi Yamagata
