From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2011 15:16:50 +0000
Subject: [PATCH v2 2/9] lpc2k: Exception vector handling
In-Reply-To: <1300461116-6028-3-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-3-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <20110318151650.GL29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 04:11:49PM +0100, Ithamar R. Adema wrote:
> Since the LPC2K does not have an MMU (ARM7TDMI based), it expects the vectors to be
> stored in on-chip SRAM. However, this moves the vectors too far away from the stubs
> page, requiring the vector jumps to be indirect.

Why not copy the vectors and stubs just like we do for MMU-based kernels?
