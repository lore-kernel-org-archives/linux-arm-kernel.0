From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 18 Dec 2014 13:57:21 +0200
Subject: [PATCH] video/logo: prevent use of logos after they have been freed
Message-ID: <1418903842-22450-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The fbdev logo seems to be rather messed up when deferred probing is happening.
This is a quick fix for the problem.

The code in the logo.c is quite scary, using __init_refok to silence warnings
about accessing __initdata from non-init context.

Another option would be to make the logos not __initdata, but I think that's
not acceptable.

Any ideas for a nicer way to fix this issue?

 Tomi

Tomi Valkeinen (1):
  video/logo: prevent use of logos after they have been freed

 drivers/video/logo/logo.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.2.0
