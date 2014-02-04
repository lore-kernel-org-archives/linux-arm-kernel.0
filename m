From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 4 Feb 2014 10:58:31 -0800
Subject: [PATCH] dma: mv_xor: Silence a bunch of LPAE-related warnings
In-Reply-To: <CAPcyv4jwwRT_+c-yDycgY0d79nByvAVWH6waFWeodE9yi=7CDg@mail.gmail.com>
References: <1391476403-26099-1-git-send-email-olof@lixom.net>
 <20140204052329.GN10628@intel.com>
 <20140204170019.GI8533@titan.lakedaemon.net>
 <CAOesGMg0mrikAp7cDkm9+5=TfR7bj7_f4=JPMxBbabEPwkQs9Q@mail.gmail.com>
 <CAPcyv4jwwRT_+c-yDycgY0d79nByvAVWH6waFWeodE9yi=7CDg@mail.gmail.com>
Message-ID: <CAPcyv4gWJA7Cv39pxtuOqj0RyivODNuae7Q0Ku27RQO8=M3HbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 10:57 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Feb 4, 2014 at 10:30 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Tue, Feb 4, 2014 at 9:00 AM, Jason Cooper <jason@lakedaemon.net> wrote:
>>> On Tue, Feb 04, 2014 at 10:53:29AM +0530, Vinod Koul wrote:
>>>> On Mon, Feb 03, 2014 at 05:13:23PM -0800, Olof Johansson wrote:
>>>> > Enabling some of the mvebu platforms in the multiplatform config for ARM
>>>> > enabled these drivers, which also triggered a bunch of warnings when LPAE
>>>> > is enabled (thus making phys_addr_t 64-bit).
>>>> >
>>>> > Most changes are switching printk formats, but also a bit of changes to what
>>>> > used to be array-based pointer arithmetic that could just be done with the
>>>> > address types instead.
>>>> >
>>>> > The warnings were:
>>>> >
>>>> > drivers/dma/mv_xor.c: In function 'mv_xor_tx_submit':
>>>> > drivers/dma/mv_xor.c:500:3: warning: format '%x' expects argument of type
>>>> >     'unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat]
>>>> > drivers/dma/mv_xor.c: In function 'mv_xor_alloc_chan_resources':
>>>> > drivers/dma/mv_xor.c:553:13: warning: cast to pointer from integer of
>>>> >     different size [-Wint-to-pointer-cast]
>>>> > drivers/dma/mv_xor.c:555:4: warning: cast from pointer to integer of
>>>> >     different size [-Wpointer-to-int-cast]
>>>> > drivers/dma/mv_xor.c: In function 'mv_xor_prep_dma_memcpy':
>>>> > drivers/dma/mv_xor.c:584:2: warning: format '%x' expects argument of type
>>>> >     'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat]
>>>> > drivers/dma/mv_xor.c:584:2: warning: format '%x' expects argument of type
>>>> >     'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat]
>>>> > drivers/dma/mv_xor.c: In function 'mv_xor_prep_dma_xor':
>>>> > drivers/dma/mv_xor.c:628:2: warning: format '%u' expects argument of type
>>>> >     'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat]
>>>> >
>>>> > Signed-off-by: Olof Johansson <olof@lixom.net>
>>>> Acked-by: Vinod Koul <vinod.koul@intel.com>
>>>
>>> Olof, would you like me to queue it up?  Or do you want to take it
>>> directly?
>>>
>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>
>> I'm confused. I sent the patch to the drivers/dma maintainers and they
>> just acked it without asking me to pick it up myself.
>>
>> Vinod, did you ack it for me to pick it up, or for some other reason?
>> If you don't want to take it through your tree I'll be happy to take
>> it through arm-soc, just looking to clarify.
>>
>> (Jason, I can apply it directly)
>
> Vinod will correct me if I am wrong, but I take his acks to mean "yup,
> take it through your tree".  For this specific problem I thought we
> had a comprehensive fix pending from Joe Perches to add a new %pX
> format specifier for dma addresses?

Never mind... that's what you are using.  Sorry for the noise.
