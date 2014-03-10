From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 9 Mar 2014 22:21:59 -0300
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Fri, Mar 7, 2014 at 2:04 PM, Denis Carikli <denis@eukrea.com> wrote:

> +static int usbmisc_imx25_init(struct imx_usbmisc_data *data)
> +{
> +       void __iomem *reg = NULL;

This variable is not used and causes a warning. Please remove it.

After applying this patch things go further when I boot with a USB
thumb connected to the USB Host1 port:

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
usbcore: registered new interface driver usb-storage
53ff4400.usb supply vbus not found, using dummy regulator
ci_hdrc ci_hdrc.0: EHCI Host Controller
ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
....

usb 1-1: new full-speed USB device number 2 using ci_hdrc

(Not sure why it says full-speed device. When I connect the same
device to a PC it says high-speed)

usb 1-1: not running at top speed; connect to a high speed hub
usb-storage 1-1:1.0: USB Mass Storage device detected
usb-storage 1-1:1.0: Quirks match for vid 0457 pid 0151: 80
scsi0 : usb-storage 1-1:1.0
scsi 0:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
sd 0:0:0:0: [sda] 248000 512-byte logical blocks: (126 MB/121 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Asking for cache data failed
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Asking for cache data failed
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Asking for cache data failed
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Attached SCSI removable disk
fec 50038000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.8
IP-Config: Complete:
     device=eth0, hwaddr=00:04:00:00:00:00, ipaddr=192.168.0.8, mask=255.255.251
     host=192.168.0.8, domain=, nis-domain=(none)
     bootserver=192.168.0.1, rootserver=192.168.0.2, rootpath=
     nameserver0=192.168.0.1
ALSA device list:
  No soundcards found.
VFS: Mounted root (nfs filesystem) readonly on device 0:13.
devtmpfs: mounted
Freeing unused kernel memory: 276K (c0697000 - c06dc000)
starting pid 536, tty '': '/etc/rc.d/rcS'
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug events
imx-sdma 53fd4000.sdma: firmware not found

(Then system hangs here).

If I boot without the USB thumb connected, then I reach the prompt,
however after inserting the USB pen drive into USBH1 there is no
detection.

Any ideas?

Thanks,

Fabio Estevam
