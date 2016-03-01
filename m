From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Mar 2016 00:19:23 +0300
Subject: [PATCH v2 0/8] arm64: Support for systems without AArch32 state
In-Reply-To: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160301211923.GA1325@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 09:52:40AM +0000, Suzuki K Poulose wrote:
> This series add checks to make sure that the AArch32 state is
> supported before we process the 32bit ID registers. Also
> checks the same for COMPAT binary execution.
> 
> (Painfully) applies on top of 4.5-rc5 + [1] + [2].
> 
> Or it is available here :
>   git://linux-arm.org/linux-skp.git noaarch32/v2-4.5-rc5
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/410556.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401913.html
> 
> Changes since V1:
>   - Prevent changing the personality to PER_LINUX32 by adding
>     wrapper for personality() syscall.
>   - Add the check to KVM before initialising a AArch32 vcpu
>   - Tested on hardware.
> 
> Btw, linux32 doesn't complain when the personality() syscall fails to change
> to PER_LINUX32. You can verify the personality by running 
>  $ cat /proc/cpuinfo
>  which would still list the 64bit features for the CPUs.

Hi Suzuki,

I have some troubles with access to appropriate hardware to test
it, but I didn't forget.

Yury.
