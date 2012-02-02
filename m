From: khilman@ti.com (Kevin Hilman)
Date: Thu, 02 Feb 2012 10:40:04 -0800
Subject: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
In-Reply-To: <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Thu, 2 Feb 2012 19:33:54 +0530")
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87obthcc57.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> hwmod setup already does a reset and sets the OCP sysconfig
> registers appropriately. Avoid doing a reset again and overriding
> the OCP sysconfig settings in the system timer init code.

That is true for OMAP4, but have you verified if this is indeed a
duplicate reset on  OMAP2/3?

Kevin
