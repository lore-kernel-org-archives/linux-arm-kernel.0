From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Nov 2011 14:37:31 +0000
Subject: [RFC][PATCH] gpiolib: add irq_wake (power-management) sysfs file
In-Reply-To: <20111116143011.GA5847@una0919255>
References: <1321004406-15663-1-git-send-email-p-combes@ti.com>
 <20111115131636.GA31028@sirena.org.uk>
 <20111116143011.GA5847@una0919255>
Message-ID: <20111116143731.GG29986@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 03:30:13PM +0100, Patrick Combes wrote:

> > ...this doesn't do anything to stop userspace doing multiple enables and
> > disables.

> Do you mean there is a need to prevent that?
> Basically the code above accepts both "1" or "enable" strings to enable the
> property. I could limit that to "enable" / "disable" if it is confusing.

That's not the problem.  The problem is that if you disable it might not
actually disable the wake if it's previously been enabled multiple times.
