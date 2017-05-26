From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 26 May 2017 08:50:49 +0200
Subject: [PATCH] drm/rockchip: Don't allow zero sized gem buffer
In-Reply-To: <20170526055218.GA23802@infradead.org>
References: <1495521583-29151-1-git-send-email-jeffy.chen@rock-chips.com>
 <20170525153045.7svkkmfsqbqkfacp@art_vandelay>
 <59279331.3050402@rock-chips.com>
 <20170526055218.GA23802@infradead.org>
Message-ID: <CAKMK7uHRsk79BzmgnQ23EaKwgMBcXmAYMLT8rqt-ebdJ36EW8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 7:52 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 26, 2017 at 10:30:09AM +0800, jeffy wrote:
>> Hi sean,
>>
>> On 05/25/2017 11:30 PM, Sean Paul wrote:
>> > On Tue, May 23, 2017 at 02:39:43PM +0800, Jeffy Chen wrote:
>> > > The system would crash when trying to alloc zero sized gem buffer:
>> > > [    6.712435] Unable to handle kernel NULL pointer dereference at virtual address 00000010 <--ZERO_SIZE_PTR
>> > > ...
>> > > [    6.757502] PC is at sg_alloc_table_from_pages+0x170/0x1ec
>> >
>> > It's unfortunate that you didn't include the entire stack trace. From code
>> > inspection, it seems like the 0 size comes from the fb_probe path? Is there
>> > somewhere in the helpers that you could check the mode is sane so all drivers
>> > can benefit?
>>
>> hmm, sorry, i was testing it on chromeos 4.4 kernel, it turns out that we
>> have a custom ioctl for userspace to create gem buffer(the same as exynos
>> drm), which might get the the 0 size.
>>
>> but on upstream kernel, it could only be called by dump_create, and the
>> drm_mode_create_dumb_ioctl already did the size check.
>>
>> will resent this patch, and rewrite the commit message, thanx.
>
> That suggests that this patch isn't needed at all.

Yes, not needed for upstream. But next time around pls include the
entire backtrace (or at least the relevant parts), not just the last
line, so that we can figure this out directly.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
