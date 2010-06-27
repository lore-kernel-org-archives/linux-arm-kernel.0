From: freddy2_es@yahoo.com (=?iso-8859-1?Q?Alfredo_Quesada_S=E1nchez?=)
Date: Sun, 27 Jun 2010 14:47:12 -0700 (PDT)
Subject: Using SPI in a kernel module
In-Reply-To: <4C27C21D.6010406@softerra.com>
Message-ID: <385275.91392.qm@web33802.mail.mud.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I expected to receive a call to probe as soon as i register an spi_driver, which doesn't
seem to happen. If my driver must be already registered before the machine init then it
can't be a module, it must be inside the kernel, which looks really strange.

What I don't understand is where the spi_device instance is created, and where. Looks like
it's appearing from nowhere. But even more strange is the fact that spidev only registers
its own spi_driver and according to other people it works, so the only explanation for me
is that it can only be done as long as it's part of the kernel. But even being part of the
kernel spi_driver's register should be done before the machine init, which makes no sense
imho.

Regards


--- El dom, 27/6/10, Mykhail Lodygin <mishal@softerra.com> escribi?:

De: Mykhail Lodygin <mishal@softerra.com>
Asunto: Re: Using SPI in a kernel module
Para: "Alfredo Quesada S?nchez" <freddy2_es@yahoo.com>
CC: linux-arm-kernel at lists.infradead.org
Fecha: domingo, 27 de junio, 2010 23:26





  
Invocation sequence is the same as described in ek_spi_devices. So since there is no YOUR driver in ek_spi_devices - i can't say when it would be called - for now - never.
which device? - you define it by setting .chip_select, i believe. 

You could see all calls -? just set verbosity to debug function in the
configuration.



 



      
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100627/e7979067/attachment-0001.html>
