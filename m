From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 19:00:05 +0900
Subject: [PATCH] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <20130724084637.GA5774@verge.net.au>
References: <20130724073042.28351.33041.sendpatchset@w520>
 <20130724073952.GD17045@verge.net.au>
 <20130724084637.GA5774@verge.net.au>
Message-ID: <CANqRtoT46LimTXt4mihFJS-DDpXOu5wONVX3yWwt=sr9SDvnsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Jul 24, 2013 at 5:46 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jul 24, 2013 at 04:39:53PM +0900, Simon Horman wrote:
>> On Wed, Jul 24, 2013 at 04:30:42PM +0900, Magnus Damm wrote:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > Convert the marzen board to use DT_MACHINE_START. With this in
>> > place all mach-shmobile boards use DT_MACHINE_START. Also, this
>> > makes it possible for the r8a7779 SMP code to use DT for CPUs.
>> >
>> > So appended DTB is the way forward on this board.
>>
>> Please supply a patch to update the defconfig accordingly.
>
> In the course of testing this patch I created
> a patch to update the defconfig. I will post it with
> a patch to use DT for SMP but I have some questions about this patch.
>
> It seems to me that the following is also needed:
>
> * Select USE_OF in Kconfig
> * Provide dt_compat in DT_MACHINE_START
> * Provide r8a7779-marzen dts
>
> I have a revised version of this patch which does the above.
> But I wanted to check with you that I am on the right track
> before posting it.

Yes, you are correct. It seems that I was (am) too trigger happy.
Thanks for fixing these.

> Also, I think that once sh73a0 and r8a7779 uses DT for SMP we can remove
> shmobile_smp_init_cpus(). As you have posted a patch for sh73a0 I have
> prepated a patch for r8a7779 I have also prepared a patch to remove
> shmobile_smp_init_cpus().

I think we should remove that function, but I'd like to put some
shared code in the same file. So I don't want to remove the file.
Perhaps the easiest is to leave it as-is for now and let me deal with
that in an upcoming series.

> My plan is to post all relevant patches as a series once
> my questions above are resolved.

Sounds good, thanks for your help!

Thanks,

/ magnus
