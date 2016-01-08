From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 8 Jan 2016 11:15:05 +0000
Subject: [PATCH 0/2] crypto: sunxi-ss: fix 64-bit compilation
In-Reply-To: <20160108095959.GC3472@gondor.apana.org.au>
References: <1452182298-4653-1-git-send-email-andre.przywara@arm.com>
 <20160108095959.GC3472@gondor.apana.org.au>
Message-ID: <568F9A39.9030400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On 08/01/16 09:59, Herbert Xu wrote:
> On Thu, Jan 07, 2016 at 03:58:16PM +0000, Andre Przywara wrote:
>> Hi,
>>
>> these two patches provide a different approach to an issue I tried
>> to fix lately [1].
>> Instead of casting everything I now promote local types to size_t, so
>> that the min3() arguments naturally match in type.
>> As size_t is defined as "unsigned int" on 32-bit architectures
>> anyway, that actually does not change anything there, but instead
>> provides a clean approach to get it compiled for arm64.
>>
>> I split this up because 1/2 seems much cleaner to me than 2/2, so we
>> can have a separate discussion/merge process on this.
> 
> If this is meant for the crypto tree it needs to go to the linux-crypto
> list.

Oh dear, I planned on adding the list, but eventually forgot it. Sorry
for that, I will resend it to linux-crypto.

Thanks for pointing this out!

Cheers,
Andre.
