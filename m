From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jan 2016 09:51:07 +0000
Subject: [linux-next PATCH] arm64: fix kernel crash with 48-bit VA and
 64KB granule
In-Reply-To: <20160106085929.GB7879@arm.org>
References: <CAKv+Gu9Q3CmC37dL3o+hcBeG-NJ7+bkOiLQihirje4YbazizJQ@mail.gmail.com>
 <20160105084042.GF13942@arm.org>
 <20160105095603.GG6301@e104818-lin.cambridge.arm.com>
 <20160106061407.GA7082@arm.org>
 <CAKv+Gu8t56rfdN1ot08BgsteaaincFek0uzoDAroefMWQ+kKEA@mail.gmail.com>
 <20160106073847.GA7608@arm.org>
 <CAKv+Gu_sqAuA_iHf_sNRJyaQUFG5n_eXxYYOHwmV0hf0GTUxow@mail.gmail.com>
 <20160106085216.GA7879@arm.org>
 <CAKv+Gu_ivfmfFyK79g63ciBD3Jv7bzzu5t_NYW2aVy8NhgHdSA@mail.gmail.com>
 <20160106085929.GB7879@arm.org>
Message-ID: <20160106095107.GA16580@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dennis,

On Wed, Jan 06, 2016 at 04:59:30PM +0800, Dennis Chen wrote:
> On Wed, Jan 06, 2016 at 09:54:42AM +0100, Ard Biesheuvel wrote:
> > On 6 January 2016 at 09:52, Dennis Chen <dennis.chen@arm.com> wrote:
> > > On Wed, Jan 06, 2016 at 08:42:20AM +0100, Ard Biesheuvel wrote:
> > >> On 6 January 2016 at 08:38, Dennis Chen <dennis.chen@arm.com> wrote:
> > >> > Well, if the build system changes the link order, it can't make sure it will break something
> > >> > unexpectedly, needless to say the pgd_cache_init here at all.
> > >>
> > >> That is no excuse to introduce yet another failure mode.
> > >>
> > >> > Do you think the kernel
> > >> > will change its currently link order policy? If the answer is yes, what's the benefit?
> > >> >
> > >>
> > >> It does not matter what I think. You seem to think that the link order
> > >> is set in stone, so it is you who should argue why that is a
> > >> reasonable assumption.
> > >>
> > > OK, If you think the link order is volatile, how can you guarantee the arm_enable_runtime_services with early_initcall
> > > always work in a volatile link order environment?
> > >
> > 
> > By not relying on other early_initcalls
> > 
> You're limiting the scope of the link order

Please stop this mindless bickering. It's a waste of everybody's time and
we have a kernel to test.

Will
