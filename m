From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Jun 2013 09:18:27 +0200
Subject: [PATCH 3/5] of: net: introduce a of_set_mac_address() helper
 function
In-Reply-To: <20130605071354.GW8681@lunn.ch>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130605071354.GW8681@lunn.ch>
Message-ID: <20130605091827.603c9315@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 5 Jun 2013 09:13:54 +0200, Andrew Lunn wrote:

> The semantics is a bit odd here for a set function. Only set if not
> already set. From the function name, its not clear it has this extra
> semantics. of_set_if_not_set_mac_address() seems a bit long, but makes
> it clearer. Or maybe of_set_default_mac_address()?
> 
> I've no strong preference here, i just see the potential for bugs.

Yes, I agree that a set function that doesn't always set is not
entirely nice, but the part I wanted to get reviewed and hopefully
accepted is PATCH 2/5. If that gets accepted, then I'm all open to
suggestions to improve this PATCH 3/5 by either renaming the function
to a more appropriate name, or change its behavior, depending on
reviewers suggestions.

Maybe of_set_mac_address() should simply be setting it, and callers are
responsible for checking with of_get_mac_address() first if no MAC
address is already set?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
