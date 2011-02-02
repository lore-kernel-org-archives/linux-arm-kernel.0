From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 2 Feb 2011 14:40:55 -0700 (MST)
Subject: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
In-Reply-To: <30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com>
	<30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102021430460.7672@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Feb 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul at pwsan.com]
> > Sent: Tuesday, February 01, 2011 4:44 AM
> >
> > What does the hardware do when the powerdomain is programmed to
> > INACTIVE?
> > Does it actually force the clockdomains idle?
> 
> No. It doesn't force it. The power domain to hit INACTIVE, the
> clockdomain within the power domain needs to idle and it is
> still a prerequisite. With INACTIVE being programmed, we could
> issue a sleep transition.
> 
> PD_ON:
> No power transition, only clocks are gated. Power domain stays ON.
> 
> PD_INA:
> Power domain transitions to INACTIVE state. All logic and
> memory stay powered. This state allows for a voltage
> sleep transition.

Okay.  So programming an OMAP4 powerdomain to INACTIVE is equivalent to 
programming an OMAP3 powerdomain to ON with the PRM_VOLTCTRL.AUTO_SLEEP 
bit to 1?

Are there any other dependencies with the PRM_VOLTCTRL_AUTO_CTRL_VDD* 
registers, e.g., does the appropriate VDD bitfield there need to be set to 
0x1 also to allow the sleep transition to occur?



- Paul
