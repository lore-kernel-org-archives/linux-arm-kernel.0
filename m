From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Nov 2013 10:48:45 +0000
Subject: [PATCH 1/3] arm: delete __cpuinit/__CPUINIT usage from all ARM
 users
In-Reply-To: <1384771703-25741-2-git-send-email-francesco.virlinzi@st.com>
References: <1384771703-25741-1-git-send-email-francesco.virlinzi@st.com>
 <1384771703-25741-2-git-send-email-francesco.virlinzi@st.com>
Message-ID: <20131118104845.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 11:48:21AM +0100, Francesco VIRLINZI wrote:
>  arch/arm/common/mcpm_platsmp.c       |   84 +++++++++
>  arch/arm/include/asm/arch_timer.h    |  105 +++++++++++

I hope this isn't an indication of the quality of the ST Linux tree -
where patches are badly backported to some previous kernel version
without understanding what a delete/modify conflict actually is.

Several of the "new files" you introduce here are irrelevant to this
change, because they didn't exist when the change was made.  If they
don't exist, then they don't need to be patched, and so they shouldn't
be created by the patch!
