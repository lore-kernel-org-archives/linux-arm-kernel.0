From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 11:42:19 -0600
Subject: [PATCH] ARM: tegra: rebuild tegra_defconfig
In-Reply-To: <7367180.OaP1fIIt8z@ax5200p>
References: <1369761972-31986-1-git-send-email-swarren@wwwdotorg.org>
 <2234363.J239kID5LN@fb07-iapwap2.physik.uni-giessen.de>
 <51A61EEC.5040300@wwwdotorg.org> <7367180.OaP1fIIt8z@ax5200p>
Message-ID: <51A63DFB.3010206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 11:30 AM, Marc Dietrich wrote:
> On Wednesday 29 May 2013 09:29:48 Stephen Warren wrote:
>> On 05/29/2013 07:38 AM, Marc Dietrich wrote:
>>> Am Dienstag, 28. Mai 2013, 15:30:29 schrieb Stephen Warren:
>>>> On 05/28/2013 11:26 AM, Stephen Warren wrote:
>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>
>>>>> This simply rebuilds tegra_defconfig on top of next-20130520. As such,
>>>>> it
>>>>> should introduce no changes; simply moving entries around due to Kconfig
>>>>> ordering changes. The apparent exceptions are:
...
>>> This way we would have a
>>> better chance to have a zero diff between defconfig and tegra_defconfig,
>>> e.g. not like 3.10 is now.
>>
>> I don't understand this; what is "defconfig" if not "tegra_defconfig"?
> 
> defconfig: make tegra_defconfig; make saveconfig
> 
> diff -u tegra_defconfig defconfig

Oh right. Yes, if you do that in the for-3.11/defconfig branch itself,
there will be diffs.

That will always be true; that branch won't have any of the new
drivers/features that will be added in linux-next and the next mainline
kernel, so at the very least you'd end up removing some options doing that.

I expect most people editing defconfig will be doing it based on some
linux-next version rather than right on top of for-3.11/defconfig, so
they can pick up, enable, and test new drivers or features. If you run
the commands above in next-20130529, there should be a zero diff (unless
someone made some Kconfig changes between
next-20130528 and next-20130529 anyway).
