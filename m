From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Aug 2013 16:03:23 +0900
Subject: [PATCH 10/14] ARM: shmobile: Rename to emev2_init_early(),
 use smp_set_ops()
In-Reply-To: <10195347.M6JWNyZrex@avalon>
References: <20130809094748.6530.16511.sendpatchset@w520>
 <20130809094936.6530.31840.sendpatchset@w520>
 <10195347.M6JWNyZrex@avalon>
Message-ID: <CANqRtoQSEdam-_VYuo2ECHk4f9JzJ69xdc==U+JZF-7AOcQJQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Aug 9, 2013 at 7:41 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Friday 09 August 2013 18:49:36 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Rename emev2_init_delay() into emev2_init_early()
>> to make the function name show that more than just
>> delay setup will happen.
>>
>> Also, instead of specifying the smp ops in DT_MACHINE
>> convert the EMEV2 SoC code to install the smp ops
>> from emev2_init_early().
>
> Could you please explain in the commit message why this is needed ? Same
> comment for the other patches in this series.

I personally think it is neat to use as few callbacks as possible in
the DT_MACHINE. Hooking in SMP ops in ->init_early() means that the
boards now are unaware if SMP is used or not - and it makes sense to
me to write board code that is independent of SMP.

Anyway, I suspect that Olof prefers to use smp_ops() instead, so I
think these patches just should be dropped.

Cheers,
/ magnus
