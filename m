From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 15:29:03 +0200
Subject: [PATCH V5 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <f4872ed7-b6e4-4050-9445-5176f5aa961a@VA3EHSMHS017.ehs.local>
References: <1301444651-18008-1-git-send-email-john.linn@xilinx.com>
	<201103301344.45307.arnd@arndb.de>
	<f4872ed7-b6e4-4050-9445-5176f5aa961a@VA3EHSMHS017.ehs.local>
Message-ID: <201103301529.03648.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2011, John Linn wrote:
> Yes that makes sense.  We don't have immediate plans for PCI and 
> I was assuming when we add PCI we would need to change that.  
> 
> If you think I shouldn't put it off then I'll fix it now.  My 
> preference was to get the platform supported, then add more features.

Getting it fixed properly depends a bit on the PCI implementation.
I've been planning to clean up this part of the ARM architecture
for some time and I can probably do it for one more platform when
I get to it.

My idea for the multiplatform kernel is to have a global I/O space
window (maybe 1 MB) that is in the same location in the virtual
address space all the time, so any platform that wants to support
PCI with direct-mapped I/O space can simply map it in there
at boot time.

	Arnd
