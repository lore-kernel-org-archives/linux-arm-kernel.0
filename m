From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jan 2014 16:48:42 +0000
Subject: [PATCH v6 3/3] KGDB: make kgdb_breakpoint() as noinline
In-Reply-To: <52D6BAEB.3040607@windriver.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <1387453851-19341-4-git-send-email-vijay.kilari@gmail.com>
 <52D6BAEB.3040607@windriver.com>
Message-ID: <20140115164842.GA28782@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 04:44:27PM +0000, Jason Wessel wrote:
> On 12/19/2013 05:50 AM, vijay.kilari at gmail.com wrote:
> > From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> >
> > The function kgdb_breakpoint() sets up break point at
> > compile time by calling arch_kgdb_breakpoint();
> > Though this call is surrounded by wmb() barrier,
> > the compile can still re-order the break point,
> > because this scheduling barrier is not a code motion
> > barrier in gcc.
> >
> > Making kgdb_breakpoint() as noinline solves this problem
> > of code reording around break point instruction and also
> > avoids problem of being called as inline function from
> > other places
> >
> > More details about discussion on this can be found here
> > http://comments.gmane.org/gmane.linux.ports.arm.kernel/269732
> >
> > Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Jason Wessel <jason.wessel@windriver.com>

Thanks Jason! We'll take this series via the arm64 tree.

Will
