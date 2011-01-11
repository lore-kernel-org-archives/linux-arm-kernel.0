From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 15:59:30 +0000
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
Message-ID: <20110111155930.GH11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 09:16:38PM +0530, Rabin Vincent wrote:
> It's possible to hack around this by placing the initramfs at the end of
> the kernel image rather than at the beginning with the rest of the init
> data.  Something like the below should work, although you should also
> probably take care of alignment and also have this section freed when
> the rest of the init data is freed.

You're then running into problems as _sdata.._edata is copied to RAM on
XIP kernels, and you really don't want to waste time copying the
initramfs to RAM.
