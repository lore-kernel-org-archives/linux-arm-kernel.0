From: jassisinghbrar@gmail.com (jassi brar)
Date: Fri, 26 Mar 2010 07:27:49 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <4BAB7D9F.4070807@intel.com>
References: <4BAAD5BB.7050101@samsung.com>
	<1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>
	<63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
	<1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
	<4BAB7D9F.4070807@intel.com>
Message-ID: <1b68c6791003251527s1ef985d2m4a309a3c09e31e0a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 12:13 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> jassi brar wrote:
>>>
>>> Perhaps Joonyoung can simply port over the stuff
>>> you need to this driver if you show your code.
>>
>> Having worked on Samsung SoCs(with PL330 DMAC) based products, I would be
>> _very_ surprised if any user found this implementation useful.
>> Let alone testing, this implementation can't even explain usability
>> for fast peripherals
>> with shallow FIFOs. I didn't give feedback for this patch because I am
>> not sure if this
>> is the right way to go at all.
>
> This is the wrong attitude. ?If it were not for a simple oversight
> Joonyoung's driver would already be upstream for the past two kernel
> releases. ?So you need to work together to improve that driver to
> incorporate what you need.
Nothing wrong in attitude here.
Giving feedback on the code only comes after one is convinced with the
overall approach taken. The last time I raised the PL330 driver issue,
most people were not enthusiastic with this drivers/dma/ approach.
I wasn't active mainline discussions when the driver was originally
submitted a few months ago.
And now my replies are not very 'polite' because theres a lot going on
in the background that people in public threads don't know about.


> It sounds like you just need to add an extension for the arch specific dma
> api.
I actually plan more than that.
Apart from inefficient design, JoonYoung's driver has made some fatal
assumptions
about PL330, which will result in DMA aborts if used with SoCs that implement
configuration of PL330 that is very different from Samsung SoCs'
Of course, I address all such issues that I can think of, in my implementation.

regards.
