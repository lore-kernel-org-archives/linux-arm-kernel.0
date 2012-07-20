From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Jul 2012 12:25:21 -0600 (MDT)
Subject: [RFC 1/4] ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
In-Reply-To: <1342764284-8143-2-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
 <1342764284-8143-2-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1207201222250.14390@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2012, Rajendra Nayak wrote:

> We do not support MPU OSWR on OMAP3. Get rid of the complex/multiple
> save_state handling in omap_sram_idle() and just use 2 save_state
> definitions
> 
> save_state = 1, all logic and memory lost, MPU hits OFF
> save_state = 0, nothing lost, MPU hits CSWR or shallower state
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

The code is certainly simpler, but I recall seeing patchsets in the past 
that implemented OSWR on OMAP3.  (Not sure which powerdomains it was 
implemented for.)  Do you know what the status of those patchsets are?

- Paul
