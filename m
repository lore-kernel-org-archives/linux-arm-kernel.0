From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 09 Nov 2013 18:20:38 +0000
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <CAHCPf3tCTUEX6oDLUndZwt=Hk+YxsKjPO96N=Zhx82+_LM66sQ@mail.gmail.com>
 (Matt Sealey's message of "Sat, 9 Nov 2013 00:46:11 -0600")
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
 <CAHCPf3tCTUEX6oDLUndZwt=Hk+YxsKjPO96N=Zhx82+_LM66sQ@mail.gmail.com>
Message-ID: <yw1x38n5wi6h.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Sealey <neko@bakuhatsu.net> writes:

> BTW has there been any evaluation of the penalty for the extra
> branching, or the performance hit for the ARMv7-without-division
> cases?

The branches themselves probably have minimal overhead.  There will
however be code to preserve call-clobbered registers (and move the
values to/from r0/r1) that would not be needed if the div instructions
were done inline (obviously such a kernel could only run on hardware
with division support).

-- 
M?ns Rullg?rd
mans at mansr.com
