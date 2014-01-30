From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 30 Jan 2014 01:11:18 -0800
Subject: recommended action for bootloaders regarding modifying device-tree
 nodes
Message-ID: <CAJ+vNU366GiY4k_rnh1Jf0kra+PU99w4tDdM2sNioUAJCiZqOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I develop the boot-loader and kernel for a family of boards that have
an on-board EEPROM which contains information as to what options are
physically loaded on the board such as memory size/config, and
peripheral IC's.  We allow customers to create special builds of our
standard products with sub-loaded components and while each
combination of options ends up with a unique model number, it seems
silly to create a different static device-trees for each possible
option (not to mention we don't create the unique model number until
an order is placed).

My approach has been to define a per-baseboard device-tree in Linux
for a 'fully loaded' board, then remove nodes which the EEPROM claims
are not present in the bootloader before it passes the DTB to the
kernel.  I do this by defining aliases in the device-tree for the
peripherals that are 'optional' so that the bootloader itself does not
need to know the details about how the device is connected.

Is it more appropriate for the bootloader to 'remove' nodes for
devices that are not physically present or should I be setting their
status property to 'disabled' instead?  I'm not clear if either option
really has any pros or cons.

Thanks for any suggestions or comments,

Tim

Tim Harvey - Principal Software Engineer
Gateworks Corporation
3026 S. Higuera St. San Luis Obispo CA 93401
805-781-2000
