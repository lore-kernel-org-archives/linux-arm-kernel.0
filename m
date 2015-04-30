From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 30 Apr 2015 10:48:33 -0500
Subject: Bulid regression with VDSO enabled
In-Reply-To: <087d88d067bde8159185670b82357f0a@agner.ch>
References: <679194be9498c72543073a833e4a1719@agner.ch>
 <55423E48.7000506@mentor.com> <087d88d067bde8159185670b82357f0a@agner.ch>
Message-ID: <55424ED1.9030005@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2015 10:20 AM, Stefan Agner wrote:
> On 2015-04-30 16:38, Nathan Lynch wrote:
>> On 04/30/2015 06:44 AM, Stefan Agner wrote:
>>>   OBJCOPY arch/arm/vdso/vdso.so
>>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>>> linking with -N
>>> arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]: Bad
>>> value
>>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>>> linking with -N
>>> arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so: Bad value
>>> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
>>> make[1]: *** [arch/arm/vdso] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>>
>>> I'm using GCC 4.8.3 (Linaro GCC 4.8-2014.04) on Fedora 21. Any specific
>>> new requirements to the toolchain or a bug?
>>
>> I've not encountered this before, and I'm not able to recreate it with
>> that toolchain.
>>
>> If you're using the Linaro toolchain I would expect the name of objcopy
>> to be arm-linux-gnueabihf-objcopy, but your log shows
>> arm-angstrom-linux-gnueabi-objcopy.  What's going on there?
> 
> The toolchain is built by the OpenEmbedded build system. I used the
> Angstrom distribution, which uses the Linaro Layer (daisy branch) which
> built that toolchain:
> https://git.linaro.org/openembedded/meta-linaro.git/shortlog/refs/heads/daisy
> 
> I tried the official release and I also could not reproduce the issue,
> so it seems to be toolchain related...?

Okay thanks, that gives me more to go on.  I probably won't be able to
devote more time to this today, but hopefully tomorrow.
