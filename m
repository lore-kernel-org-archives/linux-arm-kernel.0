From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 00:29:28 +0000
Subject: [PATCH 00/15] new locomo driver
In-Reply-To: <20141028001338.GZ27405@n2100.arm.linux.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <20141028001338.GZ27405@n2100.arm.linux.org.uk>
Message-ID: <20141028002928.GK18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 12:13:39AM +0000, Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 03:01:53AM +0300, Dmitry Eremin-Solenikov wrote:
> > Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
> > drivers present in Linux kernel has some problems:

> >  * It uses custom bus instead of platform bus/mfd core.

> I believe Greg wouldn't see that as a positive point.

> Don't think that the platform bus _should_ always be used.  It shouldn't
> (Greg has said he'd like to see the platform bus to be totally killed off.)
> Instead, custom buses properly suited to the class of device in question
> is much preferred, especially if it aids in...

> >  * Device drivers are not well layered/separated.

> ... better layering or separation of drivers.

> So, thinking that converting from a custom bus to a platform bus
> definitely is /not/ a positive step forward.

> (Why mfd was ever allowed to re-use the platform bus stuff is a separate
> question not relevent to these patches.)

The reason we ended up reusing the platform bus so much was that
originally people were doing custom buses but people started complaining
that the code was (or should be) a cut'n'paste of the platform bus and
that this duplication was both not pretty and a bit tedious for anyone
doing anything that involved deploying good practice over a lot of
buses.  Early MFDs were actually MMIO devices so the platform bus was a
good fit, then people (including me when I upstreamed the wm97xx drivers
and apparently whoever worked on these devices) started adding custom
buses and then people complianed that we should reuse both the bus type
and the MFD infrastructure so here we are.

Probably a way of sharing the platform code but giving the bus another
name and bus_type would allow for better separation here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/906c7809/attachment.sig>
