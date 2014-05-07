From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 14:15:01 -0500
Subject: [RFC PATCH 1/5] watchdog: Add API to trigger reboots
In-Reply-To: <536A2EAB.4000605@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
 <1398958893-30049-2-git-send-email-linux@roeck-us.net>
 <20140503012243.GG4090@lukather>
 <20140503042925.GB5882@roeck-us.net>
 <1399463549.4536.10.camel@weser.hi.pengutronix.de>
 <536A2EAB.4000605@roeck-us.net>
Message-ID: <20140507191501.GA7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 06:01:31AM -0700, Guenter Roeck wrote:
> >This means we could have multiple watchdogs in the system, where we
> >really want a specific one (maybe designated through a DT property) to
> >do the reset. This isn't compatible with the "last watchdog that
> >registers a handler wins the system reset" logic in your patch.
> >
> 
> Wouldn't the order in which watchdogs are configured in dt define that ?
> The last one wins.

It doesn't work, because the DT nodes are usually ordered by physical
address.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/9e08ff51/attachment.sig>
