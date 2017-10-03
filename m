From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Oct 2017 15:22:05 +0100
Subject: [PATCH v5 6/7] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20171002183524.ab23b255b6d03331bb36f75a@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-7-git-send-email-will.deacon@arm.com>
 <20170929171940.2aa33d00463b1e9c987aea15@arm.com>
 <20171002141405.GC12847@arm.com> <20171002164930.GB2121@redhat.com>
 <20171002183524.ab23b255b6d03331bb36f75a@arm.com>
Message-ID: <20171003142205.GD26552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 06:35:24PM -0500, Kim Phillips wrote:

[trim other stuff]

> Meanwhile, when I build this v5 arm_spe_pmu as a module, load it, do a
> perf list, rmmod it, then re-load it, I get an Oops:
> 
> # insmod arm_spe_pmu.ko
> [ 2018.623646] arm_spe_pmu spe-pmu at 0: probed for CPUs 0-3 [max_record_sz 64, align 1, features 0xf]
> [ 2018.626346] arm_spe_pmu spe-pmu at 1: probed for CPUs 4-7 [max_record_sz 64, align 1, features 0xf]
> # ./perf list
> [ 2021.649688] Unable to handle kernel NULL pointer dereference at virtual address 00000038

[...]

Cheers for the report. Fix here:

https://lkml.org/lkml/2017/10/3/564

Will
