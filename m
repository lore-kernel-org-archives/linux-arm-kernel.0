From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 7 Jun 2011 17:35:42 +0900
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <20110607081527.GB20929@n2100.arm.linux.org.uk>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinDBebMiK9Ezu=QDpC2+rChApd64Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 5:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 07, 2011 at 01:39:43PM +0530, Jassi Brar wrote:
>> Unfortunately, no. There are some features of Samsung's DMA API that
>> the drivers have come to rely upon.
>> Besides, I am not particularly a fan of the generic API. And IIRC,
>> neither is Ben Dooks, the designer of the
>> Samsung's DMA API.
>
> We are now at the point where this is non-optional. ?If the generic API
> doesn't fit what Samsung needs, then that needs to be discussed and
> whatever problems there are need to be resolved.
>
> Continuing the platform specific DMA APIs is not sustainable.
>
> I'm getting rather fed up with Samsung needing custom this and that, and
> refusing to use the generic infrastructure such as clkdev. ?This attitude
> needs to change NOW.
>
> Fix your platform specific crap and start using the generic services.
>

I think Jassi is the right person to handle this one even though you
don't like the generic DMA APIs

1) since you become a member of linaro. it's role of linaro.
2) know the how to use the s3c-pl330 at sound (most user of DMA is
sound, SPI and MMC)
3) now you're the Samsung Sound maintainer

If we move the generic DMA APIs, it's also need to modify the its
consumer, sound and SPI.

Thank you,
Kyungmin Park
