From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 09:29:48 -0600
Subject: [PATCH] ARM: tegra: rebuild tegra_defconfig
In-Reply-To: <2234363.J239kID5LN@fb07-iapwap2.physik.uni-giessen.de>
References: <1369761972-31986-1-git-send-email-swarren@wwwdotorg.org>
 <51A521F5.2010206@wwwdotorg.org>
 <2234363.J239kID5LN@fb07-iapwap2.physik.uni-giessen.de>
Message-ID: <51A61EEC.5040300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 07:38 AM, Marc Dietrich wrote:
> Am Dienstag, 28. Mai 2013, 15:30:29 schrieb Stephen Warren:
>> On 05/28/2013 11:26 AM, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> This simply rebuilds tegra_defconfig on top of next-20130520. As such, it
>>> should introduce no changes; simply moving entries around due to Kconfig
>>> ordering changes. The apparent exceptions are:
>>>
>>> AUTO_ZRELADDR: Selected by ARM multi-platform support.
>>> MTD_CHAR: Removed in Kconfig.
>>>
>>> This should make it easier to create future defconfig patches on top of
>>> linux-next, since all the extraneous diffs have been removed. It also
>>> makes it more likely that once 3.12 comes around, this defconfig will
>>> already match what's required there.
>>
>> I've applied this (squashed it into) Tegra's for-3.11/defconfig branch.
> 
> wouldn't it make more sense to apply such a patch just before the merge window 
> closes (or better after some release candidate)?

Perhaps. It probably also depends a lot on when Kconfig changes get
applied in other areas as far as when it makes sense. I deferred it this
time around in order to pick up some tegra_defconfig changes that made
it into 3.10-rc3.

> This way we would have a 
> better chance to have a zero diff between defconfig and tegra_defconfig, e.g. 
> not like 3.10 is now.

I don't understand this; what is "defconfig" if not "tegra_defconfig"?
