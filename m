From: skrishnakar@gmail.com (srikanth krishnakar)
Date: Fri, 7 Feb 2014 13:57:02 +0530
Subject: renesas-backport.git: Linux-3.10.28 Marzen (R8A7779) missing Audio
 Support
Message-ID: <CALDxG5hUg3BNkszevNpYdmD=YqrOLLGb0p3ZKTN7_qS9BQZ2+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying to boot the Renesas R-Car H1 (Marzen) board with 3.10 LTSi
kernel which is present at :

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backport.git/

Branch: backport/v3.10.28-ltsi-rc1/snapshot

There are no sound cards detected on booting this kernel, although
graphics is found to be working. Are there any updates which adds the
RCAR_SOUND support to Marzen on v3.10 LTSi kernel ?

--------------------------

root <at> marzenh1:~# cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
  29:       5840      17228       5026      14491       GIC  twd
  59:          0          0          0          0       GIC  renesas_intc_irqpin
  60:       8094          0          0          0       GIC  renesas_intc_irqpin
  61:          0          0          0          0       GIC  renesas_intc_irqpin
  62:          0          0          0          0       GIC  renesas_intc_irqpin
  63:          0          0          0          0       GIC
rcar-du-r8a7779, rcar-du-r8a7779
  64:         13          0          0          0       GIC  sh_tmu.0
  76:         60          0          0          0       GIC
ehci_hcd:usb1, ohci_hcd:usb3
  77:          1          0          0          0       GIC
ehci_hcd:usb2, ohci_hcd:usb4
  96:          0          0          0          0       GIC  r8a7779-vin.1
  98:          0          0          0          0       GIC  r8a7779-vin.3
 111:         82          0          0          0       GIC  i2c-rcar.0
 112:          0          0          0          0       GIC  i2c-rcar.2
 113:          0          0          0          0       GIC  i2c-rcar.3
 114:          0          0          0          0       GIC  i2c-rcar.1
 122:        982          0          0          0       GIC  sh-sci.2:mux
 132:          0          0          0          0       GIC  sata_rcar
 136:         52          0          0          0       GIC  sh_mobile_sdhi.0
 173:          0          0          0          0       GIC  gpio_rcar.0
 174:          0          0          0          0       GIC  gpio_rcar.1
 175:          0          0          0          0       GIC  gpio_rcar.2
 176:          0          0          0          0       GIC  gpio_rcar.3
 177:          0          0          0          0       GIC  gpio_rcar.4
 178:          0          0          0          0       GIC  gpio_rcar.5
 179:          0          0          0          0       GIC  gpio_rcar.6
2001:       8094          0          0          0  renesas_intc_irqpin  eth0
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:        476       1715       1732       1236  Rescheduling interrupts
IPI3:         50         62        112        112  Function call interrupts
IPI4:          0          0          0          0  Single function
call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
 Err:          0
...
....
.....
root <at> marzenh1:~# aplay -l
aplay: device_list:268: no soundcards found...

---------------------------
When will be the Audio support available for R-Car Marzen (R8A7779) on
v3.10 LTSi kernel ?

Your inputs are highly appreciated.
**********************
