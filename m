From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 08 Apr 2015 10:21:47 -0700
Subject: [PATCH 0/7] Fix Keystone 2 physical address switch
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <552563AB.8050308@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 4/8/2015 2:44 AM, Russell King - ARM Linux wrote:
> For some time, the Keystone 2 physical address switch has been
> tainting the kernel ever since we decided that it was not safe.
>
> This series re-works the address switch to be compliant architecturally.
>
Thanks a lot for doing it. Will have a look at the series.

> There's still a niggle in the keystone2 code, where we set the
> arch_virt_to_idmap function pointer in keystone_pv_fixup() - something
> I'd ideally like to avoid.
>
> I'm in two minds about how much of this code should be in SoC specific
> code, and how much should be in generic code - on one hand, I don't
> want to give a green light to this kind of sillyness by encouraging
> it, but I'd rather not end up with multiple implementations of this.
>
Either way you decide, its fine by me. Actually there is just one user
at this point of time but so is the case for the address switch code.
I couldn't come up with more generic than the function pointer last
time.

Regards,
Santosh
