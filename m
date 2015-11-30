From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Nov 2015 11:26:36 -0800
Subject: [PATCH 1/1] kconfig: add CPU endian selection beconfig and
 leconfig
In-Reply-To: <5658EC0C.1030305@broadcom.com>
References: <1448567995-8784-1-git-send-email-sbranden@broadcom.com>
 <1448567995-8784-2-git-send-email-sbranden@broadcom.com>
 <5658A368.7080509@gmail.com> <5658EC0C.1030305@broadcom.com>
Message-ID: <565CA2EC.8050709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/15 15:49, Scott Branden wrote:
> Hi Florian,
> 
> On 15-11-27 10:39 AM, Florian Fainelli wrote:
>> Le 26/11/2015 11:59, Scott Branden a ?crit :
>>> Add support for switching defconfig between big and little endian CPU.
>>> Various CPU types have ability to select big and little endian
>>> CPU in the kernel configuration.
>>>
>>> "make beconfig" will set CONFIG_CPU_BIG_ENDIAN
>>> "make leconfig" will unset CONFIG_CPU_BIG_ENDIAN
>>
>> I believe I understand what you are trying to achieve here, which is to
>> have an identical defconfig file that you can share between a big-endian
>> and little-endian kernel?
> You understand correct - ARM64 maintainers have only allowed 1 defconfig
> upstream and it supports little endian.  And it doesn't make sense to
> have another defconfig with a single line difference upstreamed.  Yet
> the defconfig does not allow the system to boot in big endian mode.
>>
>> Is not this something better left to a build system which understands
>> what config fragments are in general?
> Every build system would need to invent their own procedure.  By adding
> this into the upstream kernel there is no need to.
> make defconfig
> make beconfig (or make leconfig)
> make

In my experience build systems like OpenWrt, Yocto/OE know about config
fragments, but have a harder time dealing with running multiple make
targets within the Linux source tree...

>>
>> Since we seem to have support for fragments now with kvm and friends,
>> having this does not seem to be a big stretch though.
> Yes, that is why I proposed place it in a common location.

Fair enough.
-- 
Florian
