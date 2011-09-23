From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Sep 2011 09:43:48 +0100
Subject: [PATCH] ARM: futex: fix clobbering oldval
In-Reply-To: <1316737129.6872.17.camel@puffmine-laptop>
References: <1316660015.6872.1.camel@puffmine-laptop>
	<20110922172653.GH13572@e102144-lin.cambridge.arm.com>
	<1316737129.6872.17.camel@puffmine-laptop>
Message-ID: <20110923084348.GA5468@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 01:18:49AM +0100, mhban wrote:
> On Thu, 2011-09-22 at 18:26 +0100, Will Deacon wrote:
> > 
> > It would have been nice to have been CC'd on this...
> 
> Will not miss next time. Thanks.

Thanks. You can use scripts/get_maintainer.pl to get a list of people to
email.

> > 
> > You shouldn't reference r5 directly here, but due to the way the futex code
> > is laid out, you can't add an extra output operand without converting the
> > code to use named arguments.
> > 
> > I'll post a patch to do that.
> > 
> > Will
> 
> I'm not familiar with gcc inline, thanks for pointing it out.

There's a good guide for ARM here:

http://www.ethernut.de/en/documents/arm-inline-asm.html

> BTW, my last name is Ban not Ben.

Oops, I'll update my reported-by to spell that correctly.

Cheers,

Will
