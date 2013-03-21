From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Mar 2013 19:23:22 +0000
Subject: [PATCH 02/11] ARM: remove extra timer-sp control register clearing
In-Reply-To: <1363820051-24428-3-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-3-git-send-email-robherring2@gmail.com>
Message-ID: <20130321192322.GR4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 05:54:02PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The timer-sp initialization code clears the control register before
> initializing the timers, so every platform doing this is redundant.
> 
> For unused timers, we should not care what state they are in.

NAK.  We do care what state they're in.  What if they have their interrupt
enable bit set, and IRQ is shared with the clock event timer?

No, this patch is just wrong.
