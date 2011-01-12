From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 12 Jan 2011 17:25:28 +0100
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <20110111155930.GH11039@n2100.arm.linux.org.uk>
References: <4D2B4CE4.9080309@ahsoftware.de>	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>	<4D2BFA08.5030104@ahsoftware.de>	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
Message-ID: <4D2DD5F8.5000200@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux a ?crit :
> On Tue, Jan 11, 2011 at 09:16:38PM +0530, Rabin Vincent wrote:
>> It's possible to hack around this by placing the initramfs at the end of
>> the kernel image rather than at the beginning with the rest of the init
>> data.  Something like the below should work, although you should also
>> probably take care of alignment and also have this section freed when
>> the rest of the init data is freed.
> 
> You're then running into problems as _sdata.._edata is copied to RAM on
> XIP kernels, and you really don't want to waste time copying the
> initramfs to RAM.
> 
But in this case initramfs is after edata and before bss.
So where is the problem ?


Matthieu
