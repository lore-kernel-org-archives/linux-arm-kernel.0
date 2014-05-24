From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 24 May 2014 16:13:37 +0400
Subject: [PATCH] acornscsi: remove linked command support
In-Reply-To: <538075E0.4080001@suse.de>
References: <1400926433.31526.89.camel@x220> <538075E0.4080001@suse.de>
Message-ID: <1400933617.6956.34.camel@dabdike.int.hansenpartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-05-24 at 12:35 +0200, Hannes Reinecke wrote:
[...]
> I'm all for it. Removing never-really-implemented feature on obsolete 
> hardware is always a good idea.
> 
> Acked-by: Hannes Reinecke <hare@suse.de>

Wait, no, that's not a good idea.  We leave obsolete drivers to bitrot.
Particularly we try not to touch them unless we have to because there
might be a few people still using them and the more we tamper, the
greater the risk that something gets broken.  On that principle, since
there's no real reason to remove the code, it should stay ... until the
whole driver bitrots to the extent that we can no-longer compile it.

However, I'll do this if the Maintainer (rmk) acks ... because if it
breaks he gets to fix it.

James
