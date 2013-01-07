From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jan 2013 11:06:55 +0000
Subject: [PATCH 2/4] ALSA: pxa27x: fix ac97 warm reset bug work-around code
In-Reply-To: <50EA9607.7050408@compulab.co.il>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-3-git-send-email-mikedunn@newsguy.com>
 <50EA9607.7050408@compulab.co.il>
Message-ID: <20130107110655.GB3222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 11:31:51AM +0200, Igor Grinberg wrote:
> On 01/06/13 21:13, Mike Dunn wrote:
> > +/* these enable a work-around for a hw bug in pxa27x during ac97 warm reset */
> > +#define GPIO113_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH)
> > +#define GPIO95_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH)
> 
> Do we really need to change the LPM? Because DRIVE_* only affect LPM.

Also, be very careful about driving output pins to peripherals high
during sleep modes, especially if the peripherals are powered down.
If they are powered down, you will drain power through the output
into the peripheral to the extent that you _can_ cause it to remain
partially powered up.
