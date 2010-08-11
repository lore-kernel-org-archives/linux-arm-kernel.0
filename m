From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 12 Aug 2010 00:20:07 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <20100811203505.GA463@n2100.arm.linux.org.uk>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>	<4C627479.4060400@parrot.com>	<AANLkTinU2JEkeYJHo4tA+kD9Pd_F3YcUTbK9w6igc7s8@mail.gmail.com>	<4C62C7B3.2030706@nvidia.com>
	<20100811203505.GA463@n2100.arm.linux.org.uk>
Message-ID: <4C632217.9000608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Gary, you forgot to copy -usb and netdev so adding them again to try to
keep this thread joined up]

Russell King - ARM Linux wrote:
> On Wed, Aug 11, 2010 at 08:54:27AM -0700, Gary King wrote:
>   
>> I sent a patch to the list about 2 weeks ago that added support to
>> DMA bounce to bounce for misaligned buffers. We have a similar
>> problem with URB alignment for usbnet on Tegra's HCD:
>> http://lists.arm.linux.org.uk/lurker/message/20100729.005746.b43fa1d9.en.html
>>     
Nice to know someone else has the same problem :)
What is the Tegra hcd?
I can't find it in the kernel sources.

> We don't want to add support for this to DMA bounce.  DMA bounce is already
> a pain in the backside and causes its own set of problems - please let it
> die a long slow but quite death.
>
> If you want to see the kind of pain dmabounce causes, look at this long
> standing and as yet unsolved bug:
>
>   http://bugzilla.kernel.org/show_bug.cgi?id=7760
>
>   
Well I don't know the dmabounce code but why is using it likely to cause
OOM problems (at least why more so than copying the buffer in the HCD or
the usb core). In both cases there will be two copies of the buffer in
memory which could I agree be a problem in memory constrained systems.
But if we _do_ want to accept unaligned buffers from usb drivers I can't
see  a way round that.


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   
