From: drjones@redhat.com (Andrew Jones)
Date: Fri, 29 Jun 2018 19:03:34 +0200
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
 <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
Message-ID: <20180629170334.3ab7ngru3abxcobf@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 11:48:15AM -0500, Jeremy Linton wrote:
> Just to be clear, there isn't anything (AFAIK) in the ACPI specification
> which dictates what values should comprise the various ACPI id's. They are
> assumed only to be machine readable, which is why it seems some
> implementations are just using a sanitized version of mpidr for the
> core/MADT acpi id. That is why simply using the id flagged as valid in a
> PPTT node doesn't necessarily give you a more human readable value.

I didn't expect them to be sequential integers, but I was starting to see
value in them anyway if they were expected to be some something stamped on
the socket.

> 
> If you want a human readable socket identifier that matches something
> stamped above the socket, that is what SMBIOS is for. Queue discussion about
> that tables reliability for functional ids. Either way, as the spec is
> written today (or any ECRs I've seen), your definitely not going to get both
> nice socket1, socket2, and cpu1, cpu2 out of the same PPTT/ACPIid name-space
> since the numerical id's conflict.
> 

If we don't expect the ACPI processor ID to be something useful to users,
then I'll revert back to lobbying for counters, as those arbitrary numbers
can't be less useful than arbitrary offsets and ACPI IDs, and, IMO, are
more likely to make users/user apps happy.

Thanks,
drew
