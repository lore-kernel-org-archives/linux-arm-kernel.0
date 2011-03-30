From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Mar 2011 09:53:46 +0100
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in
	for device accesses
In-Reply-To: <AANLkTi=eXRhZEVUuX8aT8n=heZnTR6TjxXdasV_ObgNh@mail.gmail.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
	<AANLkTim1=686NAO7ox8s-HAd_KT4OjiUb1Y7jrUtgia3@mail.gmail.com>
	<1301416642.583.101.camel@e102109-lin.cambridge.arm.com>
	<AANLkTi=eXRhZEVUuX8aT8n=heZnTR6TjxXdasV_ObgNh@mail.gmail.com>
Message-ID: <1301475226.29074.27.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(could you please avoid top-posting, it makes it harder to follow?)

On Tue, 2011-03-29 at 22:06 +0100, Martin Furmanski wrote:
> These statements appear not even remotely valid. Certainly the CPU is
> only a bus master, so when you say slave/master memory access, what
> are you referring to?

What I meant by master is memory access that the CPU initiates. By slave
I was referring to accesses that the device or block of memory receive
as a result of a bus master request. You can rephrase this if you want.

On the DMB - it only ensures that the bus master requests are ordered,
it doesn't care about the request arrival at a device or block of
memory.

> (Sorry for accidentally bringing the thread off the list for the last
> 2 posts. Bringing it back.)

It looks like your messages are held in a moderation queue (you may want
to subscribe or wait for the moderator to approve them).

-- 
Catalin
