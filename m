From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 12 Sep 2012 17:11:13 -0700
Subject: [PATCH 7/7] ARM: OMAP2+: PM: reorganize the powerdomain API in
 public and private parts
In-Reply-To: <1347443732-7411-8-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 12 Sep 2012 11:55:32 +0200")
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
 <1347443732-7411-8-git-send-email-j-pihet@ti.com>
Message-ID: <87r4q6rdcu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> The newly added code for functional power states re-defines the
> API to query and control the power domains settings.
>
> The API is now split in the following parts in powerdomain.h:
> - the public or external API, to be used by external PM components:
>   cpuidle, suspend, pmxxxx, clock* etc.
> - the private or internal API, to be used by the low level PM code
>   only: powerdomain*, pm-debug, hwmod, voltage, clockdomainxxxx.
>
> The function omap_set_pwrdm_state is not used anymore and so is
> removed.
>
> No functional change is introduced by this patch.
>
> Note: the API reorganization in a public and private header files
> is not part of this patch, this comes as a subsequent clean-up
> patch series.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

In addition to reorganizing the API, I suspect there are a handful of
out-of-tree hacks, er, users, that will are using the internal state
names, as well as the functions that should now only be internal.

As part of the subsequent cleanup series, it would it make sense to add
a '_' prefix to the internal names as well to catch unintentional use of
internal APIs?

Kevin
