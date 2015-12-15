From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Dec 2015 09:32:18 -0200
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <20151215062821.GA11241@shlinux2>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5CfBKuJ584jwbg98s9tn+0Z7W0nOaZnUkm4cJUSvNGTZw@mail.gmail.com>
 <20151215062821.GA11241@shlinux2>
Message-ID: <CAOMZO5DiRzfy5dULh0C7qU2KUM-i8fBh6W5rS9zOTHJJK6fqwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 4:28 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Thanks, Fabio.
>
> I am afraid I forget to set gpio as output, would you please apply
> below patch against my original ones:

Same error happens with these changes applied.

Here are more details: if I run a pure 4.3.2 then I do see the USB
stick to get detected if I boot it with the USB stick connected to
Udoo board:

[    2.170178] usb 1-1.1: new high-speed USB device number 3 using ci_hdrc
[    2.305840] usb-storage 1-1.1:1.0: USB Mass Storage device detected
[    2.314803] scsi host1: usb-storage 1-1.1:1.0
[    2.400283] usb 1-1.3: new high-speed USB device number 4 using ci_hdrc
[    3.327925] scsi 1:0:0:0: Direct-Access     General  USB Flash Disk   1.0  P2
[    3.347070] sd 1:0:0:0: [sda] 7831552 512-byte logical blocks: (4.01 GB/3.73)
[    3.356181] sd 1:0:0:0: [sda] Write Protect is off
[    3.362550] sd 1:0:0:0: [sda] No Caching mode page found
[    3.367899] sd 1:0:0:0: [sda] Assuming drive cache: write through
[    3.387401]  sda: sda1
[    3.400238] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    4.931847] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow contx
[    4.941414] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    4.961400] Sending DHCP requests ., OK
[    5.380247] IP-Config: Got DHCP answer from 10.29.244.251, my address is 10.1
[    5.390461] IP-Config: Complete:
[    5.393731]      device=eth0, hwaddr=00:c0:08:88:0c:b5, ipaddr=10.29.244.61,4
[    5.404074]      host=10.29.244.61, domain=am.freescale.net, nis-domain=(non)
[    5.411362]      bootserver=0.0.0.0, rootserver=10.29.244.24, rootpath=     0
[    5.423964] ALSA device list:
[    5.426969]   No soundcards found.
[    5.469374] VFS: Mounted root (nfs filesystem) readonly on device 0:14.
[    5.478119] devtmpfs: mounted
[    5.482376] Freeing unused kernel memory: 456K (c0a7e000 - c0af0000)
starting pid 160, tty '': '/etc/rc.d/rcS'
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug even[    6.085842] udevd (173): /proc/173/oom_adj .

,but the system hangs here.

If I boot it with the USB stick disconnected, then the system boots
until the prompt, but the insertion of the USB stick is never detected
afterwards.

With your patch applied, the error message (usb 1-1: device descriptor
read/64, error -7) is shown with USB stick connected or disconnected
during boot.
