From: imre.deak@nokia.com (Imre Deak)
Date: Wed, 10 Mar 2010 18:22:21 +0200
Subject: __xchg for sizes other than 32bit
Message-ID: <20100310162221.GA19201@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

recently you've added support for __cmpxchg for ARMv6+. There the assumption
is that ldrex[bh]/strex[bh] is only supported on platforms with the 32v6K
extension.

Currently the __xchg code uses these even without the extension. Should this
be fixed?

I'm looking at this since I'd need to add support for short arguments in __xchg
needed at least by the cgroups code.

Thanks,
Imre
