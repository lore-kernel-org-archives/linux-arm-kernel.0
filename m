From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 6 Nov 2015 14:36:25 -0800
Subject: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
In-Reply-To: <20151107091925.7dcd14a7@canb.auug.org.au>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
 <20151107091925.7dcd14a7@canb.auug.org.au>
Message-ID: <CAMAWPa8Fw8J45QEs-bEOqgRUp3_YYHmFEU_ZcZgrCLmAH095fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Nov 6, 2015 at 2:19 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Fri, 6 Nov 2015 10:36:34 -0800 Kevin Hilman <khilman@kernel.org> wrote:
>>
>> On Fri, Nov 6, 2015 at 8:13 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> > This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
>> > which breaks the omap3 device tree build due to a wrong reference.
>> >
>> > I accidently queued this change via the power supply subsystem while
>> > telling Marek at the same time, that it should go through Tony's tree.
>> > Following that I did miss Stephen's messages about the build failure in
>> > linux-next and since he switched to merging an older snapshot nobody
>> > else noticed the problem in my tree. I didn't notice myself, since I
>> > did not build any device tree files assuming none have changed by me.
>> >
>> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
>>
>> We also found this in kernelci.org build testing, and verified that
>> this fixes the build.
>>
>> Tested-by: Kevin Hilman <khilman@linaro.org>
>>
>> Thanks Felipe for reporting, and thanks Sebastian for the quick fix.
>
> I think "quick fix" is a bit rich.

You're right, sorry.  I didn't have the full context.  I wasn't fully
aware of the history in -next of this problem.  I just found it when
it ended up in mainline.  I don't think the problem was not getting
your emails, looks like the problem was a major disconnect between
what was sent to Linus and what was in -next. :(

Hopefully this snafu will help prevent that in the future,

Kevin
