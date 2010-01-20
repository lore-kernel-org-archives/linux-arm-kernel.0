From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 10:00:40 +0000
Subject: git pre-commit hook running checkpatch.pl
In-Reply-To: <20100120020202.GE26562@trinity.fluff.org>
References: <20100120020202.GE26562@trinity.fluff.org>
Message-ID: <20100120100040.GB20302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 02:02:02AM +0000, Ben Dooks wrote:
> I've written a git pre-commit[1] hook which stops any commits happening if
> checkpatch.pl reports problems with the patch. Any comments?

Very bad - checkpatch can be wrong at times.

Eg 1, asm/irq.h vs linux/irq.h
Eg 2, asm/memory.h vs linux/memory.h
Eg 3, lines longer than 80 characters for printk() strings are preferred
  so that they are grep-able.

checkpatch is at best a guide, not a set of hard rules.
