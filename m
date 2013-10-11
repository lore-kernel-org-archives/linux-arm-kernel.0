From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 11:49:20 +0100
Subject: New big-endian patch series against 3.12-rc4
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5257D7B0.3010108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 08/10/13 23:34, Ben Dooks wrote:
> This is a new series for big-endian on ARM re-based onto 3.12-rc4
> and updated with new patches from Victor to fix regressions since 3.11.
> 
> I have not been able to test this further than building it as I do not
> currently have access to any hardware, however there where no big issues
> when re-basing. Thanks to Marc Zyngier for pointing out the need for a
> rebase.
> 
> The branch is at:
> 
>   git://git.baserock.org/delta/linux baserock/bjdooks/3.12-rc4/core
> 
> Russell, if possible could this go into -next and then if everything
> I can issue a pull request for it.
> 
> Changes since last:
> 
> - Updated to 3.12-rc4 to be closer to mainline
> - Added Victor's patches for CCI and TC2 boot
> - Added Victor's patch for ASID extraction
> - Updated Victor's patch with fix for building on older kernels

For what it is worth, I've just gave this series a run as a KVM/arm64
guest, running some Linaro OE userspace.

While this doesn't exercise any of the driver code (the guest is
entirely virtio based, and I have a separate patch series for this), the
core code looks solid enough.

I'm looking forward to seeing this series in next.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
