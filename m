From: tim.sander@hbm.com (Tim Sander)
Date: Tue, 7 Dec 2010 11:29:26 +0100
Subject: generic irq handler and stack?
Message-ID: <201012071129.26211.tim.sander@hbm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

The interrupt handling on the i.mx35x seems to handle only one interrupt at a 
time. This generates larger then nessecary interrupt jitter. I am currently 
investigating to reprogram the AVIC to enable higher priority interrupts to 
interrupt lower priority interrupts. The mechanism is outlined in section 
13,3.8 of the IMX35 Reference Manual.

I thought about implementing the reprogramming of the AVIC in the 
ack() and end() callbacks. The problem is that i need to push the current 
priority on the stack but that doesn't seem to be possible with the generic 
irq subsystem? Do i need to implement the whole irq handler or is there some 
other way?

Thanks
Tim

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
