From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 18:55:25 +0000
Subject: [PATCH 0/8] arm64 kexec kernel patches V7
In-Reply-To: <20150126174414.GF14048@e104818-lin.cambridge.arm.com>
References: <cover.1415926876.git.geoff@infradead.orgg>
 <cover.1421449714.git.geoff@infradead.org>
 <20150126174414.GF14048@e104818-lin.cambridge.arm.com>
Message-ID: <20150126185524.GN23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 05:44:14PM +0000, Catalin Marinas wrote:
> Hi Geoff,
> 
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> > This series adds the core support for kexec re-boots on arm64.  This v7 of the
> > series is mainly just a rebase to the latest arm64 for-next/core branch
> > (v3.19-rc4), and a few very minor changes requested for v6.
> 
> I haven't looked at the series in detail before, so some of my comments
> may have already been discussed.
> 
> > Several things are known to have problems on kexec re-boot:
> > 
> > spin-table
> 
> I think that's not too bad, for complete kexec support (SMP->SMP) we can
> require some CPU unplug mechanism and PSCI is one of them.
> 
> > FIX: Upgrade system firmware to provide PSCI enable method support or add
> > missing spin-table support to the kernel.
> 
> What's the missing spin-table support?

As you mention above, a mechanism for returning the CPUs to FW. There is
no spec for doing this with spin-table, which would have to be written
and vetted.

Mark.
