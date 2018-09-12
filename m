From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 12 Sep 2018 09:56:49 +0200
Subject: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <20180912072347.nqw4uu23fykjtz72@flea>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr> <20180911124625.6759e429@coco.lan>
 <20180912072347.nqw4uu23fykjtz72@flea>
Message-ID: <17cad39d-cc81-164c-58a2-00ea7d1f96b3@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2018 09:23 AM, Maxime Ripard wrote:
> On Tue, Sep 11, 2018 at 12:46:25PM -0300, Mauro Carvalho Chehab wrote:
>> Em Fri,  7 Sep 2018 00:24:38 +0200
>> Paul Kocialkowski <contact@paulk.fr> escreveu:
>>
>>> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>>
>>> This introduces the Cedrus VPU driver that supports the VPU found in
>>> Allwinner SoCs, also known as Video Engine. It is implemented through
>>> a V4L2 M2M decoder device and a media device (used for media requests).
>>> So far, it only supports MPEG-2 decoding.
>>>
>>> Since this VPU is stateless, synchronization with media requests is
>>> required in order to ensure consistency between frame headers that
>>> contain metadata about the frame to process and the raw slice data that
>>> is used to generate the frame.
>>>
>>> This driver was made possible thanks to the long-standing effort
>>> carried out by the linux-sunxi community in the interest of reverse
>>> engineering, documenting and implementing support for the Allwinner VPU.
>>>
>>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> There are several checkpatch issues here. Ok, some can be
>> ignored, but there are at least some of them that sounda relevant.
> 
> Sorry for that. Given that it's intended to be in staging, do you want
> us to send subsequent patches or the whole serie?

I would actually prefer a v10 with the current follow-up patches merged
into the main driver. I'm getting kbuild errors for the Kconfig missing
select and the PHYS_PFN_OFFSET. So let's just spin a v10.

It would help if you post a follow-up patch for the checkpatch changes
(that's easy to review), then post a v10 with just that and the other
follow-on patches merged into the driver patch itself, and that's
what I'll use for the pull request.

Sorry, I should have seen those checkpatch.pl warnings myself, but I
discovered that my git hooks didn't use the --strict option with
checkpatch. I'd have sworn that I had added it in the past, but apparently
not :-(

Regards,

	Hans
