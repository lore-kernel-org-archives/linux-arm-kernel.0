From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 May 2017 17:56:51 +0100
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <828a8817-b18d-6945-f35e-115abf30fe17@gmail.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <828a8817-b18d-6945-f35e-115abf30fe17@gmail.com>
Message-ID: <20170525165651.GK22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 09:15:19AM -0700, Florian Fainelli wrote:
> On 05/18/2017 03:52 AM, Russell King - ARM Linux wrote:
> > As a result of a recent bug report, it has been found that certain CPUs
> > must always have SMP mode enabled in order for the caches to work.
> > 
> > Remove the conditional on setting the SMP bit(s).
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > This needs to be tested on:
> > 
> > - Cortex A5MP
> > - Cortex A9MP
> > - Cortex R7MP
> > - Cortex A7MP
> > - Cortex A12MP
> > - Cortex A15MP
> > - Cortex A17MP
> > - Brahma B15
> 
> Sorry just saw this, what kind of test do you want me to run on B15?
> Should I build a !SMP kernel, or force a SMP kernel with maxcpus=1?

What I'm after is testing on any single-core systems with these SMP
capable cores.  If the core never appears in a single-core configuration,
then please let me know so it can be crossed off the list.

With the bug that crept in fixed (as pointed out by Tony) there is no
difference for kernels built with SMP enabled and detected as a SMP
capable CPU.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
