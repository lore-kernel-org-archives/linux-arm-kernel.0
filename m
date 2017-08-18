From: nm@ti.com (Nishanth Menon)
Date: Fri, 18 Aug 2017 17:27:08 -0500
Subject: [PATCH 3/3] ARM: OMAP5: Enable CPU off idle states
In-Reply-To: <20170818152600.GE6008@atomide.com>
References: <20170817230122.30655-1-tony@atomide.com>
 <20170817230122.30655-4-tony@atomide.com>
 <c31a90c4-8dbe-926a-831c-5fac92ebae80@ti.com>
 <20170818152600.GE6008@atomide.com>
Message-ID: <77854a91-80f0-3622-93a2-2eefe1e8b1aa@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2017 10:26 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [170817 18:30]:
>> On 08/17/2017 06:01 PM, Tony Lindgren wrote:
>>> With the idle code in place needed for supporting off mode for cpus,
>>> let's enable it. This seems to save about 0.2W of power compared to
>>> CPU retention states based on quick measurement on omap5-uevm.
>>
>> That makes sense since the Silicon you probably have is pre-production
>> silicon.
> 
> It seems to be es2.0, the measurement was just based on a glance
> of the power supply after rmmod of ehci-omap and ohci-platform
> modules.

yeah -> ES2.0 did have two stages prior to being approved for production.

> 
>> unfortunately, you have been looking at some preproduction code which was
>> being developed prior to the silicon going into production (also the reason
>> why I have'nt upstreamed those changes).
> 
> Oh I did not know that, I was just looking at the old
> ti-linux-3-8-y-kernel that the igepv5 kernel tree is
> based on.
> 

unfortunately so.

>> unfortunately, I have to NAK this patch.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f5dc91b691cf296c49aedf0a671fd659a70f737
>> as per Technical Reference Manual SWPU282AF?May 2012?Revised August 2016,
>> PM_MPU_PWRSTCTRL can only support: ON INA, RET. (CSWR only).
>>
>> Same applies to CPUs as well. which was the reason in the first place for me
>> to send the patch upstream.
> 
> OK, is there some hardware errata issued on that?

To my knowledge, errata is only when TRM is not updated (feature that 
is supposed to work, but does'nt). TRM's version history indicates 
descope. At least to my information all production customers should 
have been informed about this as well.

> 
> I also noticed these patches won't work when booted with LPAE
> enabled kernel for some reason.
> 

Obviously, I dont think I am interested in chasing any further down 
this road. SoC descope is a severe decision that has been taken after 
a lot of internal and  customer considerations. there is no point in 
trying to enable a descoped feature when even if it worked on 10 
boards means nothing from a production device perspective, and there 
are devices out there in production with OMAP5.


-- 
Regards,
Nishanth Menon
