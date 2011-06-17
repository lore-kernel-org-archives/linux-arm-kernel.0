From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jun 2011 08:21:25 +0100
Subject: [PATCH 06/14] ARM: suspend: rejig suspend follow-on function
	calling convention
In-Reply-To: <4DFAC1F8.7040503@gmail.com>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
	<E1QWAku-0002e3-3d@rmk-PC.arm.linux.org.uk>
	<4DFAC1F8.7040503@gmail.com>
Message-ID: <20110617072125.GD32629@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 09:54:48PM -0500, Rob Herring wrote:
> If you change:
> 
> > +	ldmfd	sp!, {r0, pc}		@ call suspend fn
> 
> To:
> 	mov	lr, pc
> 	ldmfd	sp!, {r0, pc}
> 	ldmfd	sp!, {r1, r6, ip}
> 	mov	sp, r6
> 	ldmfd	sp!, {r4-r11, pc}
> 
> It will allow the suspend fn to return and abort suspend. With that, I'm
> able to use this for core powerdown in cpuidle.

Did you see my last message in the "[RFC PATCH v5] ARM hibernation /
suspend-to-disk (fwd)" thread?
