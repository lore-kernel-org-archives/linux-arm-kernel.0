From: andy@warmcat.com (Andy Green)
Date: Mon, 28 Sep 2009 09:19:14 +0100
Subject: [PATCH needed?] ARM: add missing HAVE_KERNEL_GZIP
In-Reply-To: <Pine.LNX.4.64.0909280954490.4212@axis700.grange>
References: <Pine.LNX.4.64.0909280914220.4212@axis700.grange>	<20090928075313.GA22380@pengutronix.de>
	<Pine.LNX.4.64.0909280954490.4212@axis700.grange>
Message-ID: <4AC07182.90901@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2009 08:56 AM, Somebody in the thread at some point said:
> On Mon, 28 Sep 2009, Uwe Kleine-K?nig wrote:
>
>> Hi Guennadi,
>>
>> On Mon, Sep 28, 2009 at 09:21:35AM +0200, Guennadi Liakhovetski wrote:
>>> Kernel fails to uncompress itself and boot without this patch.
>> I have no problem booting yesterday's linus/master without that change.
>>
>> What is the exact problem you see?
>
> Don't remember the error message exactly - something like "cannot
> uncompress" or "missing decompressor"... Observed on a i.MX31 system,
> although, if the problem were real, it probably would be present on all
> ARMs - none defines any of those decompressors. Will have to double-check
> then.

Just a comment on this, I run on an iMX device with an uncompressed 
kernel for a nice decrease in early boot time.  The kernel comes in at 
3MB uncompressed and the Qi bootloader I used pulls that in around half 
a second from uSD.

I use gzip for something else as it happens, but in the uncompressed 
case, boot is not dependent on gzip in the kernel.

-Andy
