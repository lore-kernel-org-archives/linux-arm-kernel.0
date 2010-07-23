From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 23 Jul 2010 21:07:02 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <20100723131816.a5a5e9a7.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Fri\, 23 Jul 2010 13\:18\:16 +0200")
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
	<87r5jkxh1y.fsf@free.fr>
	<20100705104043.c72d4a5b.ospite@studenti.unina.it>
	<87zkxyv3jv.fsf@free.fr>
	<20100722171404.e25e593a.ospite@studenti.unina.it>
	<20100723131816.a5a5e9a7.ospite@studenti.unina.it>
Message-ID: <8739vauieh.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> On Thu, 22 Jul 2010 17:14:04 +0200
> Antonio Ospite <ospite@studenti.unina.it> wrote:
>> > Now, the interrupt "storm" could block the kernel. That would rather be an host
>> > issue. Did you try to connect your phone to another computer ?
>> >
>> > I would ask for a last test : on the first line of function pxa_udc_probe(),
>> > insert "return 0;". If kernel still stalls, the pxa27x-udc is not involved.
>> >
>> 
>> By inserting that "return 0;" the kernel goes on and I can complete
>> booting.
Too bad, pxa27x_udc has to be the culprit ...

Okay, I have a new track.
Would you apply the patch below and see if that improves your problem. This one
should:
 - disable the pullup line (and thus no irq should be triggered)
 - if an early irq is triggered anyway, don't handle it if no gadget driver was subscribed

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: patch.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100723/defe4b44/attachment.txt>
-------------- next part --------------

Cheers.

-- 
Robert
