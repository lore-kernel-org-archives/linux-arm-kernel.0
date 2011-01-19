From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 19 Jan 2011 16:09:39 +0000
Subject: RFC: Host-endian device tree format
In-Reply-To: <AANLkTi==KLWXAv79u32ioQ9eSr7JEii7fW93WPPNdAez@mail.gmail.com>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
	<AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
	<alpine.LFD.2.00.1101191031481.8580@xanadu.home>
	<AANLkTi==KLWXAv79u32ioQ9eSr7JEii7fW93WPPNdAez@mail.gmail.com>
Message-ID: <AANLkTim7F8PBd_4zmQY7717N7CoiGvvyX473CL=6qCaj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 3:52 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Jan 19, 2011 at 8:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Wed, 19 Jan 2011, Dave Martin wrote:
>>> On Wed, Jan 19, 2011 at 1:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> > The dtb isn't so much bigendian as it is network byte order.
>>>
>>> (For me, "network byte order" is a euphemism ... <insert
>>> unconstructive rant here>)
>>
>> I concur.
>
> meh. it's all about conventions. ?When talking about external data, it
> is far more important for everyone to agree on the same representation
> than it is to tailor to each platforms preferences. ?That said, rant
> away! ?I love a good tangent.

I guess a good example of what I mean is ELF - the endianness of an
ELF image is discoverable, and cross tools do exist -- but because ELF
images are strongly bound to their target platform, running the image
takes precedence over the simplicity of the tools: so the images are
specified in such a way that they can always be host-endian for the
machine they run on, without creating format ambiguities.

Of course, it's stretching things rather a lot to claim that fdt
parsing is performance critical ... or that ELF cross tools work well
in all host/target combinations ... rather it's a niggle.

So, I'm happy as-is.  It was just tempting to rock the boat a bit to
make sure everyone has their sea legs :)

Cheers
---Dave
