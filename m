From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 20:54:38 -0700 (MST)
Subject: [PATCH] OMAP2+: omap_hwmod: fix wakeup enable/disable for
	consistency
In-Reply-To: <1291936247-17955-1-git-send-email-khilman@deeprootsystems.com>
References: <1291936247-17955-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1012142041530.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Dec 2010, Kevin Hilman wrote:

> In the omap_hwmod core, most of the SYSCONFIG register helper
> functions do not directly write the register, but instead just modify
> a value passed in.
> 
> This patch converts the _enable_wakeup() and _disable_wakeup() helper
> functions to take a value argument and only modify it instead of
> actually writing the register.  This makes the wakeup helpers
> consistent with the other helper functions and avoids unintentional
> problems like the following.

Thanks, this looks great.  Queued for 2.6.38 in the 'hwmod_b_2.6.38' 
branch along with the OMAP4 hwmod cleanup patches.

The current integration tag that contains these patches is 
'integration-2.6.38-20101214-012' available from 
git://git.pwsan.com/linux-integration


- Paul
