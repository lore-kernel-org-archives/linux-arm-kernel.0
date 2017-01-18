From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 14:49:55 -0800
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
In-Reply-To: <20170118223948.GR27312@n2100.armlinux.org.uk>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170117232314.GI27312@n2100.armlinux.org.uk>
 <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
 <20170118223948.GR27312@n2100.armlinux.org.uk>
Message-ID: <c91c2cc7-d516-2dec-ccd8-9b36b6644f24@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 02:39 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 17, 2017 at 03:39:45PM -0800, Florian Fainelli wrote:
>> Well, for one it's inconsistent, and it also leaves room for subtle
>> timing/caching issues with some platforms (OK, maybe not so much).
>> Improving the speed and consistency was the primary motive.
> 
> Actually, it's not as inconsistent as you claim.
> 
> c68b0274fb3c ("ARM: reduce "Booted secondary processor" message to debug level")
> dropped the corresponding pr_info() in the bringup path to debug level,
> so to be consistent, this one should be dropped to debug level too.
> 
> Removing it arguably makes it more inconsistent!

OK, fair point, I missed that one.

> 
> So, I'd be willing to accept a patch lowering this to a pr_debug()
> to make it more consistent with the bringup path, but otherwise the
> consistency argument doesn't really stand.

Sounds good, thanks!
-- 
Florian
