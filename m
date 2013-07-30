From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jul 2013 10:49:04 +0100
Subject: [PATCH] ARM: Fix r7/r11 confusion when CONFIG_THUMB2_KERNEL=y [OT]
In-Reply-To: <20130730113853.46cbb00a@armhf>
References: <1373685501-1620-1-git-send-email-jld@mozilla.com>
 <20130715135420.GG10000@mudshark.cambridge.arm.com>
 <20130720044655.GC9433@mozilla.com>
 <20130721213753.GA29879@mudshark.cambridge.arm.com>
 <20130722185234.GA14519@localhost.localdomain>
 <20130729212140.GB12681@mozilla.com>
 <20130730092517.GB2478@localhost.localdomain>
 <20130730113853.46cbb00a@armhf>
Message-ID: <20130730094904.GH11527@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:38:53AM +0100, Jean-Francois Moine wrote:
> BTW, kernels compiled with gcc-4.8 don't work.

Erm. Can you elaborate please? There was an issue where SLUB would get
miscompiled with 4.8 due to some per-cpu variable reordering across
barrier(), but I fixed that for ARM in 3.10.

... or are you referring specifically to the unwinder?

Will
