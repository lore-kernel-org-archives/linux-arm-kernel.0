From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Jun 2013 23:33:21 +0200
Subject: [PATCH 5/8] arm: mvebu: don't hardcode a physical address in
 headsmp.S
In-Reply-To: <alpine.LFD.2.03.1306051637020.18597@syhkavp.arg>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.03.1306051637020.18597@syhkavp.arg>
Message-ID: <20130605233321.5936fcca@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas Pitre,

On Wed, 05 Jun 2013 16:42:20 -0400 (EDT), Nicolas Pitre wrote:

> You may simplify the above like this:
> 
> 	adr	r0, 1f
> 	ldr	r1, [r0]
> 	ldr	r0, [r0, r1]
> 	...,
> 1:	.long	coherency_phys_base - .

Ok, thanks, will try this. Note that the piece of code I've used was
shamelessly copied from other headsmp.S implementations, such as
plat-versatile, mach-ux500, mach-prima2 and mach-msm.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
