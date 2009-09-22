From: Bo.Liu@windriver.com (Tonyliu)
Date: Tue, 22 Sep 2009 10:44:15 +0800
Subject: SPI, DMA and an i.MX31
In-Reply-To: <4AB7C020.2070205@gmail.com>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>
	<4AB7C020.2070205@gmail.com>
Message-ID: <4AB839FF.4000803@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus Lilja wrote:
> Hi Rene,
>
> Wolf, Rene, HRO-GP wrote:
>   
>> Hello Marc 
>>
>> Thanks for your fast reply! 
>>
>>     
>>> in the LTIB kernel sources, you'll find the sources for the freescale
>>> SDMA API(s) Under linux-2.6.22/arch/arm/plat-mxc/sdma/. Using the
>>> API is not complicated, you can look in sound/arm/mxc-alsa-pmic.c to
>>> see an exemple, basically you allocate a channel (mxc_dma_request),
>>> register a callback handler (mxc_dma_callback_set) and post requests
>>> (mxc_dma_config).
>>>       
>> I did 'download' it (using the script provided by ltib and some manual
>> labor) -> kernel 2.6.22.6.
>> At the moment I use 2.6.31 and I'm planning on keeping it that way :-)
>>     
>
> Freescale has released a BSP for i.MX31 based on kernel 2.6.26. Don't
> know how much it differs in the DMA areas but it might be good to
> check it out and use that as well as a base for your work on i.MX31-DMA
> in 2.6.31. (freescale.com/imx31 => Software & Tools => i.MX31PDK => Downloads)
>
>   
>>> this information is regarding as confidential
>>>       
>> [...]
>>     
>>> One will have to sign NDA agreement with Freescale.
>>>       
>> I didn't get why they are doing it, but that might be the reason this
>> api is not included in the mainline/denx kernel.
>>     
>
> My guess is that it's probably best to use the DMA scripts that Freescale
> released in their LTIB/BSP.
>
>   
>> Thanks again and I will have a closer look on porting that api :-)
>>     
>
> It would be very nice to have i.MX31 DMA support in mainline, that would
> perhaps also make it possible to have ALSA sound support for i.MX31.
>   
AFAIK, it's not easy to support it in mainline as the sdma controller 
also need some binary firmware to work.
and there is no final stable release for the firmware, FSL drop that 
from time to time. I'm not sure whether
such type driver can be accepted by mainline.

Tony**


> Looking forward to testing this!
>
>
> Regards, Magnus
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>   


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
