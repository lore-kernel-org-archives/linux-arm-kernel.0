From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Apr 2018 11:49:35 -0700
Subject: [PATCH v7 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
In-Reply-To: <ab754711-f727-133c-7bc3-a9f3243c2278@amlogic.com> (Yixun Lan's
 message of "Fri, 27 Apr 2018 20:33:42 +0800")
References: <20180426084437.192394-1-yixun.lan@amlogic.com>
 <1524820841.4026.112.camel@baylibre.com>
 <fbd24a73-6793-76be-3ca5-04cbac5db198@amlogic.com>
 <1524823154.4026.123.camel@baylibre.com>
 <ab754711-f727-133c-7bc3-a9f3243c2278@amlogic.com>
Message-ID: <7hsh7g1o3k.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

Yixun Lan <yixun.lan@amlogic.com> writes:

> On 04/27/2018 05:59 PM, Jerome Brunet wrote:

[...]

>> 
>> Looks to be the problem indeed. But it is still an issue with how your patchset
>> in organized.
>> 
>> I can't merge this until Kevin merges the patch above, which he can't merge
>> until there is the clkc_ao support in axg, which is given by this series.
>> 
>> 1# You should remove the axg part of the patch above. Kevin will be able to
>> merge it w/o any dependencies. (BTW, the patch is broken for axg because 1) you
>> did not include the dt-binding header for the clkc_ao in axg and 2) the clkc_ao
>> does not exist at this stage)
>> 2# I can then safely merge this series - w/o breaking gxbb and gxl.
>> 3# Finally you'll have to make a DT change for the axg, enabling the clkc_ao and
>> changes the uart clocks at the same time.
>> 
>
>   I didn't make myself clear in previous email
>
>   I mean, could you merge patch 1-6, just exclude the patch 7
> then kevin can merge the DT part (there are three patches) [1]
> after the DT patches merged, then you can take this patch 7
> This way, it won't break gxl or any other SoCs
>
>   I'm sending patch 7 along with this series, it would be better if I
> give a warning about it.

Your proposal requires extra work from a couple different maintainers to
track all the dependencies, and is very error prone.  Sometimes
maintainers may do this for you if they have time and are feeling
generous, but you will have much more success if you can ease the
process.

Jerome has provided lots of guidance throughout this series and just
above has provided you with a very good proposal above which minimizes
the dependencies, and provides the changes in the right order.

Please follow Jerome's suggestion,

Thanks,

Kevin
