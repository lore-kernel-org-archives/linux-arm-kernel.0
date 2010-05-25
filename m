From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Tue, 25 May 2010 13:57:33 -0500
Subject: facing undefined inconsistent cache issues on cortex-a9
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C57A5FC6@dbde02.ent.ti.com>
References: <4BF9F5FB.6020306@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57001F3@dbde02.ent.ti.com>
	<4BFBBD83.5080302@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57A5FC6@dbde02.ent.ti.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BB37005A@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Shilimkar, Santosh

> > > Does this work if disable L1D as well on the processor you are running
> Linux ??
> > >
> > If we disable the L1 DCache we are never able to boot.
> > But this might be a different problem.
> >
> > If we disable ICache and leave DCache on it is much more stable, and
> > I think it might be related to timing issue in the data path.
> >
> For me, it seems that Cache isn't invalidated properly which leads to this
> issue.
> May be you can report the complete crash-log which can give more idea on the
> issue.

If you are unable to boot with dcache off then maybe your memory controller or memory part has timing issues.  Cache on will trigger burst accesses using different timings.  Such an early failure is more likely an issue outside of the arm unless you are doing something really odd.

Regards,
Richard W.
