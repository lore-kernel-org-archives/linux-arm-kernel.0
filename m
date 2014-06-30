From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 10:13:52 +0100
Subject: [PATCH 0/2] arm64: clean up /proc/cpuinfo
In-Reply-To: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140630091352.GP7262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Sat, Jun 28, 2014 at 02:11:58AM +0100, Bjorn Helgaas wrote:
> On arm64, /proc/cpuinfo currently looks like:
> 
>     Processor       : AArch64 Processor rev 0 (aarch64)
>     processor       : 0
>     processor       : 1
>     ...
>     Features        : ...
> 
> Compared to most other architectures (including arm), this has an extra
> "Processor" header, and the "Features" and other bits only appear once,
> so there's no way to have per-CPU features, variants, etc.
> 
> These patches make arm64 more consistent with the other architectures
> by removing the extra header and printing the CPU ID information for
> each CPU.

This looks very much like the series I've been working on [1,2,3], that
reports the MIDR information and performs some additional sanity
checking (expecting CPUs to have identical hwcap features).

Did you need this for any reason it particular, or was this just a clean
up?

Does my series look OK to you?

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/255389.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/264387.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266973.html
