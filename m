From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Dec 2011 13:25:07 -0800
Subject: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power,
 clock & HWMOD data
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20111207212507.GM31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [111120 08:44]:
> 
>  34 files changed, 7525 insertions(+), 15 deletions(-)

Clearly we can't merge this amount of static SoC specific
hwmod/mux data after the all that's been discussed over
this year.

We just have to have a better way of doing this.

For now, we already have the SoC specific init functions
available, so I suggest taking a hard look how to dynamically
allocate these data structures and populate them with the
SoC specific init functions.

Then later on we may be able to pass some of the data such
as module base addresses from device tree. But I'm guessing
that the SoC specific inits should already squeeze this down
into something tolerable.

Regards,

Tony
