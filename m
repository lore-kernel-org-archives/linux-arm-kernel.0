From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 9 May 2017 08:40:27 +0100
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <b63475e9-21f6-5995-90b6-e0eeae8144ab@rock-chips.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
 <12996903.t3AZceNVOh@diego>
 <b63475e9-21f6-5995-90b6-e0eeae8144ab@rock-chips.com>
Message-ID: <b43fc703-3c39-58e9-6006-1aa7f9d0cea6@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/17 02:16, Randy Li wrote:
>
>
> On 05/09/2017 12:27 AM, Heiko St?bner wrote:
>> Am Mittwoch, 3. Mai 2017, 10:56:24 CEST schrieb Guillaume Tucker:
>>> The ARM Mali Midgard GPU kernel driver is only available
>>> out-of-tree and is not going to be merged in its current form.
>>> However, it would be useful to have its device tree bindings
>>> merged.  In particular, this would enable distributions to create
>>> working driver packages (dkms...) without having to patch the
>>> kernel.
>>>
>>> The bindings for the earlier Mali Utgard GPU family have already
>>> been merged, so this is essentially the same scenario but for
>>> newer GPUs (Mali-T604 ~ Mali-T880).
>>>
>>> This series of patches first imports the bindings from the latest
>>> driver release with some clean-up then adds a gpu node for the
>>> rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
>>> Firefly, Veyron Minnie and Jerry boards using Mali kernel driver
>>> r16p0 and r12p0 user-space binary.
> I won't suggest such combine. We meet some problems at mali 400 serial.
> I would suggest the kernel version would match the user library.

Well, I can test it again with r12p0 kernel driver (out-of-tree)
if you want.  The user-space driver checks the version of the
kernel driver and gives up if it's not compatible.  With Midgard,
there's a range of versions that maintain kernel/userspace
compatibility unlike Utgard and older Midgard releases where they
had to exactly match.  Again, if there was a mismatch then the
user-space would fail to initialise and report an error.

> Also please notice there is rk3288w, the hardware version becomes r1p0.

Sounds like a new SoC?  Does rk3288w affect rk3288 in any way?

Unless it's a special case, it seems to me that any new SoC with
a Midgard GPU would need an extra vendor compatible string in the
binding documentation and maybe a separate gpu dt node.

>> The actual devicetree parts are all Rockchip-specific, so I guess I'll just
>> pick up the whole series, including the binding doc, after the merge
>> window if nobody complains before that :-)

Thanks!


Guillaume
