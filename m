From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 30 Jan 2014 10:22:00 +0100
Subject: [U-Boot] recommended action for bootloaders regarding modifying
 device-tree nodes
In-Reply-To: <CAJ+vNU366GiY4k_rnh1Jf0kra+PU99w4tDdM2sNioUAJCiZqOA@mail.gmail.com>
References: <CAJ+vNU366GiY4k_rnh1Jf0kra+PU99w4tDdM2sNioUAJCiZqOA@mail.gmail.com>
Message-ID: <CAOMqctSYBmbox9VifYHn9ej+onp2JVhMNXjns=uMMHgmWoTjDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 30 January 2014 10:11, Tim Harvey <tharvey@gateworks.com> wrote:
> Greetings,
>
>
> Is it more appropriate for the bootloader to 'remove' nodes for
> devices that are not physically present or should I be setting their
> status property to 'disabled' instead?  I'm not clear if either option
> really has any pros or cons.
>

I am not a DT or u-boot developer but I observe these things:

1) DT include for a SoC has all supported devices. Some which require
external parts (eg. physical connectors, extra PHY, ...) are listed as
disabled and particular board DT enables them.

2) there is code for setting mac address on ethernet nodes with a
specific alias so you could perhaps reuse this code to set disabled
option on particular nodes.

Thanks

Michal
