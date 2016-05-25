From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 25 May 2016 23:03:27 +0300
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <20160525.123017.1597296248000772613.davem@davemloft.net>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
 <20160525.123017.1597296248000772613.davem@davemloft.net>
Message-ID: <20160525200327.GA22395@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 12:30:17PM -0700, David Miller wrote:
> From: Yury Norov <ynorov@caviumnetworks.com>
> Date: Tue, 24 May 2016 03:04:30 +0300
> 
> > +To clear that top halves, automatic wrappers are introduced. They clear all
> > +required registers before passing control to regular syscall handler.
> 
> Why have one of these for every single compat system call, rather than
> simply clearing the top half of all of these registers unconditionally
> in the 32-bit system call trap before the system call is invoked?
> 
> That's what we do on sparc64.
> 
> And with that, you only need wrappers for the case where there needs
> to be proper sign extention of a 32-bit signed argument.

It was discussed as one of possible solutions. The downside of it is
that we cannot pass 64-bit types (like off_t) in single register.
The other downside is that we clear top halves for every single
syscall, and it looks excessive. So, from spark64 and s390 approaches
we choosed second.
