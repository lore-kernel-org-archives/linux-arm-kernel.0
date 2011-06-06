From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon,  6 Jun 2011 14:52:23 +0100
Subject: [PATCH 0/2] pxa2xx viper glue code fix + trizeps irrelevant ifdef
	removal.
Message-ID: <1307368345-13445-1-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch looks like a simple bug.
The second removes an ifdef that doesn't do anything.

I was looking through this code with a vague view to simplifying it.
Why do pxa2xx and sa1100 require lots of platform glue when others
subarches do not?

On the second one, it looks to me like all those ifdefs could be
trivially removed.

Otherwise, a lot of these bits of glue code could be greatly reduced
by introducing a few default functions and const structures.  Anyone
bored enough to do it?

I might carry on dabbling if people familiar with all these boards
are happy to review.

Jonathan


Jonathan Cameron (2):
  pxa2xx viper: pcmcia - free gpios on exist rather than requesting
    them again.
  pxa2xx trizeps4: pcmcia remove unnecessary ifdefs

 drivers/pcmcia/pxa2xx_trizeps4.c |    4 ----
 drivers/pcmcia/pxa2xx_vpac270.c  |    4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
1.7.3.4
