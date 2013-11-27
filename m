From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Nov 2013 12:14:25 +0000
Subject: [PATCH] ARM: asm: Configure caches as per the defconfig
In-Reply-To: <1385553244-1513-1-git-send-email-amit.virdi@st.com>
References: <1385553244-1513-1-git-send-email-amit.virdi@st.com>
Message-ID: <20131127121425.GN16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 05:24:04PM +0530, Amit Virdi wrote:
> From: Amit VIRDI <Amit.VIRDI@st.com>
> 
> In the current implementation of the decompression code, the caches are enabled
> irrespective of their configuration in the deconfig. This makes setting the
> ICACHE and DCACHE disable options from the menuconfig irrelevant. Change this
> implementation to enable caches only if specified in the defconfig.

NAK.  These options are provided more for ARM Ltd's validation of CPUs
rather than for users, and it's not supposed to be used with the
decompressor.

I've already ignored one such patch like this in the past and I intend
not applying this one either.
