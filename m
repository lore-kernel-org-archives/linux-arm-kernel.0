From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Oct 2013 11:46:12 +0100
Subject: [PATCH v2 1/2] ARM: include: asm: use 'long long' instead of
 'u64' within atomic.h
In-Reply-To: <5253E533.4070803@asianux.com>
References: <20131003163200.GE7408@mudshark.cambridge.arm.com>
 <524E8FBC.2080200@asianux.com>
 <20131004153742.GR24303@mudshark.cambridge.arm.com>
 <20131004154208.GS24303@mudshark.cambridge.arm.com>
 <524F5566.4010204@asianux.com> <524F594B.1070106@asianux.com>
 <525385A4.5050200@asianux.com>
 <20131008103455.GF17148@mudshark.cambridge.arm.com>
 <5253E4F3.4090205@asianux.com> <5253E533.4070803@asianux.com>
Message-ID: <20131009104612.GA6564@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:57:55AM +0100, Chen Gang wrote:
> atomic* value is signed value, and atomic* functions need also process
> signed value (parameter value, and return value), so 32-bit arm need
> use 'long long' instead of 'u64'.
> 
> After replacement, it will also fix a bug for atomic64_add_negative():
> "u64 is never less than 0".
> 
> The modifications are:
> 
>   in vim, use "1,% s/\<u64\>/long long/g" command.
>   remove '__aligned(8)' which is useless for 64-bit.
>   be sure of 80 column limitation after replacement.
> 

Looks fine by me.

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
