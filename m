From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Oct 2012 12:15:34 +0100
Subject: [BUG] read_current_timer undefined
In-Reply-To: <Pine.LNX.4.64.1210261306370.20835@axis700.grange>
References: <Pine.LNX.4.64.1210261306370.20835@axis700.grange>
Message-ID: <20121026111534.GI20914@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 12:09:18PM +0100, Guennadi Liakhovetski wrote:
> A recent commit
> 
> commit 923df96b9f31b7d08d8438ff9677326d9537accf
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Fri Jul 6 15:46:45 2012 +0100
> 
>     ARM: 7451/1: arch timer: implement read_current_timer and get_cycles
> 
> breaks linkage of modules, using get_cycles(), e.g. 
> 
> ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!
> 
> This is present in "next" of 23 October.

It's been present for a lot longer than that, but a fix has been merged into
mainline, so next should be ok now. See mainline commit f3accb122f2 ("ARM:
export default read_current_timer").

Will
