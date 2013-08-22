From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 07:59:34 -0700
Subject: [GIT PULL 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <20130822144242.GI30533@S2101-09.ap.freescale.net>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-2-git-send-email-shawn.guo@linaro.org>
 <87li3tvnj8.fsf@linaro.org>
 <20130822144242.GI30533@S2101-09.ap.freescale.net>
Message-ID: <CAGa+x84dqBvSsPicz_cCuWjK_XpZUd-zCYanW785eEkvrUVX_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 7:42 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Aug 22, 2013 at 06:54:35AM -0700, Kevin Hilman wrote:
>> Shawn Guo <shawn.guo@linaro.org> writes:
>>
>> > The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
>> >
>> >   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.12
>> >
>> > for you to fetch changes up to 0c383e6a56c2e70db9f2a68f9fe095645f11c151:
>> >
>> >   phy: micrel: Add definitions for common Micrel PHY registers (2013-08-18 09:30:39 +0800)
>> >
>> > ----------------------------------------------------------------
>> > It contains a bunch of imx soc updates for 3.12.
>> >
>> > - Add more ethernet phy fixups for imx6 boards
>> > - Add some missing imx6q clocks into clock driver
>> > - Add new clock types fixup mux and div to work around some ugly
>> >   hardware defect
>> > - Consolidate L2 cache initialization function, so that it can be used
>> >   on more i.MX SoCs
>> > - Replace magic numbers in mach-imx6q.c with well defined macros
>> > - Support low-level debug for vybrid
>>
>> This patch causes a conflict with Russell's DEBUG_LL cleanup, which is
>> already in linux-next.
>
> The vybrid patch is already in linux-next as well.  And conflict was
> reported and solved by Stephen one month ago [1].
>
> From the past experience, such trivial conflict with other tree is
> allowed by arm-soc folks, and they will ask Linus to take care of it
> when sending patches upstream.  But ...

Yes, the conflict is trivial, but having seen several similar ones
this merge window, it's getting kinda old.  Also, I'm not crazy about
having Linus see several merge conflicts to the same area.  He'll see
that arm-soc folks are not properly coordinating things with Russell
and IMO that's something we need to fix in ARM land, not expose it to
Linus.

Also, in the future, if you're already aware of merge conflicts in
-next in a branch you're submitting for a pull request, it would be
*very* helpful to mention that in the pull request.

>> For v3.12, I suggest you drop this patch and rework your new DEBUG_LL
>> support on top of Russell's cleanup.
>
> ... I'm also fine with your suggestion.

Thanks.

>> Have a look at that and see if you
>> can reuse the the generic 8250 stuff added by Russell.
>
> Seems not.
>
>> While there, you
>> might look at imx.S as well.
>
> I think Russell would have converted it if it can reuse 8250 stuff.

OK, thanks for checking.

>>
>> If that's OK with you, can you send an updated pull request without the
>> DEBUG_LL changes?  The other changes look OK for v3.12.
>
> Okay, will send you an updated pull request without DEBUG_LL changes.

Thanks.

> Shawn
>
> [1] https://lkml.org/lkml/2013/6/3/22

Seems this is an unrelated conflict to the one I was seeing in Kconfig.debug

Kevin
