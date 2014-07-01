From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 10:04:29 +0100
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <53B1DD21.6020709@mit.edu>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140630144045.GM25779@arm.com> <53B18555.2000109@mentor.com>
 <53B1DD21.6020709@mit.edu>
Message-ID: <20140701090429.GD28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:56:49PM +0100, Andy Lutomirski wrote:
> On 06/30/2014 08:42 AM, Nathan Lynch wrote:
> > On 06/30/2014 09:40 AM, Will Deacon wrote:
> >>   - If we use your code to build an arm64 vdso, how much slower is it than
> >>     the handcrafted asm we currently have?
> > 
> > Someone with access to 64-bit hardware (i.e. not me) would have to find
> > this out, but I would not be surprised if the C code could be tightened
> > up -- I have not spent much time on optimizing it.
> > 
> 
> I can't comment on ARM specifically, but the only assembly in the x86
> vclock_gettime is an asm volatile (""), which causes gcc to emit more
> optimal code.  I doubt I could shave off more than a cycle or two by
> rewriting it in assembly.

The arm64 version avoids the stack completely (we have lots of registers),
so I'd expect a significant win over a C version. However, I'd be interested
to see a comparison as the C version is clearly more maintainable.

Will
