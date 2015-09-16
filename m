From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 15 Sep 2015 19:50:31 -0700
Subject: [PATCH 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150916023219.GD1747@two.firstfloor.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
 <20150916023219.GD1747@two.firstfloor.org>
Message-ID: <20150915195031.0a1756a2.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015 04:32:19 +0200 Andi Kleen <andi@firstfloor.org> wrote:

> > __iowrite32_copy() is marked __visible.  I don't actually know what
> > that does and Andi's d47d5c8194579bc changelog (which sucks the big
> > one) didn't explain it.  Apparently it has something to do with being
> > implemented in assembly, but zillions of functions are implemented in
> > assembly, so why are only two functions marked this way?  Anyway,
> > __ioread32_copy() is implemented in C so I guess __visible isn't needed
> > there.
> 
> __visible is needed for C functions that are called from assembler.
> Otherwise the compiler may optimize them away.

Under what circumstances will the compiler (or linker?) do this? 
LTO enabled?
