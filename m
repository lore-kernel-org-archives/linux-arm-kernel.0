From: bp@alien8.de (Borislav Petkov)
Date: Fri, 23 Jun 2017 15:56:07 +0200
Subject: [PATCH v6 0/3] Cavium ARM64 uncore PMU support
In-Reply-To: <20170623130128.11006-1-jglauber@cavium.com>
References: <20170623130128.11006-1-jglauber@cavium.com>
Message-ID: <20170623135607.qey6p3pt4fltvyas@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 03:01:25PM +0200, Jan Glauber wrote:
> Add support for various PMU counters found on the Cavium ThunderX and
> OcteonTx SoC.
> 
> The driver provides common "uncore" functions to avoid code duplication and
> support adding more device PMUs (like L2 cache) in the future.
> 
> Probe and removal of the PMUs is done by hooking into the ThunderX EDAC
> driver as this driver owns all the PCI devices containing the PMU counters.

... which is a very bad idea, of course. EDAC doesn't have anything to
do with performance measurements.

And I don't see why the EDAC driver should own any PCI devices -
EDAC simply uses them like anything else in the kernel so the PMU
functionality can simply use them too, independent from EDAC.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
