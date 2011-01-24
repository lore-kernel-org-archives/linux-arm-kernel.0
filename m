From: s.neumann@raumfeld.com (Sven Neumann)
Date: Mon, 24 Jan 2011 11:21:23 +0100
Subject: [PATCH] ARM: pxa: fix suspend on PXA3XX
In-Reply-To: <1295864152-773-1-git-send-email-s.neumann@raumfeld.com>
References: <20110124095138.GC16202@n2100.arm.linux.org.uk>
	<1295864152-773-1-git-send-email-s.neumann@raumfeld.com>
Message-ID: <1295864483.2044.31.camel@sven>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 11:15 +0100, Sven Neumann wrote:
> Resurrect the save and restore functions in pxa3xx_cpu_pm_fns
> so that pxa_pm_enter() won't crash. This fixes a regression
> introduced by commit aae8224d.
> 
> Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>

With this patch the crash is gone and the device enters suspend. It
still has resume problems, but this is the same as with 2.6.37 and needs
further investigation.


Sven
