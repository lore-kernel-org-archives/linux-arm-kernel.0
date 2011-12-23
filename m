From: rob@ti.com (Rob Clark)
Date: Fri, 23 Dec 2011 11:20:06 -0600
Subject: [Linaro-mm-sig] [RFC v3 0/2] Introduce DMA buffer sharing
 mechanism
In-Reply-To: <CAB2ybb-+VTR=V1hwhF1GKxgkhTrssZ1JVOwcP6spO5O3AXqivA@mail.gmail.com>
References: <1324283611-18344-1-git-send-email-sumit.semwal@ti.com>
 <20111220193117.GD3883@phenom.ffwll.local>
 <CAPM=9tzi5MyCBMJhWBM_ouL=QOaxX3K6KZ8K+t7dUYJLQrF+yA@mail.gmail.com>
 <CAB2ybb-+VTR=V1hwhF1GKxgkhTrssZ1JVOwcP6spO5O3AXqivA@mail.gmail.com>
Message-ID: <CAF6AEGs-Xgi_kmz5oag76=4v20RP5PfAM2-pyt_PyvWizgdW8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 4:08 AM, Semwal, Sumit <sumit.semwal@ti.com> wrote:
> On Wed, Dec 21, 2011 at 1:50 AM, Dave Airlie <airlied@gmail.com> wrote:
> <snip>
>>>
>>> I think this is a really good v1 version of dma_buf. It contains all the
>>> required bits (with well-specified semantics in the doc patch) to
>>> implement some basic use-cases and start fleshing out the integration with
>>> various subsystem (like drm and v4l). All the things still under
>>> discussion like
>>> - userspace mmap support
>>> - more advanced (and more strictly specified) coherency models
>>> - and shared infrastructure for implementing exporters
>>> are imo much clearer once we have a few example drivers at hand and a
>>> better understanding of some of the insane corner cases we need to be able
>>> to handle.
>>>
>>> And I think any risk that the resulting clarifications will break a basic
>>> use-case is really minimal, so I think it'd be great if this could go into
>>> 3.3 (maybe as some kind of staging/experimental infrastructure).
>>>
>>> Hence for both patches:
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Yeah I'm with Daniel, I like this one, I can definitely build the drm
>> buffer sharing layer on top of this.
>>
>> How do we see this getting merged? I'm quite happy to push it to Linus
>> if we don't have an identified path, though it could go via a Linaro
>> tree as well.
>>
>> so feel free to add:
>> Reviewed-by: Dave Airlie <airlied@redhat.com>
> Thanks Daniel and Dave!
>
> I guess we can start with staging for 3.3, and see how it shapes up. I
> will post the latest patch version pretty soon.

not sure about staging, but could make sense to mark as experimental.

> Arnd, Dave: do you have any preference on the path it takes to get
> merged? In my mind, Linaro tree might make more sense, but I would
> leave it upto you gentlemen.

Looks like Dave is making some progress on drm usage of buffer sharing
between gpu's.. if that is ready to go in at the same time, it might
be a bit logistically simpler for him to put dmabuf in the same pull
req.  I don't have strong preference one way or another, so do what is
collectively simpler ;-)

BR,
-R

>>
>> Dave.
> Best regards,
> ~Sumit.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
