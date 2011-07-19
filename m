From: b32955@freescale.com (Huang Shijie)
Date: Tue, 19 Jul 2011 15:03:45 +0800
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <20005.7677.145955.789329@ipc1.ka-ro>
References: <20004.12663.29494.339601@ipc1.ka-ro>	<20110718164354.GA3328@S2100-06.ap.freescale.net>	<4E24E804.10002@freescale.com>
	<20005.7677.145955.789329@ipc1.ka-ro>
Message-ID: <4E252C51.8070900@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2011?07?19? 14:02, Lothar Wa?mann ??:
> Hi,
>
> Huang Shijie writes:
>> hi  Lothar:
>>> On Mon, Jul 18, 2011 at 03:13:27PM +0200, Lothar Wa?mann wrote:
>>>> Hi,
>>>>
>>>> with the gpmi-nfc driver for imx28 from Shawn Guo on a TX28 I
>>> To be clear, the author of gpmi-nfc driver is Huang Shijie (Cc-ed).
>>>
>>> Regards,
>>> Shawn
>>>
>>>> encountered some problems with jffs2 when overwriting pages that have
>>>> been written with 0xff (e.g. from padding from the file system image
>>>> file).
>> The GPMI driver now does not support the JFFS2 very well.
>> The JFFS2 will write the OOB, while the BCH of GPMI will use the OOB too.
>>
> I have applied a patch (from the Freescale BSPs) that prevents JFFS2
> from using the OOB area. But this still doesn't help.
>
Could you show the log ?

>> So I have to disable the JFFS2 to use the OOB. I have not finish the
>> code about it now.
>>
>> I recommend you use the UBIFS. But the latest version of GPMI driver
>> meets a DMA bug.
>> I am debugging the DMA bug now. and I will send it out when i fix it.
>>
> What sort of DMA bug?
>

The DMA may time-out. :(

The DMA time-out may occur in two situations:
[1] send a command DMA descriptor, see the nfc->send_command() function.
[2] read the non-ecc data from nand, see the nfc->read_data() function.

I don't know why. Maybe caused by the timing, or something else.

Best Regards
Huang Shijie

> Lothar Wa?mann
