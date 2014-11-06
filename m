From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Nov 2014 16:33:27 +0100
Subject: [RFC PATCH] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <20141106152135.GC4974@lunn.ch>
References: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141106155823.213f8811@free-electrons.com>
 <20141106152135.GC4974@lunn.ch>
Message-ID: <20141106163327.69a81d74@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 6 Nov 2014 16:21:35 +0100, Andrew Lunn wrote:

> Any idea what order things are done?
> 
> Would it be possible to remove the .smp entry, and then in
> mvebu_dt_init() check if there are smp operations set. If not, then
> set them to armada_xp_smp_ops?

->init_machine() is *way* too late for SMP. ->init_early() is also too
late as far as I remember. ->dt_fixup() would work, though I believe.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
