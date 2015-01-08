From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jan 2015 12:14:10 +0000
Subject: Question regarding Linux Bringup in ARMA9 platform
In-Reply-To: <CAACKNgW6S4fFvsczgMODb6NdH+r_H62VAHG+-3uWcK7RFHUUdw@mail.gmail.com>
References: <CAACKNgW6S4fFvsczgMODb6NdH+r_H62VAHG+-3uWcK7RFHUUdw@mail.gmail.com>
Message-ID: <20150108121410.GT12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 03:42:29PM +0530, Abhijit Ray Chaudhury wrote:
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0
> Linux version 3.6.0-uc0  (gcc version 4.7.1 (crosstool-NG 1.16.0) ) #7 PREEMPT Tue Jan 6 12:29:13 IST 2015
> CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7f

You're using a very old kernel, which leaves the alignment fault
enabled,r ather than relying on the CPU to fix up alignment faults
itself.  Newer kernels should have this fixed.  Or apply

"ARM: 7150/1: Allow kernel unaligned accesses on ARMv6+ processors"

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
