From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 12 Aug 2015 15:37:27 +0200
Subject: [linux-sunxi] [PATCH 3/3] mmc: sunxi: use controller automatic
 clock gating.
In-Reply-To: <55CB47D8.4010207@schinagl.nl>
References: <cover.1439381423.git.hramrach@gmail.com>
 <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com>
 <55CB3D92.6040403@redhat.com> <55CB47D8.4010207@schinagl.nl>
Message-ID: <CAOMqctSdkPgDfBCNsGNsNnoh4GqVW59oZC3q9HX3gY_NneMPKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2015 at 15:19, Olliver Schinagl <oliver+list@schinagl.nl> wrote:
> Hey,
>
> On 12-08-15 14:35, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 12-08-15 14:23, Michal Suchanek wrote:
>>>
>>> When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
>>> automatic hardware controlled clock gating on the mmc interface.
>>>
>>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>
>>
>> In general this looks good, but I wonder how intensively this has
>> been tested ?
>
> It doesn't matter actually, it took some time longer, but the mmc still
> craps out even with Michal's 3 patches. I'll revert hans's earlier patch
> again and do a bit more extensive testing.

Does the oclk switch timeout even after 750ms?

In some earlier tests I tried to enable/disable the clock repeatedly
when it failed but it seemed to have little effect on the total time
it took to disable the clock in the end.

Maybe it would be worh trying to set the timeout to some insanely long
value and test stability with that. I picked 750 as around twice the
maximum time it ever took on my board.

Thanks

Michal
