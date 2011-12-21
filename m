From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Dec 2011 17:23:48 +0800
Subject: Is Pandaboard cpuhotplug working stably?
Message-ID: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,
i tried cpuhotplug on pandaboard for both
Pandroid_Froyo_L27.8.2_release_pkg and Linaro 11.11. It has failed to
work stably.
On Pandroid_Froyo_L27.8.2_release_pkg, unplugging cpu1 works well:
# echo 0 > /sys/devices/system/cpu/cpu1/online
CPU1: shutdown

if i enable the cpu1 again by "echo 1 >
/sys/devices/system/cpu/cpu1/online", the system will restore to 3
random status: hang, normal, panic.

Using  Linaro 11.11 release, "echo 0 >
/sys/devices/system/cpu/cpu1/online" will make system hang and the
whole system will not be able to reset by pressing reset key, the only
way to reset system is pulling out AV power.

i am sorry i can't get more time to debug and find more clues. just
want to ask people whether this is a version the cpuhotplug works
normal on?

Thanks
barry
