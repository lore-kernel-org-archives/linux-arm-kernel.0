From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 29 Oct 2009 16:05:27 +0100
Subject: [01/02] pxa: add 2d graphics driver
In-Reply-To: <f17812d70910290750r30066c57ta533cf17e37efbc8@mail.gmail.com>
References: <771cded00910280747j2de4984bv43d1ed658c581ce8@mail.gmail.com>
	<20091028145646.GH14091@buzzloop.caiaq.de>
	<f17812d70910290750r30066c57ta533cf17e37efbc8@mail.gmail.com>
Message-ID: <20091029150527.GR14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2009 at 10:50:54PM +0800, Eric Miao wrote:
> > Uh. What's that!? Another one? How is that driver supposed to be used?
> > Is there any userspace reference? And did you see the DirectFB supported
> > version of such a driver I submitted several times already?
> >
> > Sigh. We sould really avoid to have two drivers for the same purpose.
> > Any idea how to solve this?
> >
> 
> I think this is the original version we had in our internal release
> years ago, and released after solving some legal issues now.

Ah, I see.

> From my POV, this isn't really a bad news, at least we have another
> solution which may can be referenced and benefit the final result.
> 
> The problem with this driver I guess is that how other Marvell apps
> depends on this, and it's currently unknown since the API and user-
> space stuffs are not public at the moment. And apparently, the one
> you posted has already included a link to the directfb usage.
> 
> Technically, these drivers are based on samilar ideas, I don't have
> any preference. The real issue is that Marvell should have a look
> into the directfb version, and evaluate if something is missing and
> the effort of porting existing apps over to that driver because
> eventually I'd like to see only one driver there. And vice versa
> from the directfb POV.
> 
> Note I'm neutral on this, and this could be the chance both parties
> look into the solution of the other one, and improve the final
> result. (what I care only is good code ;-)

Hmm, we're actually happy with what we currently got, so unless someone
speaks up and points out bugs or missing features, I don't see why we
will touch the code again in near future.

The reason why we would like to see the DirectFB version mainline is
simply that it's a lot easier for users to use it then and we won't have
to maintain a per-kernel-release patchset to add this functionality.

And, frankly spoken, without a free (at least freely available) library
to actually use the GCU features from applications, the driver itself is
actually pointless.

Maybe the community helps deciding by starting to use our driver and by
giving some feedback :)

Daniel
