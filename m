From: daniel@iogearbox.net (Daniel Borkmann)
Date: Tue, 05 Jan 2016 17:37:54 +0100
Subject: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
In-Reply-To: <20160105160345.GA3951@debian>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
 <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160105160345.GA3951@debian>
Message-ID: <568BF162.7030008@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2016 05:03 PM, Rabin Vincent wrote:
> On Tue, Jan 05, 2016 at 08:00:45AM -0800, Eric Dumazet wrote:
>> On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
>>> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
>>> instructions since it XORs A with X while all the others replace A with
>>> some loaded value.  All the BPF JITs fail to clear A if this is used as
>>> the first instruction in a filter.
>>
>> Is x86_64 part of this 'All' subset ? ;)
>
> No, because it's an eBPF JIT.

Correct, filter conversion to eBPF clears it already.
