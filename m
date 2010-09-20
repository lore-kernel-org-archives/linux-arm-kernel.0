From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 20 Sep 2010 12:52:17 -0400
Subject: [PATCH] ARM: make app read out process num even not use SMP
In-Reply-To: <20100919130438.GC9098@n2100.arm.linux.org.uk>
References: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
	<20100919122920.GB9098@n2100.arm.linux.org.uk>
	<20100919130438.GC9098@n2100.arm.linux.org.uk>
Message-ID: <1285001537.23122.274.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-09-19 at 14:04 +0100, Russell King - ARM Linux wrote:

> There's a better way.  sysconf with _SC_NPROCESSORS_CONF for the number
> of configured processors, or _SC_NPROCESSORS_ONLN for the number of
> online processors.  Standard interfaces are always better than home-made
> interfaces.

I just pushed the update to the repo. It now uses the sysconf() feature.

I'll apply this to the stable version as well.

Thanks!

-- Steve
