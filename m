From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 21 Mar 2017 12:11:05 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170317102410.18c966ae@vento.lan>
References: <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170317114203.GZ21222@n2100.armlinux.org.uk>
 <44161453-02f9-0019-3868-7501967a6a82@linux.intel.com>
 <20170317102410.18c966ae@vento.lan>
Message-ID: <20170321111104.GA22939@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Making use of the full potential of the hardware requires using a more
> > expressive interface. 
> 
> That's the core of the problem: most users don't need "full potential
> of the hardware". It is actually worse than that: several boards
> don't allow "full potential" of the SoC capabilities.

Well, in kernel we usually try to support "full hardware" potential.

And we are pretty sure users would like to take still photos, even if
common v4l2 applications can not do it.

> > That's what the kernel interface must provide. If
> > we decide to limit ourselves to a small sub-set of that potential on the
> > level of the kernel interface, we have made a wrong decision. It's as
> > simple as that. This is why the functionality (and which requires taking
> > a lot of policy decisions) belongs to the user space. We cannot have
> > multiple drivers providing multiple kernel interfaces for the same hardware.
> 
> I strongly disagree. Looking only at the hardware capabilities without
> having a solution to provide what the user wants is *wrong*.

Hardware manufacturers already did this kind of research for us. They
don't usually include features noone wants...

> Another case: the cx25821 hardware supports 12 video streams, 
> consuming almost all available bandwidth of an ePCI bus. Each video 
> stream connector can either be configured to be capture or output, in
> runtime. The hardware vendor chose to hardcode the driver to provide
> 8 inputs and 4 outputs. Their decision was based in the fact that
> the driver is already very complex, and it satisfies their customer's 
> needs. The cost/efforts of make the driver to be reconfigured in
> runtime were too high for almost no benefit.

Well, it is okay to provide 'limited' driver -- there's possibility to
fix the driver. But IMO it is not okay to provide 'limited' kernel
interface -- because if you try to fix it, you'll suddenly have
regressions.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/42dc569f/attachment.sig>
