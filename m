From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Mar 2010 09:57:33 +0800
Subject: [PATCH] Voipac PXA270: UDC and UHC support
In-Reply-To: <87ljdtpf0e.fsf@free.fr>
References: <201003100543.00221.marek.vasut@gmail.com>
	<201003101243.54008.marek.vasut@gmail.com>
	<87hbol77lp.fsf@free.fr> <201003132300.55480.marek.vasut@gmail.com>
	<87ljdtpf0e.fsf@free.fr>
Message-ID: <f17812d71003211857n4fc2de73q8c937c74fec5a46@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static void vpac270_udc_command(int cmd)
>> +{
>> + ? ? if (cmd == PXA2XX_UDC_CMD_CONNECT)
>> + ? ? ? ? ? ? UP2OCR |= UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE;
>> + ? ? else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
>> + ? ? ? ? ? ? UP2OCR &= ~(UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE);
>
> In the "DISCONNECT" case, you reset UP2OCR_HXOE, meaning the usb port isn't a
> USB Device anymore (neither a USB host). If that's on purpose, then all good, in
> the other case, don't reset that one.
>

Marek??

> Otherwise, you can add for the UDC part :
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> --
> Robert
>
