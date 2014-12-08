From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 8 Dec 2014 11:24:27 +0000
Subject: [PATCH v2 0/6] Improve PSCI system events and fix reboot bugs
In-Reply-To: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
References: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAFEAcA_K7p0h1EgAxqcg5EqN8VXC60XoHsttbVtbxUAxuceziQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2014 at 21:18, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> Several people have reported problems with rebooting ARM VMs, especially
> on 32-bit ARM.  This is mainly due to the same reason we were seeing
> boot errors in the past, namely that the ram, dcache, and icache weren't
> coherent on guest boot with the guest (stage-1) MMU disabled.  We solved
> this by ensuring coherency when we fault in pages, but since most memory
> is already mapped after a reboot, we don't do anything.
>
> The solution is to unmap the regular RAM on VCPU init, but we must
> take care to not unmap the GIC or other IO regions, hence the somehwat
> complicated solution.
>
> As part of figuring this out, it became clear that some semantics around
> the KVM_ARM_VCPU_INIT ABI and system event ABI was unclear (what is
> userspace expected to do when it receives a system event).  This series
> also clarifies the ABI and changes the kernel functionality to do what
> userspace expects (turn off VCPUs on a system shutdown event).

Userspace ABI documentation clarifications:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM
