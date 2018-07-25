From: drjones@redhat.com (Andrew Jones)
Date: Wed, 25 Jul 2018 15:57:33 +0200
Subject: [RFC PATCH 12/16] KVM: arm64/sve: Context switch the SVE registers
In-Reply-To: <20180725115045.GJ4240@e103592.cambridge.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-13-git-send-email-Dave.Martin@arm.com>
 <20180719131338.jsgezassnjhdbotd@kamzik.brq.redhat.com>
 <20180725115045.GJ4240@e103592.cambridge.arm.com>
Message-ID: <20180725135733.wx4eqrp7cyghcigq@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 12:50:45PM +0100, Dave Martin wrote:
> > > +	if (system_supports_sve() && guest_has_sve)
> 
> As elsewhere, the system_supports_sve() check uses a static key and
> should be very cheap (or free in a CONFIG_ARM64_SVE=n kernel).
>

Yup, I'm clear on that now. Thanks again for explaining. It might
be nice for a small helper function in this case in order to avoid
the 'system_supports_sve() &&' everywhere and the chance that the
order of the checks gets swapped during some code refactoring someday.

Thanks,
drew
