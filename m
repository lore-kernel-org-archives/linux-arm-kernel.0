From: rabin@rab.in (Rabin Vincent)
Date: Mon, 8 Aug 2016 11:08:57 +0200
Subject: debug tip after earlycon is closed?
In-Reply-To: <20160728122022.GZ1041@n2100.armlinux.org.uk>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
 <3860396.RT1mlU0LAT@wuerfel>
 <CAK7LNARtm_2uT3nbga4X0dMYs9jhKa8a2FTGJrYbVRg8P3vHQw@mail.gmail.com>
 <7034241.kLArk8ex69@wuerfel>
 <20160728122022.GZ1041@n2100.armlinux.org.uk>
Message-ID: <20160808090857.GA20832@lnxartpec.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 01:20:22PM +0100, Russell King - ARM Linux wrote:
> To me, what this means is that the DT parsing of linux,stdout is
> broken - while it may look nice from a design point of view, the
> design is wrong and fails to take account of non-UART consoles in
> the system.

Note that the brokeness you describe also leads to stdout-path being
unable to put the console on any serial port but the first, as reported
here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323811.html

It always puts the console on the first serial port if CONFIG_VT_CONSOLE
is not enabled, even if the stdout-path property requests a different
serial port.
