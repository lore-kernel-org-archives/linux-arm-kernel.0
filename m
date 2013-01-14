From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 14 Jan 2013 12:10:41 +0100 (CET)
Subject: [PATCHv2 3/4] clockevents: Add generic timer broadcast
 function
In-Reply-To: <1357742770-15028-4-git-send-email-mark.rutland@arm.com>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-4-git-send-email-mark.rutland@arm.com>
Message-ID: <alpine.LFD.2.02.1301141209290.7475@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Mark Rutland wrote:
> Currently, the timer broadcast mechanism is defined by a function
> pointer on struct clock_event_device. As the fundamental mechanism for
> broadcast is architecture-specific, this means that clock_event_device
> drivers cannot be shared across multiple architectures.
> 
> This patch adds an (optional) architecture-specific function for timer
> tick broadcast, allowing drivers which may require broadcast
> functionality to be shared across multiple architectures.

Looks good.

If you fixup the first one of the series, I'll take the generic
patches and provide a branch to pull for the ARM folks, so the ARM
part can go via their tree.

Thanks,

	tglx
