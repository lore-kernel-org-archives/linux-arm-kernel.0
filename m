From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Dec 2010 12:06:08 +0000
Subject: [PATCH] mmci: supply per-instance regulator name
In-Reply-To: <20101202115700.GF29347@n2100.arm.linux.org.uk>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
	<20101202115700.GF29347@n2100.arm.linux.org.uk>
Message-ID: <20101202120608.GC3182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 11:57:00AM +0000, Russell King - ARM Linux wrote:

> It seems that the regulator code is making all the same mistakes that
> historically were made with the clk API code.

It's not...

> Rather than using the struct device, it's trying to use the regulator

...it does exactly this.  Passing names is not good practice.
