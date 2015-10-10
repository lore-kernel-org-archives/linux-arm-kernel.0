From: yang.shi@linaro.org (Shi, Yang)
Date: Fri, 09 Oct 2015 17:28:08 -0700
Subject: Run armv7 32 bit userspace on aarch64
In-Reply-To: <56184079.1040905@linaro.org>
References: <5615A0E1.1050402@linaro.org> <20151008111248.GE16807@arm.com>
 <56184079.1040905@linaro.org>
Message-ID: <56185B98.2060400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/9/2015 3:32 PM, Shi, Yang wrote:
> On 10/8/2015 4:12 AM, Will Deacon wrote:
>> On Wed, Oct 07, 2015 at 03:46:57PM -0700, Shi, Yang wrote:
>>> I'm trying to run armv7 little endian userspace on qemu aarch64 with
>>> 4.1.x
>>> kernel. I was told by someone such usecase is valid and I have
>>> CONFIG_COMPAT
>>> enabled in my kernel.
>>>
>>> But, I ran into the below error. It looks the userspace application is
>>> trying to write a readonly page. I got the similar failure on arm vfp
>>> with
>>> Linaro images (4.1 kernel) too.
>>>
>>> Did anyone have tried it recently?
>>
>> -rc4 seems to be working fine with Debian Jessie armhf on my Juno boards.
>>
>> Do you have a good way of reproducing this with a mainline kernel?
>
> It seems a qemu's bug. I can get both ubuntu and openembedded userspace
> bootup on my LS2085 board with 4.1 kernel.

Some new findings pointed me to another direction.

I just tried to build OE userspace with gcc 5.2 (default toolchain in OE 
now), it fails to boot up with the same error.

Then I tried the below test on 4.1 kernel:

Linaro OE userspace image (4.9 toolchain)	Failed
My OE build with 4.9.3 toolchain		Success
My OE build with 5.2 toolchain			Failed
Ubuntu image					Success

Linaro image is from: 
http://snapshots.linaro.org/openembedded/images/minimal-armv7a-gcc-4.9/348/linaro-image-minimal-genericarmv7a-20150922-348.rootfs.tar.gz

Ubuntu image is from: 
http://snapshots.linaro.org/ubuntu/images/developer/710/linaro-vivid-developer-20150914-710.tar.gz


Yang

>
> Thanks,
> Yang
>
>>
>> Will
>>
>
