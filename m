From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Tue, 24 Mar 2015 13:52:56 +0100
Subject: i.MX6 : all interrupts are only on the first CPU
Message-ID: <CAL8zT=gniU_J-7gVHa3C+FJU_CCMkbiK77-+57vTUjCXQt+KHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

It seems to be a dumb question, but couldn't find a correct answer
right now... so asking seems to be the best option I have.

I am currently running a 4.0-rc1 on a custom board, and I am observing
something strange, don't know if it is a known fact : all interrupts
are fired on the same CPU :

$> cat /proc/interrupts
           CPU0       CPU1
 16:    1071807     986017       GIC  29  twd
 17:          0          0       GIC  87  i.MX Timer Tick
 21:         24          0       GIC  65  2010000.ecspi
 22:        193          0       GIC  58  2020000.serial
 23:          0          0       GIC  78  2028000.ssi
 24:          0          0       GIC  79  202c000.ssi
 25:      17498          0       GIC  44  2040000.vpu
141:         55          0  gpio-mxc   6  adv7604
142:          0          0  gpio-mxc   7  adv7604
283:          0          0       GIC 147  120000.hdmi
284:          4          0       GIC  34  sdma
285:        252          0       GIC  72  2184200.usb
286:     195877          0       GIC 150  2188000.ethernet
287:          0          0       GIC 151  2188000.ethernet
288:      31928          0       GIC  56  mmc0
289:        440          0       GIC  57  mmc1
290:     204780          0       GIC  69  21a4000.i2c
291:          0          0       GIC  70  21a8000.i2c
295:       1842          0       GIC  71  2200000.sata
298:          0          0       IPU 457  (null)
299:          0          0       IPU 451  (null)
300:          0          0       IPU 457  (null)
301:          0          0       IPU 451  (null)
302:          0          0       IPU  23  imx_drm
303:          0          0       IPU  28  imx_drm
304:          0          0       IPU  23  imx_drm
305:          0          0       IPU  28  imx_drm
306:       1941          0       IPU 128
307:      52779          0       IPU   0
308:      45126          0       IPU  22
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:      49619     108339  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:         59        956  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:       1347          0  IRQ work interrupts
IPI7:          0          0  completion interrupts

/proc/irq/default_smp_affinity -> 3

So, it should balance a bit between both CPUs, or am I
misunderstanding something ?
Maybe a configuration issue ?

Thanks,
JM
