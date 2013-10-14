From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 15 Oct 2013 09:32:47 +1030
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <1381747859.3247.33.camel@hornet>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <20131012182837.GC2089@redhat.com> <525BAA40.8070103@arm.com>
 <20131014085931.GB30954@redhat.com> <1381741495.3247.18.camel@hornet>
 <20131014104604.GC30954@redhat.com> <1381747859.3247.33.camel@hornet>
Message-ID: <877gdfbgmg.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel Moll <pawel.moll@arm.com> writes:
> On Mon, 2013-10-14 at 11:46 +0100, Michael S. Tsirkin wrote:
>> What I meant is that under the proposed scheme, users with
>> existing v1 drivers must configure a v1 device explicitly.
>> 
>> According to the plan, drivers will be updated so they can
>> work with both v1 devices and new v2 devices.
>> 
>> But if you configure a v2 device, old drivers
>> will not work.
>
> That's correct, yes. If qemu 2015(16? 17?).01 will provide v2 devices
> only, kernel 3.11 is not going to recognize any of them.
>
> What will happen in reality, though, is that the implementation of the
> Linux v1/v2 driver will pre-date *any* v2 device by far. First
> implementation of v1 devices appeared almost 2 years after the driver
> appeared. It will take year for people to upgrade to v2, and probably
> only after they experience problems with page-based addressing mode.
>
> I think I can live with this.

Yes, this makes sense.  In particular, MMIO doesn't have any users you
don't control at this point.

I expect it to be less than 2 years to get into qemu, but there'll be no
compelling reason to use v2 devices for at least that long.

Cheers,
Rusty.
