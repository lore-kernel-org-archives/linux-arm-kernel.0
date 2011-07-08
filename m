From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 08 Jul 2011 19:30:26 +0400
Subject: [PATCH] DaVinci: correct MDSTAT_STATE_MASK
In-Reply-To: <201107081924.57577.sshtylyov@ru.mvista.com>
References: <201107081924.57577.sshtylyov@ru.mvista.com>
Message-ID: <4E172292.6090600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

I wrote:

> MDSTAT.STATE occupies bits 0..5 according to all available documentation, so fix
> the #define MDSTAT_STATE_MASK at last. Using the wrong value seems to have been
> harmless though...

    Except maybe sleep.S -- davinci_ddr_psc_config() could exit too early when 
disabling DDR clock. The same is true with davinci_psc_config() in general but I 
don't think that anything depended on its timely return in that case.

> This was noticed by me back in 2009 but I didn't follow up with the patch back
> then... :-/

    Shame on me. :-)

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
