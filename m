From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon,  6 Jun 2011 15:24:12 +0100
Subject: [PATCH 0/3 V2] pxa2xx pcmcia - vpac glue code fix and trizeps cleanup.
Message-ID: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2 - actually put the right device name in the patch titles (thanks Marc)
     add some more trivial cleanup to trizeps (patch 3)

Original message:

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


Jonathan Cameron (3):
  pxa2xx vpac: pcmcia - free gpios on exist rather than requesting them
    again.
  pxa2xx trizeps4: pcmcia remove unnecessary ifdefs
  pxa2xx trizeps4 pcmcia: code cleanup

 drivers/pcmcia/pxa2xx_trizeps4.c |   95 +++++++++++++++++--------------------
 drivers/pcmcia/pxa2xx_vpac270.c  |    4 +-
 2 files changed, 46 insertions(+), 53 deletions(-)

-- 
1.7.3.4
