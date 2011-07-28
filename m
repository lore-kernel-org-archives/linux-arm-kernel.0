From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jul 2011 10:52:22 +0100
Subject: [RFC PATCH 0/3] ARM: Add default system.h and uncompress.h
In-Reply-To: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110728095221.GA31473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 10:32:11PM -0500, Rob Herring wrote:
> One downside is you lose print capability in the decompressor. However,
> I don't think the complexity that adds is worth the 1 line print.

You're wrong there - it's very very useful to have that from the
decompressor.  It's saved many people (including us) a lot of wasted
time caused by faulty hardware implementation.

Normally, if the design of the SDRAM connections is poor, the first
thing which catches it is the decompressor, and so its that which we
really want error information from.

So no, losing that ability is not an option.  Really.
