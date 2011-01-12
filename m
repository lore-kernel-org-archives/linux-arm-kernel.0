From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 12 Jan 2011 13:55:24 -0500 (EST)
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <20110112184258.GH11039@n2100.arm.linux.org.uk>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
	<AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
	<alpine.LFD.2.00.1101121314470.25498@xanadu.home>
	<20110112184258.GH11039@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101121350350.25498@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jan 2011, Russell King - ARM Linux wrote:

> Then came along the embedded initrd/initramfs idea which rather buggered
> the scheme when large initramfs are embedded into the image.
> 
> As the overall feeling at the time was "don't use large initrds" it's
> something I've never really cared about - and I'm still of the opinion
> that 16MB of compressed initrd/initramfs is rather silly.

It is... but we have more than 32MB of RAM total now, and people are 
running standard distributions on ARM these days, such as Fedora or 
Ubuntu, including their corresponding initrd that may contain lots of 
modules, splashscreen data, etc.  So it might be a good idea to think 
about fixing this limitation before it comes back again.


Nicolas
