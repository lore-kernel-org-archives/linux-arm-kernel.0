From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Mar 2010 10:18:59 +0000
Subject: [PATCH 2/2] Quick fix for the audio clocks on SAM9-L9261
In-Reply-To: <20100312110241.3d97237b@rechenknecht2k7>
References: <20100312105817.4392b594@rechenknecht2k7>
	<20100312110032.2e57fdce@rechenknecht2k7>
	<20100312110241.3d97237b@rechenknecht2k7>
Message-ID: <20100312101859.GC29306@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 12, 2010 at 11:02:41AM +0100, Benjamin Valentin wrote:
> Signed-off-by: Dimitar Dimitrov <dimitar@olimex.com>

This should be...

> >From 10a85229b2357c89d5170efde5ac0e1cba4c9f9e Mon Sep 17 00:00:00 2001
> From: Dimitar Dimitrov <dimitar@olimex.com>
> Date: Wed, 27 May 2009 08:11:37 +0300
> Subject: [PATCH] Quick fix for the audio clocks on SAM9-L9261
> 
> This patch together with support from SAM9-L9261 hardware fix an issue with
> audio clocks. AT73C213 needs MCLK and BCLK with equal phase. The MCLK from
> AT91SAM9XXX clock output and BCLK from the SSC TK clock output are not
> phase-synchronized. Thus the SAM9-L9261 board provides external hardware
> divison by 8 from MCLK to BCLK, ensuring zero phase difference.
> 
> See: http://www.at91.com/phpbb/viewtopic.php?t=2633

... here.  It's supposed to be part of the commit message.
