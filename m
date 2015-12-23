From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 23 Dec 2015 00:07:41 +0000
Subject: [RFC PATCH 2/5] crypto: sunxi-ss: fix min3() call to match types
In-Reply-To: <201512222306.58681.arnd@arndb.de>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-3-git-send-email-andre.przywara@arm.com>
 <201512222306.58681.arnd@arndb.de>
Message-ID: <5679E5CD.2070103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
On 12/22/15 22:06, Arnd Bergmann wrote:
> On Tuesday 22 December 2015, Andre Przywara wrote:
>> The min3() macro expects all arguments to be of the same type (or
>> size at least). While two arguments are ints or u32s, one is size_t,
>> which does not match on 64-bit architectures.
>> Cast the size_t to u32 to make min3() happy. In this context here the
>> length should never exceed 32 bits anyway.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Looks correct, but a bit ugly. Could we avoid the casts by using
> temporary variables to keep the size_t based data?

I guess this gets even uglier, but I found a better solution by
promoting the other involved variables to size_t in this function. This
works nicely for most of the cases, I just need two size_t casts now.
Will send an updated version soon.

Cheers,
Andre.
