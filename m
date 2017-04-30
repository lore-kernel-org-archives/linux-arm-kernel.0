From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 30 Apr 2017 18:04:30 +0200
Subject: [PATCH 0/4] TI Bluetooth serdev support
In-Reply-To: <CAHCN7xJUxZm1qKAxT0kaK6qoDg+HWOJK7sTH-q9za4HJuUwe8Q@mail.gmail.com>
References: <20170405183005.20570-1-robh@kernel.org>
 <CAHCN7xJUxZm1qKAxT0kaK6qoDg+HWOJK7sTH-q9za4HJuUwe8Q@mail.gmail.com>
Message-ID: <20170430160430.rmyuo6sdrkrjxjg6@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 30, 2017 at 10:14:20AM -0500, Adam Ford wrote:
> On Wed, Apr 5, 2017 at 1:30 PM, Rob Herring <robh@kernel.org> wrote:
> > This series adds serdev support to the HCI LL protocol used on TI BT
> > modules and enables support on HiKey board with with the WL1835 module.
> > With this the custom TI UIM daemon and btattach are no longer needed.
> 
> Without UIM daemon, what instruction do you use to load the BT firmware?
> 
> I was thinking 'hciattach' but I was having trouble.  I was hoping you
> might have some insight.
> 
>  hciattach -t 30 -s 115200 /dev/ttymxc1 texas 3000000 flow  Just
> returns a timeout.
> 
> I modified my i.MX6 device tree per the binding documentation and
> setup the regulators and enable GPIO pins.

If you configured everything correctly no userspace interaction is
required. The driver should request the firmware automatically once
you power up the bluetooth device.

Apart from DT changes make sure, that the following options are
enabled and check dmesg for any hints.

CONFIG_SERIAL_DEV_BUS
CONFIG_SERIAL_DEV_CTRL_TTYPORT
CONFIG_BT_HCIUART
CONFIG_BT_HCIUART_LL

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170430/f8f82e8d/attachment.sig>
