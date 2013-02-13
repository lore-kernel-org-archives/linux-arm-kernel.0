From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Feb 2013 10:48:54 +0100
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <511A7B14.1020107@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212180858.289c3efa@skate> <511A7B14.1020107@codethink.co.uk>
Message-ID: <20130213104854.721cad23@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Tue, 12 Feb 2013 17:25:40 +0000, Ben Dooks wrote:

> > I've tested your patch set on Armada XP. The kernel boots fine, but it
> > fails to bring up the secondary CPUs:
> 
> Yes, missed updating the coherency_ll.S patch.
> 
> Attached new patch

Thanks. Your patch did not build, because ARM_BE() isn't defined
anywhere in coherency_ll.S. I've fixed this by using an ifdef
CONFIG_CPU_BE8_BOOT_LE (updated patch attached), and now the secondary
CPUs boot fine.

That said, I still haven't fixed my userspace, so I could only verify
that the kernel boots, not more.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mvebu-support-running-big-endian.patch
Type: text/x-patch
Size: 2201 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130213/995addba/attachment.bin>
