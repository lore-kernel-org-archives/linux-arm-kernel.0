From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jul 2017 13:19:59 +0100
Subject: [PATCH 00/16] arm/arm64: Workaround misprogrammed CNTFRQ
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170724121958.GC29919@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 06:15:26PM +0100, Marc Zyngier wrote:
> It is an unfortunate situation that CNTFRQ{,_EL0} is often
> misprogrammed from the firmware side, leaving it up to the kernel to
> work around it. This is usually done by providing an alternative
> frequency in the Device Tree.
> 
> Unfortunately, CNTFRQ is accessible from EL0, giving userspace the
> wrong frequency, and potentially a different frequency per CPU, which
> is definitely not what you want. A possible workaround is to trap this
> into the kernel and to emulate it (together with the VDSO being
> disabled), and this is what this series is achieving.

Which userspace is actually affected by a broken CNTFRQ register? I suspect
most users will be more upset at losing their (perfectly functional) vDSO
acceleration than they are about having a broken CNTFRQ value that is hardly
ever used, especially since this affects quite a few systems.

Will
