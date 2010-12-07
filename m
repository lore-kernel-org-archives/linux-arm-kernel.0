From: tim.sander@hbm.com (Tim Sander)
Date: Tue, 7 Dec 2010 13:56:16 +0100
Subject: generic irq handler and stack?
In-Reply-To: <20101207104116.GA20264@n2100.arm.linux.org.uk>
References: <201012071129.26211.tim.sander@hbm.com>
	<20101207104116.GA20264@n2100.arm.linux.org.uk>
Message-ID: <201012071356.16281.tim.sander@hbm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> > The interrupt handling on the i.mx35x seems to handle only one interrupt
> > at a time. This generates larger then nessecary interrupt jitter. I am
> > currently investigating to reprogram the AVIC to enable higher priority
> > interrupts to interrupt lower priority interrupts. The mechanism is
> > outlined in section 13,3.8 of the IMX35 Reference Manual.
> 
> The kernel now runs _all_ interrupts with IRQs masked on the CPU.  See
> e58aa3d2d0cc01ad8d6f7f640a0670433f794922.
Thanks Russell for your  quick answer. But as far as i understand this is only
one step to get better interrupt latency on i.mx35x since the AVIC by default
only allows one interrupt at a time. So any idea which is the cleanest way to 
push the SPSR_irq register on the stack. I am currently a little lost between 
the common code, the arm and platform specific code, so any hint is welcome.

Thanks
Tim

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich f?r den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
