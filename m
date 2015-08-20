From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Aug 2015 22:26:39 +0200
Subject: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
In-Reply-To: <87lhd568sb.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259A1.6090102@tul.cz>
 <87lhd568sb.fsf@belgarion.home>
Message-ID: <2889798.x6xcIzdYMU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 August 2015 21:48:20 Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> > +     mdelay(3);
> Okay, there are several mdelay(3) in this file.
> 
> Could you please test if removing these mdelays prevents the camera from working
> ? If not, I'd like to have them removed.
> 
> 

FWIW, it might be possible to replace some of them with msleep() calls,
potentially after replacing spinlocks with mutexes where necessary.

	Arnd
