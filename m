From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Mon, 30 Jan 2017 19:05:31 +0200
Subject: [PATCH V7 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <20170128141646.GA21291@collabora.com>
References: <cover.1483301745.git.peter.senna@collabora.com>
 <4232c88a99f44a24287d04d74b891e2eb139864c.1483301745.git.peter.senna@collabora.com>
 <759f96e2-43da-45ba-cf8d-55bc1f6e8442@codeaurora.org>
 <20170128141646.GA21291@collabora.com>
Message-ID: <877f5ciilg.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Jan 2017, Peter Senna Tschudin <peter.senna@collabora.com> wrote:
> On Thu, Jan 05, 2017 at 01:18:47PM +0530, Archit Taneja wrote:
> Hi Archit,
>
> Thank you for the comments!
>
> [...]
>> > +	total_size = (block[EDID_EXT_BLOCK_CNT] + 1) * EDID_LENGTH;
>> > +	if (total_size > EDID_LENGTH) {
>> > +		kfree(block);
>> > +		block = kmalloc(total_size, GFP_KERNEL);
>> > +		if (!block)
>> > +			return NULL;
>> > +
>> > +		/* Yes, read the entire buffer, and do not skip the first
>> > +		 * EDID_LENGTH bytes.
>> > +		 */
>> 
>> Is this the reason why you aren't using drm_do_get_edid()?
>
> Yes, for some hw specific reason, it is necessary to read the entire
> EDID buffer starting from 0, not block by block.

Hrmh, I'm planning on moving the edid override and firmware edid
mechanisms at the drm_do_get_edid() level to be able to truly and
transparently use a different edid. Currently, they're only used for
modes, really, and lead to some info retrieved from overrides, some from
the real edid. This kind of hacks will bypass the override/firmware edid
mechanisms then too. :(

BR,
Jani.


>
> [...]
>
> I fixed all your other suggestions. Thank you!
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Technology Center
