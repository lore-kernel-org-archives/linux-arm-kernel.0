From: jrnieder@gmail.com (Jonathan Nieder)
Date: Sat, 1 Sep 2012 23:30:55 -0700
Subject: When to cc stable@vger.kernel.org (Re: [PATCH v2] ARM: Build dtb
 files in all target)
In-Reply-To: <20120901201105.GD24085@n2100.arm.linux.org.uk>
References: <20120830183711.GY19437@titan.lakedaemon.net>
 <20120830191412.GC18957@n2100.arm.linux.org.uk>
 <1346447515.13980.19.camel@deadeye.wl.decadent.org.uk>
 <20120831223219.GA6906@n2100.arm.linux.org.uk>
 <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
 <20120901152544.GB24085@n2100.arm.linux.org.uk>
 <20120901163235.GB748@mannheim-rule.local>
 <20120901182207.GC24085@n2100.arm.linux.org.uk>
 <20120901183859.GA958@mannheim-rule.local>
 <20120901201105.GD24085@n2100.arm.linux.org.uk>
Message-ID: <20120902063055.GA1608@mannheim-rule.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
(out of order for convenience)

> Okay, if you think it's clear, then you tell me where in this text,
> which is a direct quote from the stable_kernel_rules.txt document:
[...]
> it gives you permission to send a patch to the stable team email address
> _without_ the commit ID.  Note carefully the sentence which starts "You

Right here:

[...]
> |  - To have the patch automatically included in the stable tree, add the tag
> |      Cc: stable at vger.kernel.org
> |    in the sign-off area. Once the patch is merged it will be applied to
> |    the stable tree without anything else needing to be done by the author
> |    or subsystem maintainer.

If the tag "Cc: stable at vger.kernel.org" is in the sign-off area, you
may cc the stable@ list or not.  By justifying your change clearly and
putting that tag in the sign-off area, you have done your job.
Anything beyond that is completely up to you.

That means:

> In which case, why did Greg reply with his standard form email telling
> Jason to read the stable_kernel_rules.txt document when Jason added the
> Cc to his email?

Because the "cc: stable" line was not in the sign-off area.

Perhaps an extra sentence in stable_kernel_rules.txt would help.
E.g.,

    In this case, you may cc the stable at vger.kernel.org list when
    submitting your patch to keep the stable tree maintainers
    informed of the resulting discussion, but that is not required.
    Once the patch is merged it will be applied to the stable tree
    without anything else needing to be done by the author or
    subsystem maintainer.

Thanks,
Jonathan
