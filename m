From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 28 Mar 2015 11:53:06 +0000
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <551538AB.50207@redhat.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
Message-ID: <55169622.5070007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/15 11:02, Hans de Goede wrote:
> Hi Iain,
> 
> On 27-03-15 11:58, Iain Paton wrote:
>> add pmic regulator definitions matching the manufacturers 3.4.x fex
>> file.
>>
>> Signed-off-by: Iain Paton <ipaton0@gmail.com>
>> ---
>>
>> As this file belongs to Hans and he decided not to use axp209.dtsi in
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315612.html
>> then I won't add it here.
> 
> That was because using it was breaking stuff, but now that we know better
> which regulators are used for what, and which one we most add an always-on;
> property too, I would greatly prefer you to acually use axp209.dtsi, see
> e.g. the sun5i-a13-utoo-p66.dts file where I'm using it.
> 
> Can you please respin this patch using axp209.dtsi?
> 
> Also please do not add nodes for unused regulators, like the ldo-s for the csi-s.

You would prefer that the csi is broken on the lime then?  Unlike the cubieboards, 
ldo3 & ldo4 really are used on the olimex boards. So it seems that as yet you still 
don't know enough about which regulators are used, or you wouldn't be asking for 
that.

That's the major disadvantage of axp209.dtsi, the regulator node isn't describing 
the pmic at all. Instead it's describing the stuff connected to the pmic outputs, 
which is undeniably board specific and therefore totally unsuitable for a generic
file. Leading to every board needing to override everything regardless.

So no, I'm not going to respin the patch. I strongly believe using axp209.dtsi is 
the wrong thing to do here.
If that means the patch doesn't make it in, then so be it.

Rgds,
Iain
