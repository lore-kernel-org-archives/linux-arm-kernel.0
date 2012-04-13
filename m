From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Apr 2012 13:19:14 +0100
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413120706.GT3168@opensource.wolfsonmicro.com>
References: <20120413012230.GA30438@windriver.com>
 <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
 <20120413103207.GL24211@n2100.arm.linux.org.uk>
 <20120413104452.GR3168@opensource.wolfsonmicro.com>
 <20120413104900.GM24211@n2100.arm.linux.org.uk>
 <20120413120706.GT3168@opensource.wolfsonmicro.com>
Message-ID: <20120413121914.GN24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 01:07:07PM +0100, Mark Brown wrote:
> On Fri, Apr 13, 2012 at 11:49:00AM +0100, Russell King - ARM Linux wrote:
> 
> > What I want is something that doesn't cause a regression for 3.4.
> 
> Oh, and note that there's already a fix for the missing header although
> with all the git trees I've no idea what the process is for getting it
> into mainline.

That really doesn't make any difference about whether I can push 7366/1
as is or not.  If the fix for the missing header is going through some
other git tree, I can't push 7366/1 until that fix has gone in - and
I'm not going to be tracking when that happens.

TBH, its something that _you_ need to manage - you created this regression
in the first place by changing the regulator API without first reviewing
all the callsites.  Grep is a wonderful tool for finding those.  So I'll
leave it entirely up to you to figure out how to fix the AMBA regression
you caused in a sane way in -rc - and without causing any additional
regressions by doing so.

If you want me to apply 7367/1 instead, then please say so directly.  If
you want 7366/1 plus the header file fixed, then that needs to be figured
out.
