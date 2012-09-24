From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2012 09:35:30 +0100
Subject: [PATCH] ARM: gic: fix irq affinity mismatch.
In-Reply-To: <CAOAMb1DEKrgjtq-xRB+Qy1+_8D-G+6g2v9QSLMisVNbKa8+jSA@mail.gmail.com>
References: <CAOAMb1DEKrgjtq-xRB+Qy1+_8D-G+6g2v9QSLMisVNbKa8+jSA@mail.gmail.com>
Message-ID: <20120924083530.GM15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 12:06:19PM +0900, Chanho Min wrote:
> Even if we set affinity to multiple cpus via procfs, gic_set_affinity
> allows to set one target only. But, '/proc/irq/xxx/smp_affinity' shows
> as we are successful in the setting of multiple affinity. Thus irq_data->
> affinity mismatches with the GICD_ITARGETSRs.
> 
> fix it as bellows.
> - Set the default affinity to the boot cpu in gic_dist_init. thereafter,
> irq_data->affinity will be set to default 1-bit affinity.
> - Even if we write multiple bits to smp_affinity, both irq_data and gic
> register will be set one cpu. procfs will show 1 bit affinity as well.

This has come up before.  There is no requirement to make the affinity
mask reflect back to userspace what the hardware is doing.  So, NAK.
