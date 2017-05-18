From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 May 2017 18:30:10 +0100
Subject: [PATCH 1/1] futex: remove duplicated code
In-Reply-To: <14580dfc-9721-38ab-a1e0-6b4aba13b406@suse.cz>
References: <20170515130742.18357-1-jslaby@suse.cz>
 <20170515131644.GA3605@arm.com>
 <14580dfc-9721-38ab-a1e0-6b4aba13b406@suse.cz>
Message-ID: <20170518173010.GK21359@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 10:01:29AM +0200, Jiri Slaby wrote:
> On 05/15/2017, 03:16 PM, Will Deacon wrote:
> > Whilst I think this is a good idea, the code in question actually results
> > in undefined behaviour per the C spec and is reported by UBSAN.
> 
> Hi, yes, I know -- this patch was the 1st from the series of 3 which I
> sent a long time ago to fix that up too. But I remember your patch, so I
> sent only this one this time.
> 
> > See my
> > patch fixing arm64 here (which I'd forgotten about):
> > 
> > https://www.spinics.net/lists/linux-arch/msg38564.html
> > 
> > But, as stated in the thread above, I think we should go a step further
> > and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
> > appear to be used by userspace, and this whole thing is a total mess.
> > 
> > Any thoughts?
> 
> Ok, I am all for that. I think the only question is who is going to do
> the work and submit it :)? Do I understand correctly to eliminate all
> these functions and the path into the kernel? But won't this break API
> -- are there really no users of this interface?

That's the million-dollar question, really. I don't know of any code using
it, and I couldn't find any when I looked (also nothing reported by Debian
Codesearch afaict), but I was hoping linux-arch might have some thoughts
on this too.

For now, I'll queue my arm64 patch before I forget about it again!

Will
