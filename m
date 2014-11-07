From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 07 Nov 2014 16:14:21 -0300
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <3434817.dk7dLDFrcN@wuerfel> <544FCFB3.10100@vanguardiasur.com.ar>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <545D1A0D.9050307@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/06/2014 04:25 PM, Stefan Wahren wrote:
> Hi,
> 
>> Arnd Bergmann <arnd@arndb.de> hat am 28. Oktober 2014 um 20:13 geschrieben:
>> [...]
>>
>> I came up with MTD just because a grep for OTP showed most hits in there.
>> I have to admit that I didn't check whether those are actually for
>> the same kind of device or for something else that goes by the same
>> name. Having it in MTD doesn't sound too obscure though.
>>
>> There are a few other references to efuse or otp in the kernel, which means
>> that at some point we probably want to have a common subsystem and user
>> interface for this, either in MTD or standalone.
>>
>> Between drivers/misc/fsl_ocotp.c, drivers/soc/tegra/fuse and
>> drivers/mfd/ab3100-otp.c, is there any commonality that we could
>> base an abstract API on?
> 
> i don't have a answer to this question, but how about changing fsl_ocotp driver
> to driver/soc/mxs/fuse with a similiar binary interface like the tegra ones.
> 
> Does it make sense to you?
> 

While you are here, maybe you can check if your API and driver will also
be useful to support i.MX6 OCOTP?

I understand that I might be asking too much, and that perhaps i.MX23/28
eFuses are completely different from other another i.MX.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
