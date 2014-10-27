From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Oct 2014 16:12:26 +0100
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <20141027145939.GD12627@lunn.ch>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024142044.GB3142@lunn.ch>
 <20141024162824.67f9ce3d@free-electrons.com>
 <20141024145119.GD3142@lunn.ch>
 <20141027135129.292bd882@free-electrons.com>
 <20141027141958.GB12627@lunn.ch>
 <20141027154049.583e4cd2@free-electrons.com>
 <20141027145939.GD12627@lunn.ch>
Message-ID: <20141027161226.199cca96@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 27 Oct 2014 15:59:39 +0100, Andrew Lunn wrote:

> > Right. But for existing notifier chains, the existence, semantic and
> > meaning of the parameters are already defined, and the gazillions users
> > of that notifier chain in the kernel rely on those parameters to not
> > change.
> 
> That is not really true. Lets start off with:
> 
> https://lkml.org/lkml/2014/10/21/56
> 
> This is brand new code, implementing the poweroff handler call chain.
> Take a look at do_kernel_power_off(). It passes a NULL pointer as the
> parameter to the handler function. So there are not gazillions users
> of that notifier chain in the kernel rely on those parameters to not
> change.

Ok now I understand why I didn't see it. This code is not in mainline.
And actually, it doesn't seem to be close from hitting mainline when
reading the reaction of Rafael Wysocki on the main patch:

"""
Well, I must admit to having second thoughts regarding this particular
mechanism.  Namely, notifiers don't seem to be the best way of
expressing what's needed from the design standpoint.
"""

So I'm a bit reluctant to create a dependency of the Armada XP
suspend/resume code to a very large unmerged patch series that doesn't
seem to even be close of having a consensus amongst the maintainers.

Isn't this something we can rework afterwards once the poweroff
discussion has settled? I wouldn't mind declaring the particular
aspects of the DT bindings related to the PIC GPIOs as "staging", so
that we keep the freedom to change them for a few kernel releases until
we settle on the final solution for that.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
