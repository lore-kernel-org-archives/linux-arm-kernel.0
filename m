From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 19:41:36 +0100
Subject: [RFC PATCH v5 2/2] ARM: VFP: preserve the HW context when
	calling signal handlers
In-Reply-To: <e15d90a0042327dd34a065f9cd463a02b25e6522.1270199787.git.imre.deak@nokia.com>
References: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
	<cover.1270199787.git.imre.deak@nokia.com>
	<e15d90a0042327dd34a065f9cd463a02b25e6522.1270199787.git.imre.deak@nokia.com>
Message-ID: <20100412184136.GD3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 05:36:03PM +0300, imre.deak at nokia.com wrote:
> From: Imre Deak <imre.deak@nokia.com>
> 
> Signal handlers can use floating point, so prevent them to corrupt
> the main thread's VFP context. So far there were two signal stack
> frame formats defined based on the VFP implementation, but the user
> struct used for ptrace covers all posibilities, so use it for the
> signal stack too.
> 
> Introduce also a new user struct for VFP exception registers. In
> this too fields not relevant to the current VFP architecture are
> ignored.
> 
> Support to save / restore the exception registers was added by
> Will Deacon.

Look fine to me, but I'd like an ack from Daniel since he partly looks
after the toolchain side of things and has dealt with this area before.
