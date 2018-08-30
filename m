From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 30 Aug 2018 09:47:04 +0200
Subject: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
In-Reply-To: <ec22950d-ae18-0cec-3bef-a4840618eb7d@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
 <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
 <20180827151140.luysp2kfbcq6patg@flea>
 <ec22950d-ae18-0cec-3bef-a4840618eb7d@linaro.org>
Message-ID: <20180830074704.56x5xzfhauhd7ncy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 29, 2018 at 03:33:29PM +0300, Georgi Djakov wrote:
> On 08/27/2018 06:11 PM, Maxime Ripard wrote:
> > On Fri, Aug 24, 2018 at 10:35:23AM -0500, Rob Herring wrote:
> >> On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>>
> >>> Hi Maxime,
> >>>
> >>> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> >>>> Hi Georgi,
> >>>>
> >>>> On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> >>>>>> There is also a patch series from Maxime Ripard that's addressing the
> >>>>>> same general area. See "dt-bindings: Add a dma-parent property". We
> >>>>>> don't need multiple ways to address describing the device to memory
> >>>>>> paths, so you all had better work out a common solution.
> >>>>>
> >>>>> Looks like this fits exactly into the interconnect API concept. I see
> >>>>> MBUS as interconnect provider and display/camera as consumers, that
> >>>>> report their bandwidth needs. I am also planning to add support for
> >>>>> priority.
> >>>>
> >>>> Thanks for working on this. After looking at your serie, the one thing
> >>>> I'm a bit uncertain about (and the most important one to us) is how we
> >>>> would be able to tell through which interconnect the DMA are done.
> >>>>
> >>>> This is important to us since our topology is actually quite simple as
> >>>> you've seen, but the RAM is not mapped on that bus and on the CPU's,
> >>>> so we need to apply an offset to each buffer being DMA'd.
> >>>
> >>> Ok, i see - your problem is not about bandwidth scaling but about using
> >>> different memory ranges by the driver to access the same location. So
> >>> this is not really the same and your problem is different. Also the
> >>> interconnect bindings are describing a path and endpoints. However i am
> >>> open to any ideas.
> >>
> >> It may be different things you need, but both are related to the path
> >> between a bus master and memory. We can't have each 'problem'
> >> described in a different way. Well, we could as long as each platform
> >> has different problems, but that's unlikely.
> >>
> >> It could turn out that the only commonality is property naming
> >> convention, but that's still better than 2 independent solutions.
> > 
> > Yeah, I really don't think the two issues are unrelated. Can we maybe
> > have a particular interconnect-names value to mark the interconnect
> > being used to perform DMA?
> 
> We can call one of the paths "dma" and use it to perform DMA for the
> current device. I don't see a problem with this. The name of the path is
> descriptive and makes sense. And by doing we avoid adding more DT
> properties, which would be an other option.

That works for me. If Rob is fine with it too, I'll send an updated
version of my serie based on yours.

Thanks!
Maxime



-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180830/32f68ac9/attachment-0001.sig>
