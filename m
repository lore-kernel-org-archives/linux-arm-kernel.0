From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 25 Aug 2015 09:21:51 +0800
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
 <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
Message-ID: <55DBC32F.4040607@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/8/24 22:48, Rob Herring ??:
> On Mon, Aug 24, 2015 at 7:57 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
>>> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>>>> +       -analogix,color-depth:
>>>> +               number of bits per colour component.
>>>> +                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
>>> This seems pretty generic. Just use 6, 8, 10, or 12 for values. And
>>> drop the vendor prefix.
>> Please think about this some more.  What does "color-depth" mean?  Does it
>> mean the number of bits per colour _component_, or does it mean the total
>> number of bits to represent a particular colour.  It's confusing as it
>> stands.
> Then "component-color-bpp" perhaps?

Actually this "color-bpp" should come from crtc driver, maybe should 
come from
"struct drm_crtc {".

Like rockchip stuffs, analogix_dp-rockchip call an mode_config from 
rockchip_drm_vop
driver and set output mode to RGB[10:10:10], then vop driver just store 
the output mode
type to the private struct "vop->connecot_out_mode". do think that this 
outmode should
store into crtc, not just come from DT prop.

- Yakir
