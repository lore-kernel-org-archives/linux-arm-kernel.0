From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Sep 2013 17:07:47 +0100
Subject: [PATCH v2] ARM: include: asm: use 'long long' instead of 'u64'
 within atomic.h
In-Reply-To: <5242498F.8060407@asianux.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <5242498F.8060407@asianux.com>
Message-ID: <20130925160746.GC14502@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 03:25:19AM +0100, Chen Gang wrote:
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
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Looks better to me, thanks. While you're here, we could also replace the use
of `unsigned long' with `int' for the 32-bit atomics, then the whole header
is consistent with the generic types.

Will
