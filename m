From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 16:48:12 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120822115524.GA18545@gmail.com>
References: <20120820175155.GH26991@opensource.wolfsonmicro.com>
 <20120821085618.GA26899@gmail.com>
 <20120821095026.GU26991@opensource.wolfsonmicro.com>
 <20120821105413.GD26899@gmail.com>
 <20120821110329.GA7995@opensource.wolfsonmicro.com>
 <20120821120243.GF26899@gmail.com>
 <20120821165207.GX7995@opensource.wolfsonmicro.com>
 <20120822081746.GA4089@gmail.com>
 <20120822111913.GG7995@opensource.wolfsonmicro.com>
 <20120822115524.GA18545@gmail.com>
Message-ID: <20120822154812.GK7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 12:55:25PM +0100, Lee Jones wrote:

> > I *have* asked you to communicate more clearly about what you're doing
> > but that doesn't mean to stop sending code, it means to have clearer
> > words around what you're sending. 

> That's not how I interpreted your words:

> "What you can do here is to commmunicate about what you're doing more.
> Don't just think about the code, think about the communication
> surrounding the code - this is the core of the issue."

Just to be clear I'd include things like commit messages, cover letters
and so on in the general area of communication.

> I think it's great that you like the idea and want to extend that
> functionality to other MFDs which perhaps don't support DT, or the
> ones that do but don't want to provide compatible strings or device
> nodes for all the MFD's child devices. But that is all we're doing
> here. There was no breakage. It served a purpose and it worked well.
> So well in fact that you've now provided the intended functionality
> to other devices.

I'm looking at this from the point of view of adding the compatible
strings and then finding that the core starts remapping things in the
case where you're probing from DT - and this behaviour will vary
depending on the device tree that the user is using so the driver can't
even make a decision based on if device tree is being used by the
system.

> You only noticed it 2 days ago and I had a patch ready to go yesterday.
> I'm confused because I don't understand why would you even complain about
> it if you intended to work on it yourself? Surely, "Ah, I see an issue with
> xyz, patch to follow." Would have been more appropriate, instead of 
> complaining about it, then I go and waste my time trying to fix something
> you intend on fixing yourself.

I didn't originally intend to do anything, if I had done I'd just have
sent a patch as you say.  Originally I'd just noticed it as being an
awkwardly designed interface at the wrong abstraction layer, it was only
later on that I realised how it could blow up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/d3e74d63/attachment-0001.sig>
