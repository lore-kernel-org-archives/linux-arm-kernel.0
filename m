From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 22 Nov 2011 10:18:57 +0000
Subject: [PATCH 1/4] [RFC] Add generic ARM instruction set condition code
 checks.
In-Reply-To: <20111121190848.GS9581@n2100.arm.linux.org.uk>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
 <20111121190848.GS9581@n2100.arm.linux.org.uk>
Message-ID: <20111122101846.GA2066@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 07:08:48PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2011 at 06:30:46PM +0000, Leif Lindholm wrote:
> > +/*
> > + * Returns:
> > + * 0 - if condition fails
> > + * 1 - if condition passes (including AL)
> > + * 2 - if unconditional encoding (or before ARMv3, NV condition)
> 
> The comment is wrong.  NV always meant 'never execute' including v3,
> v4 and v5 architectures.

Actually, if the v5 ARM ARM is to believed this was only true prior to
ARMv3.

Apparently the behaviour of instructions encoded with the NV condition
code is UNPREDICTABLE in v3 and v4.  With the exception of the ARMv5 BLX
<label> and v5E PLD instructions, I've no idea whether any actual
implementation did anything crazy with these opcodes though, prior to
ARMv6.

Perhaps someone implemented some v4/v3 parts with custom instructions in
this space, or dealt with the NV condition in a unexpected way -- I'm
not aware of any such implementation, though.

Maybe the comment can be reworded more conservatively, such as

"2 - NV condition, or separate unconditional opcode space from v5
onwards"

That wording judiciously doesn't say anything about v3/v4.

Cheers
---Dave
