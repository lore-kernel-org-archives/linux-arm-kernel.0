From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Fri, 7 Apr 2017 14:00:58 +0000
Subject: [7/7] crypto: caam/qi - add ablkcipher and authenc algorithms
In-Reply-To: <87inmggxp7.fsf@concordia.ellerman.id.au>
References: <20170317100602.2837-8-horia.geanta@nxp.com>
 <87vaqkvk6c.fsf@concordia.ellerman.id.au> <58E39F90.6050408@nxp.com>
 <87lgrftbgl.fsf@concordia.ellerman.id.au> <58E4D9C3.4070406@nxp.com>
 <87inmggxp7.fsf@concordia.ellerman.id.au>
Message-ID: <VI1PR0401MB1856407F4A75878EA66AF51EEC0C0@VI1PR0401MB1856.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Michael Ellerman [mailto:mpe at ellerman.id.au] 
Sent: Friday, April 07, 2017 4:22 PM
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Horia Geant? <horia.geanta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>; Scott Wood <oss@buserror.net>; Roy Pledge <roy.pledge@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Cristian Stoica <cristian.stoica@nxp.com>; Dan Douglass <dan.douglass@nxp.com>; linux-arm-kernel at lists.infradead.org; Vakul Garg <vakul.garg@nxp.com>; linuxppc-dev at lists.ozlabs.org; David S. Miller <davem@davemloft.net>; Alexandru Porosanu <alexandru.porosanu@nxp.com>; linux-crypto at vger.kernel.org
Subject: Re: [7/7] crypto: caam/qi - add ablkcipher and authenc algorithms
Importance: High

Laurentiu Tudor <laurentiu.tudor@nxp.com> writes:

> On 04/05/2017 01:06 PM, Michael Ellerman wrote:
>> Laurentiu Tudor <laurentiu.tudor@nxp.com> writes:
>>
>>> Hi Michael,
>>>
>>> Just a couple of basic things to check:
>>>    - was the dtb updated to the newest?
>>
>> Possibly not, it's an automated build/boot, I'll have to check what 
>> it does with the dtb.
>>
>>>    - is the qman node present? This should be easily visible in 
>>> /proc/device-tree/soc at ffe000000/qman at 318000.
>>
>> No it's not there.
>>
>> That's running linux-next with:
>>
>> CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI=n
>>
>>
>> Does that mean I didn't update the device tree?
>
> I think so. Also, I just checked that the node is actually there by 
> compiling p5020ds.dts and then decompiling the dtb.

> OK, I'll make sure I update the DTB.
> 
> It will still be good if the code was a bit more robust about the qman being missing.

Totally agree. We should handle this error condition.

---
Thanks & Best Regards, Laurentiu
