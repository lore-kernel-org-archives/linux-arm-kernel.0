From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 23 Nov 2015 14:15:09 -0800
Subject: defconfig support for CPU_BIG_ENDIAN arm64 kernel
In-Reply-To: <62603584.FYAH7ECFA0@wuerfel>
References: <56538C12.4030506@broadcom.com> <62603584.FYAH7ECFA0@wuerfel>
Message-ID: <56538FED.4090704@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 15-11-23 02:04 PM, Arnd Bergmann wrote:
> On Monday 23 November 2015 13:58:42 Scott Branden wrote:
>> For arm64 platforms there is only a single defconfig upstreamed.  This
>> builds for Little Endian ARM64 platforms.  So...what about Big Endian?
>>
>> It seems like we need another defconfig with CPU_BIG_ENDIAN to be
>> enabled and built in the upstream kernel.  We need this deconfig to test
>> that drivers compile in big endian mode and we have an upstream kernel
>> image to run on these systems.
>>
>> I'm hoping the upstreamed kernel is already being built/tested with the
>> arm64 big endian compiler.
>>
>> If not, perhaps the upstream solution is to continue to use the single
>> defconfig we have today and start using scripts/kconfig/merge_config.sh
>> to add the CPU_BIG_ENDIAN support to generate a big endian defconfig?
>>
>> Hopefully arm64 is already being compiled and tested for Big Endian and
>> I'm missing something?
>
> kernelci.org uses Kconfig fragments to build big-endian kernels with
> merge-config.sh

Glad its already tested!
>
> We should probably make it a little more straightforward to do this
> with mainline kernels. 'make help' already shows 'kvmconfig', 'xenconfig'
> and 'tinyconfig' targets for arm64 that use this. Any suggestions how we
> should name and integrate big-endian builds?

Yes, I would like this ability added to the standard arm64 make 
configuration targets.

To do this we would need to add a new configuration target
"bigendianconfig"
or
"beconfig"  - Update current config to enable big endian support

If we do that - Perhaps the other is necessary as well then?
"littleendianconfig"
or
"leconfig"

I propose the short format "beconfig" and "leconfig" be added.

Thanks,
Scott

>
> 	Arnd
>
