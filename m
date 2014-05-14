From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 14 May 2014 16:09:46 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <1509906.x9u0HJ6AbJ@avalon>
References: <20140511232508.20177.11556.sendpatchset@w520>
 <1509906.x9u0HJ6AbJ@avalon>
Message-ID: <CANqRtoQxGcTUvU1qAcJTy8ONPNmcx5CBNcrXASoMCVpAyOAfqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, May 13, 2014 at 5:00 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Monday 12 May 2014 08:25:08 Magnus Damm wrote:
>> ARM: shmobile: Use shmobile_init_delay() on r8a7791
>>
>> [PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case
>> [PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
>> [PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()
>>
>> Convert r8a7791 to rely on shmobile_init_delay() instead of using a per-SoC
>> delay setup function.
>
> I'm afraid this patch set causes a boot time and CPU load regression on
> Koelsch. With Simon's latest devel branch which has the patches applied, the
> kernel boot time (using koelsch_defconfig) up to the point where the kernel
> tries to connect to the DHCP server is 17.898437s. The CPU load (as reported
> by top) on an idle system is then around 33%, spent in [kworker/0:1]. If I
> revert the patches the same time goes down to 1.921875s and the CPU load on an
> idle system is close to 0.

Thanks for testing and reporting this! I believe Simon has posted a
fix for this issue which is related to MHz vs Hz bug introduced by me
in function shmobile_init_delay(). Things should be in order now.

Cheers,

/ magnus
