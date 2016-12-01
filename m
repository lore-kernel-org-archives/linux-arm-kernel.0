From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 1 Dec 2016 12:19:21 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161201103048.GO1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161130135631.GK1574@e103592.cambridge.arm.com>
 <dbcd545f-1358-6a80-5a9f-3e4a3c93189a@redhat.com>
 <20161201103048.GO1574@e103592.cambridge.arm.com>
Message-ID: <20161201121921.GP1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 10:30:51AM +0000, Dave Martin wrote:

[...]

> Basically, all the *new* state is caller-save.
> 
> The Neon/FPSIMD regs V8-V15 are callee-save, so in the SVE view
> Zn[bits 127:0] is callee-save for all n = 8..15.

Ramana is right -- the current procedure call standard (ARM IHI 0055B)
only requires the bottom _64_ bits of V8-V15 to be preserved (not all
128 bits as I stated).

[...]

Cheers
---Dave
