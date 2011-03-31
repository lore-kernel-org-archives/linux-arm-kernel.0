From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 31 Mar 2011 15:28:21 -0400
Subject: [PATCH 05/12] mm: alloc_contig_range() added
In-Reply-To: <op.vs7umufd3l0zgt@mnazarewicz-glaptop>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
	<1301587361.31087.1040.camel@nimitz>
	<op.vs7umufd3l0zgt@mnazarewicz-glaptop>
Message-ID: <20110331192821.GF14441@home.goodmis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2011 at 06:26:45PM +0200, Michal Nazarewicz wrote:
> >In any case, please pull the ++ret bit out of the WARN_ON().  Some
> >people like to do:
> >
> >#define WARN_ON(...) do{}while(0)
> >
> >to save space on some systems.
> 
> I don't think that's the case.  Even if WARN_ON() decides not to print
> a warning, it will still return the value of the argument.  If not,
> a lot of code will brake.
>

WARN_ON() should never do anything but test. That ret++ does not belong
inside the WARN_ON() condition. If there are other locations in the
kernel that do that, then those locations need to be fixed.

-- Steve
