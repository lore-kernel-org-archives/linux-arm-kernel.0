From: robdclark@gmail.com (Rob Clark)
Date: Mon, 18 Aug 2014 14:32:15 -0400
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <20140818140730.GC9809@8bytes.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <871tsm5vcn.fsf@nvidia.com>
 <CAF6AEGvZUanVtPxAt76+AAdOaNwyMJ3cmcJ1srsEYBeG7ELkBQ@mail.gmail.com>
 <53EA472B.3020900@codeaurora.org>
 <20140818140730.GC9809@8bytes.org>
Message-ID: <CAF6AEGtGmAQjMc5W5a6x5QiyUc8v0XHcsNAFe65Znc=DDKPS+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:07 AM, joro at 8bytes.org <joro@8bytes.org> wrote:
> On Tue, Aug 12, 2014 at 09:56:11AM -0700, Olav Haugan wrote:
>> On 8/12/2014 3:48 AM, Rob Clark wrote:
>> > iirc, one plan for 'flags' was some sort of DONT_FLUSH_TLB flag for
>> > drivers which wanted to map/unmap N buffers with a single flush at the
>> > end.  There might have been some other usages envisioned.
>>
>> Yes, that was the original intent of the flags for now. I am sure we can
>> find other uses for this in the future.
>
> Do you have anything else in mind already besides the DONT_FLUSH_TLB
> flag?
>
> How is the IOTLB supposed to be flushed when this flag is used?
>

well, I was thinking one of two ways:

1) add new flush() vfunc.. this, I think, would be most convenient for
drivers using this feature
2) or driver simply doesn't set DONT_FLUSH_TLB flag on the last
{map,unmap}..  that would be slightly more awkward to use, but would
avoid adding a new vfunc

BR,
-R

>         Joerg
>
