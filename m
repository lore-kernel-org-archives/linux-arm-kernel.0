From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 10:34:58 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111215816.GA1068@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
Message-ID: <1263292498.29654.26.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 21:58 +0000, Daniel Jacobowitz wrote:
> The kernel currently reserves two architecturally undefined
> instructions for breakpoints, one ARM and one Thumb.  I suggest
> another for Thumb-2, provisionally 0xfff7 0xffcf, but I'm open
> to any other suggestion.  Any comments?  If that sounds OK,
> I can put together a patch.

I find the reasons good enough to add a 32-bit Thumb-2 breakpoint
instruction.

Regarding the opcode, can we not use a permanently undefined one? There
is A6.3.4 in the ARM ARM defining such encoding. Maybe something like
0xf7f0 a000 (or 0xa000 f7f0 if you write it as a 32-bit word).

-- 
Catalin
