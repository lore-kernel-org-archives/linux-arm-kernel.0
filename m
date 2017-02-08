From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 8 Feb 2017 08:34:01 +0100
Subject: [PATCH 1/2] drm/rockchip: support mode_valid for crtc
In-Reply-To: <589A6A38.8050805@rock-chips.com>
References: <1486280197-1585-1-git-send-email-mark.yao@rock-chips.com>
 <20170207161405.GG15150@art_vandelay> <589A6A38.8050805@rock-chips.com>
Message-ID: <CAKMK7uE5gzDjBTg=XoaxB7mY89SR8yhaC9rCXHE4mCaXuqDBHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 1:45 AM, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2017?02?08? 00:14, Sean Paul wrote:
>>
>> On Sun, Feb 05, 2017 at 03:36:36PM +0800, Mark Yao wrote:
>>>
>>> drm crtc already has mode_fixup callback to can do mode check, but
>>> We actually want to valid display mode on connector getmode time,
>>> mode_fixup can't do it.
>>>
>>> So add a private mode_valid callback to rockchip crtc, connectors can
>>> check mode with this mode_valid callback.
>>>
>> There are some nasty layer violations happening in this set. You should
>> use
>> mode_fixup if the crtc has limitations on the mode being set.
>>
>> Sean
>
> Mode_fixup can also check crtc limitations, but it's secondly time to check
> display mode.
>
> mode_fixup only works on drm_setcrtc or atomic_commit check, when userspace
> get a series of display modes,
> They don't know which display mode is bad before drm_setcrtc or
> atomic_commit check, they need try,
> but drm_setcrtc or atomic_commit check not only for display mode check,
> means that userspace didn't have a sure
> method to verify display mode.
>
> So I try to add the mode_valid callback to connector getmodes time, verify
> display mode before send mode list to userspace.
> then userspace would get a good display mode list.

You need both, the kerneldoc of these hooks explains in detail why.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
