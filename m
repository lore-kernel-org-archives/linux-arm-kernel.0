From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 24 Jun 2013 22:28:03 +0200
Subject: [PATCH 08/15] pwm: Add new pwm-samsung driver
In-Reply-To: <8756440.8o3uDlCqg5@flatron>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <24964129.e56nj79VjR@flatron> <20130624195020.GA7163@mithrandir>
 <8756440.8o3uDlCqg5@flatron>
Message-ID: <20130624202802.GC7163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 10:03:12PM +0200, Tomasz Figa wrote:
[...]
> OK. So we just need to prevent people from blindly copying this.
> 
> Wouldn't adding a big comment about why this is enough for this platform 
> and why anything more sophisticated would be just overengineering in this 
> case be enough?

That'd be sugarcoating. I don't think this is a good idea at all and
using a properly encapsulated driver with proper shared API to access
shared registers wouldn't be overengineering in my opinion. It would
in fact be good engineering.

> This driver is already a lot better than previous one, because as opposed 
> to the old one, it gives synchronization that is technically correct. Not 
> even saying about a lot of other things fixed, like multiplatform-
> awareness, OF support, coding style, proper handling of dividers, etc., 
> etc. It would be really bad if all this was put to waste...

I certainly wouldn't want any of this going to waste, and quite frankly
letting you get away with just the comment is already more compromise
than I really like.

The TI drivers used to have a similar problem and I required them to
come up with a good solution. It'd be fair to require the same of you.
But maybe I'm getting soft.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/452894d3/attachment.sig>
