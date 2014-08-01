From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 01 Aug 2014 22:44:50 +0200
Subject: [PATCH v5 03/10] ARM: dts: Clean up exynos5250-snow
In-Reply-To: <CAD=FV=W2XJzv4NpB=27AFjX94VkH8dYXxAPBL58ntXL2WvRCoQ@mail.gmail.com>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>	<1406868897-26874-4-git-send-email-afaerber@suse.de>
 <CAD=FV=W2XJzv4NpB=27AFjX94VkH8dYXxAPBL58ntXL2WvRCoQ@mail.gmail.com>
Message-ID: <53DBFC42.6030205@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.08.2014 22:24, schrieb Doug Anderson:
> Andreas,
> 
> On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Use the new style of referencing inherited nodes and use symbolic names.
>> Reorder one pinctrl node in GPIO order.
>>
>> Goal is the alignment of all exynos5250 based device trees for comparison.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v4 -> v5:
>>  * Introduced labels to consistently use new referencing style (Tomasz)
>>  * Use IRQ_TYPE_* constants
>>  * Use some more GPIO_ACTIVE_*
>>
>>  v3 -> v4: Unchanged
>>
>>  v3: New (Doug Anderson)
>>
>>  arch/arm/boot/dts/exynos5250-snow.dts | 291 +++++++++++++++++-----------------
>>  arch/arm/boot/dts/exynos5250.dtsi     |  20 +--
> 
> As much as possible it's nice to touch the main exynos dtsi file and
> specific board files in different patches.  Among other things it
> makes backporting the patch and resolving merge conflicts easier (if
> someone doesn't care about snow they could just pick up the main dtsi,
> for instance).
> 
> I'm not a total stickler and I'd love to see this land quickly to
> avoid conflicts, though...
> 
> 
>> +&sd3_clk {
>> +       samsung,pin-drv = <0>;
>> +};
>> +
>> +&sd3_cmd {
>> +       samsung,pin-pud = <3>;
>> +       samsung,pin-drv = <0>;
>> +};
>> +
>> +&sd3_bus4 {
> 
> Itty bitty bitty nit that "bus" sorts alphabetically above "clk".  ;)

True. I guess I just reused the original order from within pinctrl.

> Maybe Kukjin would be willing to sort these when he applies?
>
>
> Thank you for all your hard work on this one.  Things look MUCH MUCH
> nicer!  I did a pretty thorough review of your changes and it all
> looks good.
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>

I need to respin anyway for a .dtsi label, so I can factor this out
while at it.

Patches 1-2 could meanwhile already be applied by Kukjin.

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
