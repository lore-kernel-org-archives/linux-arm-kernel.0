From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 9 Mar 2017 11:00:39 +0100
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <20170306160437.sf7bksorlnw7u372@phenom.ffwll.local>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <20170303132949.GC31582@dhcp22.suse.cz>
 <cf383b9b-3cbc-0092-a071-f120874c053c@redhat.com>
 <20170306074258.GA27953@dhcp22.suse.cz>
 <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
 <20170306105805.jsq44kfxhsvazkm6@sirena.org.uk>
 <20170306160437.sf7bksorlnw7u372@phenom.ffwll.local>
Message-ID: <CA+M3ks77Am3Fx-ZNmgeM5tCqdM7SzV7rby4Es-p2F2aOhUco9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-06 17:04 GMT+01:00 Daniel Vetter <daniel@ffwll.ch>:
> On Mon, Mar 06, 2017 at 11:58:05AM +0100, Mark Brown wrote:
>> On Mon, Mar 06, 2017 at 11:40:41AM +0100, Daniel Vetter wrote:
>>
>> > No one gave a thing about android in upstream, so Greg KH just dumped it
>> > all into staging/android/. We've discussed ION a bunch of times, recorded
>> > anything we'd like to fix in staging/android/TODO, and Laura's patch
>> > series here addresses a big chunk of that.
>>
>> > This is pretty much the same approach we (gpu folks) used to de-stage the
>> > syncpt stuff.
>>
>> Well, there's also the fact that quite a few people have issues with the
>> design (like Laurent).  It seems like a lot of them have either got more
>> comfortable with it over time, or at least not managed to come up with
>> any better ideas in the meantime.
>
> See the TODO, it has everything a really big group (look at the patch for
> the full Cc: list) figured needs to be improved at LPC 2015. We don't just
> merge stuff because merging stuff is fun :-)
>
> Laurent was even in that group ...
> -Daniel

For me those patches are going in the right direction.

I still have few questions:
- since alignment management has been remove from ion-core, should it
be also removed from ioctl structure ?
- can you we ride off ion_handle (at least in userland) and only
export a dma-buf descriptor ?

In the future how can we add new heaps ?
Some platforms have very specific memory allocation
requirements (just have a look in the number of gem custom allocator in drm)
Do you plan to add heap type/mask for each ?

Benjamin

> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


Follow Linaro: Facebook | Twitter | Blog
