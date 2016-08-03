From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 3 Aug 2016 19:13:52 +0200
Subject: [PATCH] KVM: arm64: ITS: move ITS registration into first VCPU run
In-Reply-To: <20160803145745.7556-1-andre.przywara@arm.com>
References: <20160803145745.7556-1-andre.przywara@arm.com>
Message-ID: <20160803171352.GZ32244@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 03:57:45PM +0100, Andre Przywara wrote:
> Currently we register ITS devices upon userland issuing the CTRL_INIT
> ioctl to mark initialization of the ITS as done.
> This deviates from the initialization sequence of the existing GIC
> devices and does not play well with the way QEMU handles things.
> To be more in line with what we are used to, register the ITS(es) just
> before the first VCPU is about to run, so in the map_resources() call.
> This involves iterating through the list of KVM devices and handle each
> ITS that we find.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> this is based upon next-20160728 plus Christoffer's kvm_device locking

Since my fix was horribly broken, I suggest you just base this on next
and let it be similarly broken to the vfio-device that we already have
in the kernel.

That way, we get the userspace ABI right and we fix KVM in general for -rc2.

Paolo/Radim, are you ok with this?

Thanks,
-Christoffer
