From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 13:47:32 +0000
Subject: [PATCH v4 4/4] KGDB: make kgdb_breakpoint() as noinline
In-Reply-To: <1383641146-27274-5-git-send-email-vijay.kilari@gmail.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
 <1383641146-27274-5-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20131108134732.GF17461@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 08:45:46AM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> The function kgdb_breakpoint() sets up break point at
> compile time by calling arch_kgdb_breakpoint();
> Though this call is surrounded by wmb() barrier,
> the compile can still re-order the break point,
> because this scheduling barrier is not a code motion
> barrier in gcc.
> 
> Making kgdb_breakpoint() as noinline solves this problem
> of code reording around break point instruction and also
> avoids problem of being called as inline function from
> other places
> 
> More details about discussion on this can be found here
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/269732
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

I thought I already acked this?

Will
