From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 24 Oct 2013 12:10:33 -0700
Subject: [PATCH 4/8] input: Remove OOM message after input_allocate_device
In-Reply-To: <1382640339.22433.73.camel@joe-AO722>
References: <cover.1382555436.git.joe@perches.com>
 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
 <20131024183707.GA5281@core.coreip.homeip.net>
 <1382640339.22433.73.camel@joe-AO722>
Message-ID: <20131024191032.GA5553@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 11:45:39AM -0700, Joe Perches wrote:
> On Thu, 2013-10-24 at 11:37 -0700, Dmitry Torokhov wrote:
> > Hi Joe,
> > 
> > On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> > > Emitting an OOM message isn't necessary after input_allocate_device
> > > as there's a generic OOM and a dump_stack already done.
> > 
> > No, please don't. The kzalloc may get changed in the future to not dump
> > stack (that was added originally because not everyone was handling OOM
> > properly, right?), input core might get changed to use something else
> > than kzalloc, etc, etc.
> > 
> > The majority of errors use dev_err so we also get idea what device
> > failed (if there are several), and more.
> 
> I think that's not valuable as input_allocate_device already has
> dozens of locations that don't emit a specific OOM and centralizing
> the location for any generic message would work anyway.

Not having diagnostic messages in some of the drivers is hardly a
justification to remove them from everywhere else.

-- 
Dmitry
