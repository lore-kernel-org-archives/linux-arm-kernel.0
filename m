From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Nov 2011 10:56:07 +0000
Subject: [PATCH 1/2] ARM: mach-imx: convert logical CPU numbers to
 physical numbers
In-Reply-To: <20111111100800.GA12410@mudshark.cambridge.arm.com>
References: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
 <1320762894-11824-2-git-send-email-will.deacon@arm.com>
 <20111111092925.GM16886@pengutronix.de>
 <20111111100800.GA12410@mudshark.cambridge.arm.com>
Message-ID: <20111111105607.GC12410@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 10:08:00AM +0000, Will Deacon wrote:
> On Fri, Nov 11, 2011 at 09:29:25AM +0000, Sascha Hauer wrote:
> > On Tue, Nov 08, 2011 at 02:34:53PM +0000, Will Deacon wrote:
> > > This patch uses the new cpu_logical_map() macro for converting logical
> > > CPU numbers into physical numbers when releasing CPUs during the SMP
> > > boot and CPU hotplug paths.
> > 
> > Shawn, is this one ok?
> 
> I reckon I need to post a v2 because this probably breaks when !SMP.

Actually, I take that back. Looks like the function is only used by
hotplug.c and platsmp.c, both of which depend on CONFIG_SMP.

So yes, comments from Shawn would be great.

Will
