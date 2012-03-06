From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 15:38:11 +0000
Subject: [PATCH v3 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120303193249.GA22021@avionic-0098.mockup.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <20120223160420.GA9899@avionic-0098.mockup.avionic-design.de>
 <20120303193249.GA22021@avionic-0098.mockup.avionic-design.de>
Message-ID: <201203061538.11709.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 March 2012, Thierry Reding wrote:
>   * Thierry Reding wrote:
> > * Arnd Bergmann wrote:
> > > On Thursday 23 February 2012, Thierry Reding wrote:
> > > > > Is this only used for the device tree functions? If so, I would recommend
> > > > > making it less generic and always search for a device node.
> > > > 
> > > > It is currently only used to look up a struct pwm_chip for a given struct
> > > > device_node, yes. But I can see other uses for this. For instance this could
> > > > be useful if we ever want to provide an alternative way of requesting a PWM
> > > > on a per-chip basis.
> > > 
> > > Nah, just keep it simple for now. If we need it later, we can still
> > > add something like this back, but for now it's just a source of
> > > confusion and possible bugs.
> > 
> > Will do.
> 
> I turns out that this is not as easy to do as I thought. The problem is that
> if I remove the pwmchip_find() from the core and move the lookup
> functionality into the OF support code I no longer have access to the list of
> PWM chips. So I guess it will have to stay in to keep things encapsulated
> properly.

Well, or you move everything into the one file. If you have the device tree
support function in the same file as everything else, you no longer need
the additional complexity.

	Arnd
