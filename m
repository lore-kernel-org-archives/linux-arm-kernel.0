From: will.deacon@arm.com (Will Deacon)
Date: Wed, 13 May 2015 17:08:47 +0100
Subject: [EDT][PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
In-Reply-To: <556690501.99511431494646065.JavaMail.weblogic@ep2mlwas05a>
References: <556690501.99511431494646065.JavaMail.weblogic@ep2mlwas05a>
Message-ID: <20150513160847.GG3343@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 06:24:06AM +0100, Maninder Singh wrote:
> EP-2DAD0AFA905A4ACB804C4F82A001242F
> 
> Subject: [PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
> 
> This patch adds support for CPU hotplug, It re-installl all installed watchpoints and breakpoints
> back on H/W in case of cpu-hot plug.

Not sure why this is needed -- the scheduler should reinstall the
breakpoints when the debugged task gets scheduled in via
arch_install_hw_breakpoint.

Will
