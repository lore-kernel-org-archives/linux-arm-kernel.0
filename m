From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 Jan 2013 13:13:19 -0800
Subject: [PATCH] ARM: sunxi: fix struct sys_timer removal
In-Reply-To: <50EC6FBC.2030100@free-electrons.com>
References: <1357666417-8803-1-git-send-email-swarren@wwwdotorg.org>
 <50EC6FBC.2030100@free-electrons.com>
Message-ID: <CAOesGMjWPvbhu0RVo5skcFTwTaqz=cLmjjduCiA+ZS9hwRpEjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 11:13 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Stephen,
>
> On 08/01/2013 18:33, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Commit 6bb27d7 "ARM: delete struct sys_timer" removed struct sys_timer,
>> but didn't update mach-sunxi/sunxi.c for this change, even though the
>> sunxi timer implementation itself was updated. This caused a build break:
>>
>> arch/arm/mach-sunxi/sunxi.c:94:2: error: unknown field 'timer' specified in initializer
>> arch/arm/mach-sunxi/sunxi.c:94:12: error: 'sunxi_timer' undeclared here (not in a function)
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Ideally, this commit would be squashed into 6bb27d7 in arm-soc's
>> timer-cleanup branch. However, that would change a few commit IDs, and
>> I've already pulled that branch into the Tegra and bcm2835 trees. I can
>> rebase those without issue if we co-ordinate so all the changes go into
>> the same linux-next version.
>>
>> However, since sunxi isn't actually enabled in any defconfig until
>> v3.8-rc2, perhaps it's OK to apply this change as a separate patch on
>> top of timer-rework, and ignore the bisect issue?
>
> I'm fine with having it as a follow-up patch.
>
> Also, you can add my
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Since I assume that Olof will apply this directly?

Yep, sorry I missed the reply -- I've already applied it actually.
Should show up in next linux-next.


-Olof
