From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jun 2018 16:55:56 +0100
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
Message-ID: <20180629155556.GD16282@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 05:46:08PM +0200, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:

[..]

> > 
> > How is that different from OS generated one from user's perspective ?
> > Vendors might assign sockets UID and he may help them to replace one.
> > Having some generated counter based id is not helpful.
> 
> I agree with this. It's a good argument for maintaining a mapping of
> package-id to id-physically-printed-on-a-package somewhere. To avoid
> maintaining a mapping it could just be stored directly in
> cpu_topology[cpu].package_id, but then how can we tell the difference
> between a valid printed-on-package-id and an ACPI offset? We'd still
> have to maintain additional state to determine if it's valid or not,
> so we could just maintain a mapping instead.
> 

x86 may have a architectural way to obtain it and hence they don't need
to rely on PPTT. But for ARM, we need to rely on PPTT for it and if
vendors/users need accurate information, it has to come from PPTT and
any other place is never going to be consistent and hence unusable.
So, even though specification doesn't mandate, I think OS should as it's
the only robust way. We can get the firmware fixed/updated if random
unique number hurts. Firmware is not upgradeable is no longer a valid
argument.

-- 
Regards,
Sudeep
