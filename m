From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 31 Jan 2011 10:13:13 -0500 (EST)
Subject: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
In-Reply-To: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Jan 2011, Rajendra Nayak wrote:

> Can you elaborate a bit more on how/why runtime PM transitions
> are disabled during system suspend, and how is it taken care
> of that a runtime resume of a device works however a subsequent
> runtime (re)suspend does not?

I'll answer for Kevin.  This is done by the PM core, in order to 
prevent runtime power transitions from interfering with a system power 
transition.  The PM core increments the device's usage_count; this 
prevents the device from being runtime-suspended but it allows 
runtime-resume calls to go through.

Alan Stern
