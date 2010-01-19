From: hvdmerwe@tmtservices.co.za (Hennie van der Merwe)
Date: Tue, 19 Jan 2010 07:15:56 +0200
Subject: [PATCH - 3rd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <20100118215124.GE8970@buzzloop.caiaq.de>
References: <201001182134.14226.epeer@tmtservices.co.za>
	<20100118215124.GE8970@buzzloop.caiaq.de>
Message-ID: <4B55400C.1050109@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for the comments.

Daniel Mack wrote:
>> +inline void mxm_8x10_mmc_init(void)
>> +{
>> +}
>>     
>
> You should make that inline function static.
>   
I originally wrote it like this because I wanted the option for the 
machine implementing the MXM-8x10 module to initialise the MMC or not. 
I'm not sure static is appropriate (as it is exported in the header). 
Could we perhaps drop the inline and just  make it a void __init instead?

>> +inline mxm_8x10_nand_init(void)
>> +{
>> +}
>  and it should return void.
Agreed. This one must have just slipped by... Too much coffee, not 
enough sleep :)

Thanks,
Hennie
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hvdmerwe.vcf
Type: text/x-vcard
Size: 361 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100119/4a6797fb/attachment-0001.vcf>
