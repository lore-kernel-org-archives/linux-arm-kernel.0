From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Nov 2011 16:38:43 +0000
Subject: cpu_pm breaks 3.2 boot on platforms with cascading GICs
In-Reply-To: <20111124161336.GB22031@mudshark.cambridge.arm.com>
References: <20111124161336.GB22031@mudshark.cambridge.arm.com>
Message-ID: <4ECE7313.8070104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/11 16:13, Will Deacon wrote:
> 
> I'm not sure how you want to handle this. Clearly you should only register one
> notifier for the GIC, but it does need to handle the cascading situation
> properly.
> 
> This affects current mainline, so we need a solution for 3.2.

I quickly hacked the attached patch, which allows me to boot on PB11MP.

	M.
-- 
Jazz is not dead. It just smells funny...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-cpu_pm-register-GIC-PM-notifier-only-once.patch
Type: text/x-patch
Size: 1241 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111124/caea2993/attachment-0001.bin>
