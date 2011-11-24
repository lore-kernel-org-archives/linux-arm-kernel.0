From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Nov 2011 16:53:44 +0000
Subject: cpu_pm breaks 3.2 boot on platforms with cascading GICs
In-Reply-To: <4ECE7313.8070104@arm.com>
References: <20111124161336.GB22031@mudshark.cambridge.arm.com>
 <4ECE7313.8070104@arm.com>
Message-ID: <20111124165343.GD22031@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 04:38:43PM +0000, Marc Zyngier wrote:
> On 24/11/11 16:13, Will Deacon wrote:
> > 
> > I'm not sure how you want to handle this. Clearly you should only register one
> > notifier for the GIC, but it does need to handle the cascading situation
> > properly.
> > 
> > This affects current mainline, so we need a solution for 3.2.
> 
> I quickly hacked the attached patch, which allows me to boot on PB11MP.

Great, this fixes my boot problem, thanks! I can't confirm the cpu_pm stuff
works correctly, but it looks like the notifier walks all of the GICs
anyway.

Tested-by: Will Deacon <will.deacon@arm.com>

Will
