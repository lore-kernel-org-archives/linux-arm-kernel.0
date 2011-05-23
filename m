From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Mon, 23 May 2011 10:10:53 +0530
Subject: [PATCH V4] OMAP3+: SR Layer Cleanup
In-Reply-To: <4DD67155.1030705@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
	<4DD67155.1030705@ti.com>
Message-ID: <BANLkTi=ufSmtnEkyRFKOpbTAJkcUW1dXYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Fri, May 20, 2011 at 7:19 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Shweta,
>
> On 5/13/2011 8:27 AM, Gulati, Shweta wrote:
>>
>> To set sr ntarget values ?for all volt_domain,
>> volt_table is retrieved by doing a look_up of 'vdd_name'
>> field from omap_hwmod but voltage domain pointer does not
>> belong to omap_hwmod and is not used anywhere else.
>> As a part of voltage layer and SR Layer clean up volt
>> pointer is removed from omap_hwmod and added in dev
>> attributes of SR.
>>
>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>
>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>> Acked by: Nishanth Menon<nm@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> ---
>>
>> V4:
>> ? Fixed comments like checking for NULL pointers
>> ? and following conventions in naming the instances
>> ? recommended by Todd Poynor and Benoit Cousson.
>
> It looks like you missed at least two comments I did on the previous version
> whereas you did agree to fix them.
You told me to move smartrefex_xxxx_dev_attr above
omap44xx_smartreflex_XXX_hwmod struct,
which is already in that order and the other thing you suggested was
to move .dev_attr before .slaves,
that I have not done explaining that, to follow the standard as in all
defined hwmod struct .dev_attr are placed after .slaves.
> Thanks,
> Benoit
>



-- 
Thanks,
Regards,
Shweta
