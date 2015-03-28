From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Mar 2015 00:50:57 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <55169622.5070007@gmail.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com>
Message-ID: <55173E61.6040408@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/28/2015 12:53 PM, Iain Paton wrote:
> On 27/03/15 11:02, Hans de Goede wrote:
>> Hi Iain,
>>
>> On 27-03-15 11:58, Iain Paton wrote:
>>> add pmic regulator definitions matching the manufacturers 3.4.x fex
>>> file.
>>>
>>> Signed-off-by: Iain Paton <ipaton0@gmail.com>
>>> ---
>>>
>>> As this file belongs to Hans and he decided not to use axp209.dtsi in
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315612.html
>>> then I won't add it here.
>>
>> That was because using it was breaking stuff, but now that we know better
>> which regulators are used for what, and which one we most add an always-on;
>> property too, I would greatly prefer you to acually use axp209.dtsi, see
>> e.g. the sun5i-a13-utoo-p66.dts file where I'm using it.
>>
>> Can you please respin this patch using axp209.dtsi?
>>
>> Also please do not add nodes for unused regulators, like the ldo-s for the csi-s.
>
> You would prefer that the csi is broken on the lime then?  Unlike the cubieboards,
> ldo3 & ldo4 really are used on the olimex boards.

So your olimex boards have camera sensors attached? Because if not then csi is not
used at all.

> So it seems that as yet you still
> don't know enough about which regulators are used, or you wouldn't be asking for
> that.

It would seem that you do not know what csi is for ...

> That's the major disadvantage of axp209.dtsi, the regulator node isn't describing
> the pmic at all. Instead it's describing the stuff connected to the pmic outputs,

Not it is not, not anymore it is just a skeleton creating the regulator nodes
so that you can address them by reference as is now the norm for configuring
nodes in a dts. Have you actually looked at the current axp209.dtsi it does
not contain any assumptions about how the regulators are used.

> which is undeniably board specific and therefore totally unsuitable for a generic
> file. Leading to every board needing to override everything regardless.
>
> So no, I'm not going to respin the patch. I strongly believe using axp209.dtsi is
> the wrong thing to do here.
> If that means the patch doesn't make it in, then so be it.

Please take a look at sun5i-a13-utoo-p66.dts, if you do something
similar like that, then ldo 3 and 4 will get disabled, please run
some tests this way, then I expect that you will see that everything still
works fine without them enabled, and if not you can easily enable them the
same way the other regulators are enabled in sun5i-a13-utoo-p66.dts

Regards,

Hans
