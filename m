From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Apr 2018 18:48:26 +0100
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180416155259.GB5671@atomide.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416155259.GB5671@atomide.com>
Message-ID: <20180416174826.GJ10990@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 08:52:59AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> > Since this uses a USB adapter (built onto the board) it could be
> > that there could be a bug in the driver for that rather than the
> > OMAP4430 SDP, but I've no way to check that hypothesis.
> 
> Does it go away when you do a warm reboot of the sdp? Then
> it should not be related to the USB iff the ftdi chip is bus
> powered by VBUS.

Yes, the FTDI chip is bus powered.

I booted, ran vi, quit vi, saw corruption, typed reboot, waited for
it to reboot, ran vi, quit vi, and still saw corruption.  So the
reboot seems to have had no effect.

I don't see it with other USB serial consoles on other machines...
I have two of these using the same FTDI chipset:

Bus 001 Device 021: ID 0403:6011 Future Technology Devices International, Ltd FT4232H Quad HS USB-UART/FIFO IC
Bus 001 Device 020: ID 0403:6011 Future Technology Devices International, Ltd FT4232H Quad HS USB-UART/FIFO IC

Device 20 is the SDP board, and device 21 is a ZII board.  Both use
port 2 on the quad ftdi device.  The serial console on the ZII board
is fine, so that seems to rule out the FTDI driver / FTDI hardware.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
