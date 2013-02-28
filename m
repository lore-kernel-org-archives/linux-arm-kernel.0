From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Feb 2013 16:14:26 +0000
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
In-Reply-To: <512E41A7.9040700@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
 <20130227171830.GD22286@mudshark.cambridge.arm.com>
 <512E41A7.9040700@gmail.com>
Message-ID: <20130228161426.GG32130@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 05:25:59PM +0000, Rob Herring wrote:
> On 02/27/2013 11:18 AM, Will Deacon wrote:
> > On Wed, Feb 27, 2013 at 03:42:04AM +0000, Rob Herring wrote:
> >> Will, I'm using the id field to specify system level events which are
> >> highbank specific. I worry that the id field will be abused for things
> >> that could be standardized. Having standard PSCI calls for reset and
> >> poweroff would avoid this for highbank.
> > 
> > I don't like using the ID field for this because it places some of the
> > number space in the device tree binding and other parts in the platform
> > code. It might be better to use the bottom 16 bits of the power_state
> > argument to CPU_OFF (which are designated as platform specific anyway) to
> > indicate that you actually want a system-wide operation to take place.
> 
> The platform specific ID in the power state field of CPU_OFF is what I'm
> using. But there is no reason for this to be platform specific when
> possibly all platforms need this.

Yes, sorry, I misread your description above and assumed you were referring
to the *function* ID.

> > Since this document is currently undergoing a fairly major update (which
> > will hopefully be released soon), I'll go and check with the authors to see
> > if they have already considered this.
> 
> It would be nice to have some visibility to this as this is an ABI and
> will break if things change.

As long as things are versioned sensibly, we just don't pretend to be
compatible with versions of the ABI that we don't support; otherwise PSCI
would be unable to evolve as a specification. The main thing is to avoid
implementing features as platform-specific parts when an upcoming version of
the specification actually describes them in a different way.

We should talk more about this at Connect, where hopefully some other
platforms can be converted too.

Will
