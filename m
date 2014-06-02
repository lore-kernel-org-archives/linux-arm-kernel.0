From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jun 2014 13:42:42 +0100
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
Message-ID: <20140602124242.GB933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 02:27:41PM +0200, Holger Schurig wrote:
> But all seemed to never been able to transmit: a tshark running on a
> different computer didn't notice any packets from the iMX6Q board, not
> even ARP. However, the barebox boot loader *IS* able to get data over
> the ethernet, so the hardware must be ok ...

Are the pinmux settings correct?

Specifically, look at the transmit clocking arrangement.  From your
logs, it appears that the FEC has not even tried to process the packet
in the TX ring.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
