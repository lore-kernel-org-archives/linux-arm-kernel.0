From: sam@ravnborg.org (Sam Ravnborg)
Date: Fri, 24 Aug 2018 17:52:46 +0200
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180824102233.73852596@bbrezillon>
References: <20180812184152.GA22343@ravnborg.org>
 <20180824102233.73852596@bbrezillon>
Message-ID: <20180824155246.GB26678@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris.

> > 
> > Both devices are supported today by the atmel_lcdfb driver.
> > For this new set of drivers the compatible strings was
> > selected to avoid clash with the existing compatible
> > strings used for the atmel_lcdfb driver to allow them
> > to co-exist.
> 
> Hm, I think Rob commented on that already, but we usually try to stay
> compatible with the exisiting/old bindings when introducing a new one.
> Don't know how feasible this is in this particular case though.
I v2 I am working with a backward compatible
approach. This is better that what I cam up with initially.

> > The DRM implementation has a few shortcomings compared to the
> > existing fbdev based driver:
> >     - STN displays are not supported
> >             Binding support is missing but most of the
> >             STN specific functionality is otherwise ported
> >             from the fbdev driver.
> >             I assume the info should come from the panel
> >             but as I lack HW I have not looked too much
> >             into what is required.
> >     - gamma support is missing
> >             The driver utilises drm_simple_kms_helper and
> >             this helper lacks support for setting up gamma.
> >             If this is useful please let me know and I
> >             will extend drm_simple_kms_helper to support this
> >             and update the driver.
> 
> I guess you can skip that for now.
Also based on feedback from Nicholas the STN parts will be dropped in v2.
For the gamma stuff this looks feasible with a small extension
to drm_simple_kms_helper - but I dunno if this is something that
userspace will actually use.
So that will wait until there is some good reason to implement it,
and I know how to test it too.

> 
> >     - modesetting is not checked (see TODO in file)
> >             Is this required for such a simple setup?
> 
> Well, that's always better if you can check that the requested display
> mode is supported before trying to apply it.
I will try to cook up something, have learned a little since posting v1.

> 
> >     - support for extra modes as applicable (and lcd-wiring-mode)
> 
> Peter already suggested something I think.
Yep, plenty of links to read.

	Sam
