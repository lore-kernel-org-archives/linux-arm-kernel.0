From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 9 Oct 2013 13:59:46 +0900
Subject: [PATCH v2 3/3] ARM: shmobile: kzm9d: Use common clock framework
In-Reply-To: <20131009034057.GO15065@verge.net.au>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
 <20131009034057.GO15065@verge.net.au>
Message-ID: <CANqRtoQs+31mv0ZULOd3SGshkBkvp-kGoaVOSb10+Ncdp+WNXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Oct 9, 2013 at 12:40 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Oct 08, 2013 at 02:34:03PM +0900, takasi-y at ops.dti.ne.jp wrote:
>> Use common clock framework version of clock
>>  drivers/clk/shmobile/clk-emev2.c
>> instead of sh-clkfwk version
>>  arch/arm/mach-shmobile/clock-emev2.c
>> when it is configured as a part of multi-platform.
>>
>> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>
> Thanks.
>
> I plan to add this patch to a new topic branch,
> topic/emev2-common-clock, in the renesas tree and
> queue it up from there for inclusion in mainline
> if/when the first patch of this series is accepted
> by Mike Turquette.

Thanks for picking up patches, Simon.

I think you can simply merge this patch after the following series:

[PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update

There are no build time dependencies on patch 1 and 2 so this patch
can be merged independently. Regarding run-time operation, the
multiplatform series above makes KZM9D DT reference only build for
multiplatform, and in such case CCF is required.

So if you want to keep KZM9D DT reference working until Mike Turquette
accepts the CCF bits, then I recommend you to wait with "[PATCH 00/05]
ARM: shmobile: KZM9D Multiplatform update" until all EMEV2 CCF bits
have been merged.

Another way is to merge "[PATCH 00/05] ARM: shmobile: KZM9D
Multiplatform update" before the EMEV2 CCF bits, but if so you may as
well merge this patch as well IMO. This
multiplatform-update-series-merge-before-CCF plan will result in
untestable KZM9D DT reference until EMEV2 CCF is merged. Either way is
fine with me.

Cheers,

/ magnus
