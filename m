From: robherring2@gmail.com (Rob Herring)
Date: Fri, 15 Apr 2011 08:39:55 -0500
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Message-ID: <4DA84AAB.60601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
> This is work in progress.
>
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.

It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.

lpc32xx and pnx4008 also use iram, but do not have an allocator (only 1 
user). Both are doing a copy the suspend code to IRAM and run it which 
may also be a good thing to have generic code for. Several i.MX chips 
also need to run from IRAM for suspend.

Rob
