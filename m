From: mporter@linaro.org (Matt Porter)
Date: Tue, 11 Mar 2014 18:15:58 -0400
Subject: ARM: mach-bcm dt updates for 3.15
In-Reply-To: <20140311202534.GH31877@quad.lixom.net>
References: <20140306063605.GA30045@beef>
 <20140311202534.GH31877@quad.lixom.net>
Message-ID: <20140311221558.GN25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 01:25:34PM -0700, Olof Johansson wrote:
> On Thu, Mar 06, 2014 at 01:36:05AM -0500, Matt Porter wrote:
> > The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:
> > 
> >   Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/dt
> > 
> > for you to fetch changes up to a33705ee8a8af40bbaa379e4567ca451c38fc0d6:
> > 
> >   ARM: dts: remove bcm11351-brt.dts (2014-03-05 01:28:56 -0500)
> > 
> > ----------------------------------------------------------------
> > ARM: mach-bcm dt updates for 3.15
> > 
> > - add BCM4708 dt support
> > - remove bcm11351-brt
> > - bcm281xx common clock support
> 
> Merged, but I thought you said that the driver peices of common clock
> were a prereq for the DT changes? I didn't see this branch based on the
> driver changes. The only way to guarantee that the driver changes are
> applied before the DT ones are at all times is to base the two branches
> on each other (I.e.  otherwise you might land on a location where only
> the DT change is applied when you bisect).

Yes, that's correct...and, ok I see now.

> This isn't super-critical in this case; the only person subjected to
> this problem right now is likely you, so I've merged it anyway. Keep
> it in mind in the future though -- it's one of the quirks of git that
> takes a while to get used to.

Ok, understood, I'll be sure to properly base these in the future. I
have an upcoming similar case with a second soc pull request that will
be based on both cleanups and soc that will do it correctly, hopefully.

Thanks,
Matt
