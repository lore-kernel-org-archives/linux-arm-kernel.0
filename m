From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2016 17:45:12 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <20160429131338.GB32007@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <4271094.ei7kj5zJxn@wuerfel> <20160429131338.GB32007@yury-N73SV>
Message-ID: <26638986.ZDcHcYF1jk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 16:13:38 Yury Norov wrote:
> On Fri, Apr 29, 2016 at 12:43:41AM +0200, Arnd Bergmann wrote:
> > On Friday 29 April 2016 01:21:37 Yury Norov wrote:

> > > 
> > > arch/arm64/kernel/sys_ilp32.c:59:0: warning: "__SYSCALL" redefined
> > >  #define __SYSCALL(nr, sym) [nr] = sym,
> > >  ^
> > > In file included from include/asm-generic/unistd.h:1:0,
> > > 
> > 
> > Ok, I think I see it now. Can you #undef the two symbols at the
> > end of arch/arm64/include/uapi/asm/unistd.h
> 
> I think it doesn't look better than what we have now, but not worse
> as well. If you like it, I'll change.

I looked again and saw that the existing architectures also #undef __SYSCALL,
and they don't have __SC_WRAP. It's probably fine to just #undef the
two here (don't undef SC_COMP, __SC_3264 and SC_COMP_3264).

Changing the asm-generic header to not require the #undef would be nice,
but then we should do that for all 12 users of that file.

	Arnd
