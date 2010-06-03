From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 3 Jun 2010 10:30:06 +0800
Subject: [URGENT] Re: bit errors on spitz + voipac
In-Reply-To: <201006030201.13341.marek.vasut@gmail.com>
References: <20100305212708.GC21773@elf.ucw.cz>
	<1268048916.6477.9.camel@utx.utx.cz>
	<20100308121634.GA14904@atrey.karlin.mff.cuni.cz>
	<201006030201.13341.marek.vasut@gmail.com>
Message-ID: <AANLkTikSotOdWIKqPpNi100rsVraIxZp6yZplIvaSo9m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 3, 2010 at 8:01 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne Po 8. b?ezna 2010 13:16:35 Cyril Hrubis napsal(a):
>> Hi!
>>
>> > - And I see display noise while CF Wi-Fi card is active.
>>
>> Forgotten about this one. See for yourself, notice short black vertical
>> lines flashing randomly.
>>
>> http://atrey.karlin.mff.cuni.cz/~metan/outgoing/zaurus_sickness.mpg
>
> This is not only case of spitz. I've seen LCD image falling apart on pxafb on
> Voipac PXA270 board. The image was like "torn in half and part of it was moved
> to right, the hole between staying white".
>
> This happened exactly when I started doing a DMA transfer from a harddrive
> attached through pata_pxa. It's perfectly replicable. If I disabled DMA and let
> it run only in PIO, the image was fine.
>
> I assume the corruption Pavel was seeing is related. My guess is the problems
> are caused when DMA between the CPU and a companion chip happens. I dunno if the
> DMA controller doesn't have enough power to supply LCD and the companion chip
> with data, but that's one of my guesses.
>
> btw. Adjusting the DMA descriptor length in pata_pxa didn't help.
>

If there is a FIFO attached, may need the FIFO status when the error happens.
And a dump of the DMA registers would also be helpful.
