From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Aug 2013 09:48:36 +0100
Subject: AArch64 arch_spin_unlock not signaling global event?
In-Reply-To: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
References: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
Message-ID: <20130801084835.GA12077@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 09:19:13PM +0100, Andrei E. Warkentin wrote:
> Hiya,
> 
> I've noticed the AArch64 arch_spin_unlock is implemented with the
> 'stlr' instruction.
> 
> Shouldn't that be followed by a 'sev'?

No. In ARMv8, When the exclusive is cleared for a processor, an event is
generated.

Will
