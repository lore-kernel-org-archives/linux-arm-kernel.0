From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Sep 2012 21:37:07 +0300
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <87sjaldcjp.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <20120912131615.GB16547@pengutronix.de>
 <87pq5quaqr.fsf@deeprootsystems.com>
 <87wqzysuu3.fsf@deeprootsystems.com>
 <87sjaldcjp.fsf@deeprootsystems.com>
Message-ID: <20120913183705.GA17430@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 13, 2012 at 11:04:42AM -0700, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >
> [...]
> 
> >> Sorry to be late to the party (again), but still catching up after some
> >> time off.
> >>
> >> Unfortunately, this series causes PM regressions on several OMAP
> >> platforms.  I hope we can hold off on this until those issues are
> >> addressed.
> >
> > I tracked the regression down to [PATCHv8 21/22] (see reply there.)
> >
> > Since this series is already merged, I suggest that the problem patch be
> > reverted, at least for v3.7 and until the problem is better understood
> > and tested.
> >
> > With that patch reverted, all my PM tests are passing.  Feel free to
> > add:
> 
> OK, the i2c series is off the hook.
> 
> Felipe and I spent a little time tracking this down.  Felipe suggested
> that there might be a driver with periodic i2c activity keeping I2C
> awake, and thus preventing CORE retention.  He was right.

FYI, the original idea came from Shubhro. We agreed that would be the
only way i2c would be prevented from idling.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/df783ae7/attachment-0001.sig>
