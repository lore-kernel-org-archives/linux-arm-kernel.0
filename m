From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 25 Oct 2012 18:00:52 +0200
Subject: [PATCH 2/2] arm: mvebu: adding SATA support: dt binding and config
 update
In-Reply-To: <50894534.2000602@gmail.com>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
 <20121024160139.6dbf5e16@skate> <5087F5B9.0@free-electrons.com>
 <20121025131818.GF18811@titan.lakedaemon.net> <20121025152114.73e69c92@skate>
 <50893FC8.1050503@free-electrons.com> <50894534.2000602@gmail.com>
Message-ID: <50896234.1080201@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 03:57 PM, Rob Herring wrote:
> On 10/25/2012 08:34 AM, Gregory CLEMENT wrote:
>> On 10/25/2012 03:21 PM, Thomas Petazzoni wrote:
>>> Jason,
>>>
>>> On Thu, 25 Oct 2012 09:18:18 -0400, Jason Cooper wrote:
>>>
>>>>> Jason, Andrew, do you want I split this patch as suggested by
>>>>> Thomas or are you fine with having one single patch?
>>>>
>>>> Yes, please make the defconfig changes a separate patch.  Also, please
>>>> make sure only the minimum is enabled (eq RAID... isn't needed).
>>>
>>> I haven't looked in details at the driver, but is nr-ports = <foo> the
>>> right way of doing things? We may have platforms were port 0 is not
>>> used, but port 1 is used, and just a number of ports doesn't allow to
>>> express this.
>>>
>>> Shouldn't the DT property be
>>>
>>>   ports = <0>, <1>
>>>   ports = <1>
>>>   ports = <1>, <3>
>>>
>>> In order to allow to more precisely enabled SATA ports? Or maybe the
>>> SATA ports cannot be enabled/disabled on a per-port basis, in which
>>> case I'm obviously wrong here.
>>
>> The actual implementation of mv_sata.c doesn't work like this. You can
>> only pass the number of ports supported not the list of the port you
>> want to support. I've checked in the device tree binding documentation
>> _and_ also in the code.
> 
> Is that a statement about the driver or the h/w? It does not matter what
> the driver does. If the h/w can support skipping a port, then the dts
> should allow that.

Indeed I didn't see anything in the datasheet which would prevent to use
only port 2. I agree to add this feature if needed, but currently there
is no Marvell based board whith this kind of configuration. Can we keep
this series as a simple series to enable SATA on Armada 370/XP, and
prepare an other series for this new feature?

> 
> A bitmask would be most appropriate here (and matches how AHCI does the
> equivalent).

I didn't see any bitmask for AHCI, just an optional list of phandle on
combophy.

> 
> Rob
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
