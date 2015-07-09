From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 9 Jul 2015 23:46:10 +0200
Subject: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong
 in sysfs
In-Reply-To: <20150709213922.GA32698@amd>
References: <20150709213922.GA32698@amd>
Message-ID: <20150709214610.GA20890@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
> Hi!
> 
> sysfs should contain one value per file. This one has at least two,
> with nice english sentence as a bonus.
> 
> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
> cat vbus
> Vbus off, timeout 1100 msec
> 
> :-(.

Plus, documentation for this is nowhere to be seen:

pavel at amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
pavel at amd:/data/l/linux-n900$

..which is a shame, because it is not really clear how to use this
one:

root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
cat mode
b_idle
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a_suspend > mode
-bash: echo: write error: Invalid argument
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a > mode
-bash: echo: write error: Invalid argument
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a_host > mode
-bash: echo: write error: Invalid argument
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo b_host > mode
-bash: echo: write error: Invalid argument
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo a_idle > mode
-bash: echo: write error: Invalid argument
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
echo b_wait_acon > mode
-bash: echo: write error: Invalid argument
root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#


									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
