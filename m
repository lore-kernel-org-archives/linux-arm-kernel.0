From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 18:48:41 +0100
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <55DCA0DB.7000103@freebox.fr>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
 <55DCA0DB.7000103@freebox.fr>
Message-ID: <20150825174841.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 07:07:39PM +0200, Nicolas Schichan wrote:
> arch/arm/kernel/entry-common.S: Assembler messages:
> arch/arm/kernel/entry-common.S:200: Error: selected processor does not support
> ARM mode `isb'
> 
> replacing those two "isb" occurences with "instr_sync" fixed it.

Thanks, that's exactly what I've done.  I've pushed that and the other
fixes out for linux-next to pick up, hopefully with fewer failures.

This series passed my own build tests (which included building and
booting SDP4430, LDP4430, Versatile Express and iMX6 platforms.)
Unfortunately, they're all Cortex-A8 or A9 platforms.

Olof's builder is showing some build failures in the boot log, but I'll
assume that they're down to the above - I don't yet have the build log,
and that's going to arrive at some point after I've left for a committee
meeting which will extend for most of the evening.  So, I'm hoping that
tonight's linux-next will see improvement rather than deterioration -
that's all I can do at this point... hope.  I'm out of time to do any
more build checking prior to linux-next pulling my tree.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
