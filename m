From: davem@davemloft.net (David Miller)
Date: Wed, 11 Nov 2015 14:01:06 -0500 (EST)
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111174401.GO9562@arm.com>
References: <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111174401.GO9562@arm.com>
Message-ID: <20151111.140106.1736782849444456527.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>
Date: Wed, 11 Nov 2015 17:44:01 +0000

> On Wed, Nov 11, 2015 at 12:35:48PM -0500, David Miller wrote:
>> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Date: Wed, 11 Nov 2015 09:27:00 -0800
>> 
>> > BPF_XADD == atomic_add() in kernel. period.
>> > we are not going to deprecate it or introduce something else.
>> 
>> Agreed, it makes no sense to try and tie C99 or whatever atomic
>> semantics to something that is already clearly defined to have
>> exactly kernel atomic_add() semantics.
> 
> ... and which is emitted by LLVM when asked to compile __sync_fetch_and_add,
> which has clearly defined (yet conflicting) semantics.

Alexei clearly stated that he knows about this issue and will fully
fix this up in LLVM.

What more do you need to hear from him once he's stated that he is
aware and is working on it?  Meanwhile you should make your JIT emit
what is expected, rather than arguing to change the semantics.

Thanks.
