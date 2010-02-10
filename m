From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 10 Feb 2010 10:47:45 -0700
Subject: [PATCH v2] async-tx: fix buffer sumbission error handling in
	ipu_idma.c
In-Reply-To: <Pine.LNX.4.64.1002101659580.4495@axis700.grange>
References: <Pine.LNX.4.64.1002101643390.4495@axis700.grange>
	<e9c3a7c21002100754k7737b79cvb13a2b39ad16cc44@mail.gmail.com>
	<Pine.LNX.4.64.1002101659580.4495@axis700.grange>
Message-ID: <e9c3a7c21002100947y1cf32043u4ec9d2a5c4e494f8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 9:32 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> If submitting new buffer failed, a wrong descriptor gets completed and it
> doesn't check, if a callback is at all defined, which can lead to an Oops. Fix
> these bugs and make ipu_update_channel_buffer() void, because it never fails.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> v1 -> v2: When fixing Oopses remember to not introduce compiler warnings;)
>
> On Wed, 10 Feb 2010, Dan Williams wrote:
>
>> On Wed, Feb 10, 2010 at 8:44 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > If submitting new buffer failed, a wrong descriptor gets completed and it
>> > doesn't check, if a callback is at all defined, which can lead to an Oops. Fix
>> > these bugs and make ipu_update_channel_buffer() void, because it never fails.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> Looks like 2.6.33 material. ?Shall I tag it for -stable as well?
>
> This is more of a theoretical Oops possibility. You have to really try
> hard to get it - if at all possible. At least I've never seen one and
> never heard anyone seeing it. So, strictly speaking, I don't think this
> bug can hurt anyone, but, if Sascha has nothing against this patch, you
> can push it to stable too.

Given the time proximity to 2.6.33-final I'll push it without the
stable tag.  If we later decide it is needed there it's just a matter
of sending Greg a note.

Thanks,
Dan
