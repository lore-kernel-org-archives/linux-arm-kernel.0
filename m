From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 2 Apr 2015 08:17:40 +0200
Subject: [PATCH v3 00/13] Krait clocks + Krait CPUfreq
In-Reply-To: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
References: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150402061740.GA23963@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Fri 2015-03-20 23:45:19, Stephen Boyd wrote:
> These patches provide cpufreq scaling on devices with Krait CPUs.
> In Krait CPU designs there's one PLL and two muxes per CPU, allowing
> us to switch CPU frequencies independently.
> 
> 				 secondary
> 	 +-----+                    +
> 	 | QSB |-------+------------|\
> 	 +-----+       |            | |-+
> 		       |    +-------|/  |
> 		       |    |       +   |
> 	 +-----+       |    |           |
> 	 | PLL |----+-------+           |   primary
> 	 +-----+    |  |                |     +
> 		    |  |                +-----|\       +------+
> 	 +-------+  |  |                      | \      |      |
> 	 | HFPLL |----------+-----------------|  |-----| CPU0 |
> 	 +-------+  |  |    |                 |  |     |      |
> 		    |  |    | +-----+         | /      +------+
> 		    |  |    +-| / 2 |---------|/
> 		    |  |      +-----+         +
> 		    |  |         secondary
> 		    |  |            +
> 		    |  +------------|\
> 		    |               | |-+
> 		    +---------------|/  |   primary
> 				    +   |     +
> 					+-----|\       +------+
> 	 +-------+          v                 | \      |      |
> 	 | HFPLL |----------------------------|  |-----| CPU1 |
> 	 +-------+          |                 |  |     |      |
> 			    | +-----+         | /      +------+
> 			    +-| / 2 |---------|/
> 			      +-----+         +

Nice ascii art :-). There should be "+" at place marked by "v" :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
