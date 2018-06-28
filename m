From: drjones@redhat.com (Andrew Jones)
Date: Thu, 28 Jun 2018 19:32:43 +0200
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
Message-ID: <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 05:30:51PM +0100, Sudeep Holla wrote:
> I am not sure if we can ever guarantee that DT and ACPI will get the
> same ids whatever counter we use as it depends on the order presented in
> the firmware(DT or ACPI). So I am not for generating ids for core and
> threads in that way.

I don't believe we have to guarantee that the exact (package,core,thread)
triplet describing a PE with DT matches ACPI. We just need to guarantee
that each triplet we select properly puts a PE in the same group as its
peers. So, as long as we keep the grouping described by DT or ACPI, then
the (package,core,thread) IDs assigned are pretty arbitrary.

I could change the commit message to state we can generate IDs *like*
DT does (i.e. with counters), even if they may not result in identical
triplet to PE mappings.

> 
> So I would like to keep it simple and just have this counters for
> package ids as demonstrated in Shunyong's patch.
> 

If we don't also handle cores when there are threads, then the cores
will also end up having weird IDs.

Thanks,
drew
