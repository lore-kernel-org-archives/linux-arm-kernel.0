From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 May 2011 13:10:39 +0200
Subject: [PATCH v6 00/18] ARM: Add support for the Large Physical Address
	Extensions
In-Reply-To: <alpine.LFD.2.00.1105242042340.3207@xanadu.home>
References: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
	<8yapqn7fyab.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1105242042340.3207@xanadu.home>
Message-ID: <201105251310.39609.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 May 2011, Nicolas Pitre wrote:
> > Do you expect non LPAE targets to be able to boot with these changes
> > applied (and LPAE enabled)?  I am able to build this tree for the
> > MSM8660 (with a minor patch below), but it fails to boot with LPAE
> > enabled.  It seems to work fine with LPAE not enabled.
> 
> I wouldn't expect a LPAE kernel to boot on non LPAE capable hardware.
> 
> And I don't think we'll ever try to support both LPAE and non-LPAE modes 
> in the same kernel binary either since this has implications all over 
> the place in core kernel mm code.

Just for information and to complete the picture, what other of these
combinations are possible?

* Non-LPAE kernel on LPAE-capable hardware

* LPAE kernel as KVM guest of LPAE kernel

* non-LPAE kernel as KVM guest of LPAE kernel

* LPAE kernel as KVM guest of non-LPAE kernel

* non-LPAE kernel as KVM guest of non-LPAE kernel on LPAE-enabled hardware

	Arnd
