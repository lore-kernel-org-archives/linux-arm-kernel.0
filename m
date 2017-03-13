From: robdclark@gmail.com (Rob Clark)
Date: Mon, 13 Mar 2017 17:29:31 -0400
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <6d3d52ba-29a9-701f-2948-00ce28282975@redhat.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <20170303132949.GC31582@dhcp22.suse.cz>
 <cf383b9b-3cbc-0092-a071-f120874c053c@redhat.com>
 <20170306074258.GA27953@dhcp22.suse.cz>
 <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
 <20170306105805.jsq44kfxhsvazkm6@sirena.org.uk>
 <20170306160437.sf7bksorlnw7u372@phenom.ffwll.local>
 <CA+M3ks77Am3Fx-ZNmgeM5tCqdM7SzV7rby4Es-p2F2aOhUco9g@mail.gmail.com>
 <26bc57ae-d88f-4ea0-d666-2c1a02bf866f@redhat.com>
 <CA+M3ks6R=n4n54wofK7pYcWoQKUhzyWQytBO90+pRDRrAhi3ww@mail.gmail.com>
 <CAKMK7uH9NemeM2z-tQvge_B=kABop6O7UQFK3PirpJminMCPqw@mail.gmail.com>
 <6d3d52ba-29a9-701f-2948-00ce28282975@redhat.com>
Message-ID: <CAF6AEGvs0qVr_=pSp5FYoxM4XNaKLtYB-uhBmDheYcgxgv1_2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 5:09 PM, Laura Abbott <labbott@redhat.com> wrote:
>> Hm, we might want to expose all the heaps as individual
>> /dev/ion_$heapname nodes? Should we do this from the start, since
>> we're massively revamping the uapi anyway (imo not needed, current
>> state seems to work too)?
>> -Daniel
>>
>
> I thought about that. One advantage with separate /dev/ion_$heap
> is that we don't have to worry about a limit of 32 possible
> heaps per system (32-bit heap id allocation field). But dealing
> with an ioctl seems easier than names. Userspace might be less
> likely to hardcode random id numbers vs. names as well.


other advantage, I think, is selinux (brought up elsewhere on this
thread).. heaps at known fixed PAs are useful for certain sorts of
attacks so being able to restrict access more easily seems like a good
thing

BR,
-R
