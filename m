From: sumit.semwal@ti.com (Semwal, Sumit)
Date: Thu, 1 Dec 2011 11:25:02 +0530
Subject: [Linaro-mm-sig] [RFC 1/2] dma-buf: Introduce dma buffer sharing
 mechanism
In-Reply-To: <CAB2ybb9Ti-2iz_qDfzMSgDhpUc6UOtGS8wi52nQaxhB-gH=azg@mail.gmail.com>
References: <1318325033-32688-1-git-send-email-sumit.semwal@ti.com>
 <1318325033-32688-2-git-send-email-sumit.semwal@ti.com>
 <CAPM=9tzjO7poyz_uYFFgONxzuTB86kKej8f2XBDHLGdUPZHvjg@mail.gmail.com>
 <CAPM=9txtWiQuF+jNZXDogCMy+nsM=00Bv3uxAiu5oKnn-KxjAA@mail.gmail.com>
 <CAKMK7uE14gOsTUYZknmSArkzG2zSSbpDeU0dxqAtLVUmvh-5bA@mail.gmail.com>
 <CAF6AEGtgjjtVraeji09zKJSTmokmQqfk5S8LfHoMhHJY03dLkg@mail.gmail.com>
 <CAB2ybb9Ti-2iz_qDfzMSgDhpUc6UOtGS8wi52nQaxhB-gH=azg@mail.gmail.com>
Message-ID: <CAB2ybb-h7VeUK3iKmPQVvPDKJJJO1XEV9jxZfUew7S37pWkToA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave, Daniel, Rob,
>
> On Sun, Nov 27, 2011 at 12:29 PM, Rob Clark <robdclark@gmail.com> wrote:
>>
>> On Sat, Nov 26, 2011 at 8:00 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> > On Fri, Nov 25, 2011 at 17:28, Dave Airlie <airlied@gmail.com> wrote:
>> >> I've rebuilt my PRIME interface on top of dmabuf to see how it would
>> >> work,
>> >>
>> >> I've got primed gears running again on top, but I expect all my object
>> >> lifetime and memory ownership rules need fixing up (i.e. leaks like a
>> >> sieve).
>> >>
>> >> http://cgit.freedesktop.org/~airlied/linux/log/?h=drm-prime-dmabuf
>> >>
>> >> has the i915/nouveau patches for the kernel to produce the prime
>> >> interface.
>> >
>> > I've noticed that your implementations for get_scatterlist (at least
>> > for the i915 driver) doesn't return the sg table mapped into the
>> > device address space. I've checked and the documentation makes it
>> > clear that this should be the case (and we really need this to support
>> > certain insane hw), but the get/put_scatterlist names are a bit
>> > misleading. Proposal:
>> >
>> > - use struct sg_table instead of scatterlist like you've already done
>> > in you branch. Simply more consistent with the dma api.
>>
>> yup
>>
>> > - rename get/put_scatterlist into map/unmap for consistency with all
>> > the map/unmap dma api functions. The attachement would then serve as
>> > the abstract cookie to the backing storage, similar to how struct page
>> > * works as an abstract cookie for dma_map/unmap_page. The only special
>> > thing is that struct device * parameter because that's already part of
>> > the attachment.
>>
>> yup
>>
>> > - add new wrapper functions dma_buf_map_attachment and
>> > dma_buf_unmap_attachement to hide all the pointer/vtable-chasing that
>> > we currently expose to users of this interface.
>>
>> I thought that was one of the earlier comments on the initial dmabuf
>> patch, but either way: yup
>
Thanks for your comments; I will incorporate all of these in the next
version I'll send out.
>>
>>
>> BR,
>> -R
>
BR,
Sumit.
>>
>>
>> > Comments?
>> >
>> > Cheers, Daniel
>> > --
>> > Daniel Vetter
>> > daniel.vetter at ffwll.ch - +41 (0) 79 364 57 48 - http://blog.ffwll.ch
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-media"
>> > in
>> > the body of a message to majordomo at vger.kernel.org
>> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>> >
>
>
