From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 26 Apr 2013 17:36:16 +0530
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <CAFEAcA_xmrHTvR7FxUr3PCKBJY-hZnkeBcqyHksTB4-hqOZS0w@mail.gmail.com>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <BA2076A6-0688-4E5C-85F9-A9CA8FD75782@suse.de>
 <CAFEAcA_xmrHTvR7FxUr3PCKBJY-hZnkeBcqyHksTB4-hqOZS0w@mail.gmail.com>
Message-ID: <CALrVBkuOmu4u9egdzzfn1tU9B-CFe3w85HZQ9s2gpKvYnaSqvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2013 17:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 April 2013 12:19, Alexander Graf <agraf@suse.de> wrote:
>> MMIO registers are handled by a different layer than the virtio
>> console itself. After the virtio refactoring in QEMU, they will
>> be completely separate drivers.
>
> Good point -- we don't really want to be mixing up the
> transport and the backend. You can see it in the kvmtool
> patch, in fact -- it introduces an "if this is virtio-console"
> special case into the mmio.c file which previously was
> entirely backend agnostic.

Well, we can always have virtio device specific config registers
handle by virtio device backends and generic virtio config register
handled by transport.

kvmtool patch is hacky because it does not provide virtio device
specific config read/write callbacks.

>
> thanks
> -- PMM
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

--Anup
