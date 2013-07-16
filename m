From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 16 Jul 2013 00:47:27 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <51E472D4.5060307@zytor.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com>
 <20130715150342.35f7620ffe0835e3e2bc37d0@linux-foundation.org>
 <51E472D4.5060307@zytor.com>
Message-ID: <20130716004727.b60b2c96.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jul 2013 15:08:20 -0700 "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 07/15/2013 03:03 PM, Andrew Morton wrote:
> > 
> > I don't know how to do this.  Any suggestions?
> > 
> > It has to be done at `make config' time.  We'd need to probe for the
> > presence of lz4c and then....  what?
> > 
> > Is there any precedent for this?
> > 
> > I don't think we can just ignore the absence of lz4c - the user has
> > selected a config which his system cannot build.  The problem lies
> > within randconfig itself.
> > 
> 
> We keep running over the need to be able to have kconfig run tests on
> the build system (for toolchain support or for optional tools needed);
> running them in the Makefiles (i.e. at Kbuild time) is simply too late.
> 

Would it make sense to extend Kconfig's `depends'?

	depends on $(shell-command)

I don't know how practical that would be to implement...
