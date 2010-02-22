From: biswa.nayak@wipro.com (biswa.nayak at wipro.com)
Date: Mon, 22 Feb 2010 14:06:17 +0530
Subject: Interrupt registering for PIO problem in ATMEL chips
Message-ID: <17E4CABDDEE0BC4A9F40814378DEC0CB21EB65@BLR-EC-MBX03.wipro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello List,
I have a strange issue with dealing with interrupts in a ATMEL chip as
described below. 

As per the documentations, the peripherals of my board (custom one based
on AT91SAM9260) are connected to the Advanced Interrupt Controller (AIC)
of the ATMEL chip via the Parallel I/O (PIO) chips. 
Also, PIOs can not distinguish between inputs and interrupts, as they
treat everything as inputs. 

Now, my problem is I am writing this keypad driver, which is connected
to PIOA. 
I am able to read the key press event if I keep reading the PIO lines in
a loop. 

Now, I need to read the key press events in an interrupt handler (but
obvious) How exactly can I install an interrupt handler? 

The PIOA is connected to pin 2 of AIC, but then I can not install the
handler for pin2, It fails saying error -22 ( resource not available).
I also don't know, what I can do even if I get to install the handler
for PIO. 

Can someone guide me in this? Or atleast point to me some driver codes
which handles such situations. 

I would really appreciate some help on this, as I have hit a roadblock
here. 
Please, let me know if you need more info on this.

Thanks
Biswa

Branch of Wipro Limited,
Place of Commercial Register of the Branch: Kiel
Commercial Registration Number of the branch : HRB 7178 KI
VAT registration number - German Tax No:19/294/30609
Company name as Registered in Commercial Register : Wipro Limited (India) Zweigniederlassung Deutschland
Legal form of the Company : Domestic Branch of the Foreign Limited liability Company. 
Company seat: Registered office at Doddakannelli, Sarjapur Road, Bangalore, India : 560 035.
Tel : 91-80-28440011, Fax : 91-80-28440051, website: www.wipro.com
Managing Director : Mr Azim H Premji

 

Zweigniederlassung der Wipro Limited
Registergericht: Kiel
Handelsregisternummer: HRB 7178 KI
Steuernummer: 19/294/30609
Firma laut Handelsregistereintrag: Wipro Limited (India) Zweigniederlassung Deutschland
Rechtsform der Gesellschaft: inl?ndische Zweigniederlassung einer Aktiengesellschaft ausl?ndischen Rechts
Sitz der Gesellschaft: Doddakannelli, Sarjapur Road, Bangalore, Indien 560 035
Tel. +91 80 28440011, Fax: +91 80 28440051, website: www.wipro.com
Vorstandsvorsitzender: Azim H Premji

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. </p>

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 

www.wipro.com
