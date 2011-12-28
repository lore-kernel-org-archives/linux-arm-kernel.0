From: davem@davemloft.net (David Miller)
Date: Wed, 28 Dec 2011 13:41:15 -0500 (EST)
Subject: [PATCH v3] ARM: net: JIT compiler for packet filters
In-Reply-To: <4EFB3B06.1090203@gmail.com>
References: <1324404263-913-1-git-send-email-mgherzan@gmail.com>
 <20111220.135526.82432216865290827.davem@davemloft.net>
 <4EFB3B06.1090203@gmail.com>
Message-ID: <20111228.134115.1976002751167690328.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mircea Gherzan <mgherzan@gmail.com>
Date: Wed, 28 Dec 2011 16:51:34 +0100

> Am 20.12.2011 19:55, schrieb David Miller:
>> From: Mircea Gherzan<mgherzan@gmail.com>
>> Date: Tue, 20 Dec 2011 19:04:23 +0100
>>
>>> Based of Matt Evans's PPC64 implementation.
>>>
>>> The compiler generates ARM instructions but interworking is
>>> supported for Thumb2 kernels.
>>>
>>> Supports both little and big endian. Unaligned loads are emitted
>>> for ARMv6+. Not all the BPF opcodes that deal with ancillary data
>>> are supported. The scratch memory of the filter lives on the stack.
>>> Hardware integer division is used if it is available.
>>>
>>> Enabled in the same way as for x86-64 and PPC64:
>>>
>>> 	echo 1>  /proc/sys/net/core/bpf_jit_enable
>>>
>>> A value greater than 1 enables opcode output.
>>>
>>> Signed-off-by: Mircea Gherzan<mgherzan@gmail.com>
>>
>> I'm happy with this going in via the ARM tree once all the details
>> are worked out:
> 
> I do not really care that much about the tree where this is going, as
> long as it gets into 3.3 :) If you want to take it via the -net tree,
> please synchronize with Russell (I've uploaded the patch to his
> tracking system [1]).

I think it's much easier if this goes via the ARM tree, so I ask that
the ARM folks pull this patch in.

Acked-by: David S. Miller <davem@davemloft.net>

Thanks.
