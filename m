From: drjones@redhat.com (Andrew Jones)
Date: Mon, 28 Nov 2016 15:07:05 +0100
Subject: [Qemu-devel] [kvm-unit-tests PATCH v7 00/11] QEMU MTTCG Test cases
In-Reply-To: <20161128140445.j336ksd7vqhi4ivz@kamzik.brq.redhat.com>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
 <20161128103744.s3wq53xzsxvu5uus@kamzik.brq.redhat.com>
 <878ts3uac6.fsf@linaro.org>
 <CAFEAcA9JUOHnJL59EuhQ_dEWjt+YjEcu8LGiJ3CSk_7R4J5Efg@mail.gmail.com>
 <20161128115824.hrofgivt2mlfk7fh@kamzik.brq.redhat.com>
 <CAFEAcA8-3qHnp1T4bAiUL3NT8fHWik7-8zruyQKGgfADn5xF9w@mail.gmail.com>
 <20161128140445.j336ksd7vqhi4ivz@kamzik.brq.redhat.com>
Message-ID: <20161128140705.caqpoiuvxy3mg2zk@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 03:04:45PM +0100, Andrew Jones wrote:
> On Mon, Nov 28, 2016 at 01:30:54PM +0000, Peter Maydell wrote:
> > On 28 November 2016 at 11:58, Andrew Jones <drjones@redhat.com> wrote:
> > > On Mon, Nov 28, 2016 at 11:14:48AM +0000, Peter Maydell wrote:
> > >> On 28 November 2016 at 11:12, Alex Benn?e <alex.bennee@linaro.org> wrote:
> > >> >
> > >> > Andrew Jones <drjones@redhat.com> writes:
> > >> >> I've skimmed over everything looking at it from a framwork/sytle
> > >> >> perspective. I didn't dig in trying to understand the tests though.
> > >> >> One general comment, I see many tests introduce MAX_CPUS 8. Why do
> > >> >> that? Why not allow all cpus by using NR_CPUS for the array sizes?
> > >> >
> > >> > Yeah - I can fix those. I wonder what the maximum is with GIC V3?
> > >>
> > >> So large that you don't want to hardcode it as an array size...
> > >
> > > 255 with the gic series, not yet merged.
> > 
> > I was talking about the architectural GICv3 limit, which is larger
> > than that by many orders of magnitude. For QEMU it looks like
> > MAX_CPUMASK_BITS is now 288 rather than 255.
> 
> Ah, yeah. So far we haven't considered testing limits beyond what
> KVM supports, VGIC_V3_MAX_CPUS=255. However with TCG, and some
> patience, we could attempt to test bigger limits. In that case,
> though, we'll want to recompile kvm-unit-tests with a larger NR_CPUS
> and run a specific unit test.
> 
> mach-virt still has 255 as well, mc->max_cpus = 255, so we'd have
> to bump that too if we want to experiment.

Er... actually mach-virt is 123, as we only allocate 123 redistributors.

drew
