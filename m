From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Nov 2014 19:21:46 +0100
Subject: mirabox boot fails in linux-next (was: next boot: 94 boots: 79
 pass, 13 fail, 2 untried (next-20141117))
In-Reply-To: <7h61ed4xm3.fsf@deeprootsystems.com>
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>
 <7h61ed4xm3.fsf@deeprootsystems.com>
Message-ID: <20141117192146.23df4006@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kevin Hilman,

On Mon, 17 Nov 2014 08:09:56 -0800, Kevin Hilman wrote:
> FYI...
> 
> armada-370-mirabox started failing boot tests in linux-next as of
> next-20141117.  Excerpt of boot report below, or you can see all the recent
> boots of mirabox here:
> 
>    http://status.armcloud.us/boot/?mirabox
> 
> I bisected it down to a PCI commit[2], but it didn't revert cleanly on
> top of next/master so didn't fully verify it is the root cause.  I'll
> let one of you MVEBU maintainers take it the next step.

Thanks a lot for the report, very useful. I haven't yet looked at the
PCI commit itself, but reading the commit log indicates that it plays
with sizing the BARs, and we're doing some fairly funky stuff with this
in pci-mvebu, so I'm not entirely surprised such a commit can break
stuff. I'll have a look tomorrow.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
