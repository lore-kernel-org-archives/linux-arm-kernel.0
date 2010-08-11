From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Wed, 11 Aug 2010 18:08:43 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <20100811150443.GB8867@kroah.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<20100811095454.GA22543@n2100.arm.linux.org.uk>
	<AANLkTimX46QKAGhiyo8AodaXVjuzoxr5-5z2V4gRr1Vu@mail.gmail.com>
	<20100811150443.GB8867@kroah.com>
Message-ID: <AANLkTimmJDKbh3_pRY_ASKvjsf4YuuUMh3edh5LvDv-p@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 5:04 PM, Greg KH <greg@kroah.com> wrote:
>> Here is a pointer to the thread where it was stated that HCD's don't
>> have to handle this.
>>
>> http://kerneltrap.org/mailarchive/linux-usb/2009/4/20/5528164
>
> No, that thread is about stack vs. heap allocations, not about alignment
> issues.
>

Well although the issue discussed in that thread was caused by a stack
allocation isn't the issue here the same?

My understanding is that a heap allocation as returned by kmalloc() will be:
1) correctly aligned for DMA
and
2) in a memory zone accessible to DMA

whereas a stack allocation is not guaranteed to have either of these properties.

The problem I described in that thread was due to case 1
(misalignment) rather than the stack memory zone not being accessible
at all to DMA.
To which was the reply was basically "use a heap allocation".

So the question is are hcds expected to accept arbitarilly aligned but
heap allocated pointers (such as the result of kmalloc() + 1)?

regards,

Martin









> thanks,
>
> greg k-h
>
