From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Oct 2011 07:54:04 -0700
Subject: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to
	happen in init_early
In-Reply-To: <4E8EA2A4.5070301@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005014044.GZ6324@atomide.com>
	<alpine.LFD.2.02.1110042150190.9106@xanadu.home>
	<20111006013656.GG6324@atomide.com> <4E8EA2A4.5070301@ti.com>
Message-ID: <20111007145403.GG6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:22]:
> The changes looks fine to me. Though the ugly hard-coding
> is back with it, it's a step towards generic_io, so hopefully
> it won't have to stay for long time.

Nico please correct me if I'm wrong, but I think that with
generic map_io we have static mappings in place after map_io,
and then ioremap should work for the static mappings right
after map_io except without the need for __arch_ioremap.

Regards,

Tony
