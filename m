From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jun 2018 19:08:18 +0100
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
In-Reply-To: <20180619171424.GA16846@roeck-us.net>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
 <20180619151235.GH17671@n2100.armlinux.org.uk>
 <20180619171424.GA16846@roeck-us.net>
Message-ID: <20180619180817.GK17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:14:24AM -0700, Guenter Roeck wrote:
> On Tue, Jun 19, 2018 at 04:12:35PM +0100, Russell King - ARM Linux wrote:
> > 
> > So, I'm going to continue sitting on the fence on this, and basically
> > take the attitude that it's better that people don't use the new
> > binutils until binutils people can provide us with an officially
> > sanctioned solution that's going to work for both older and future
> > assemblers.
> > 
> I would so much love if people were working together instead of against
> each other :-(. Never mind, I'll try a toolchain with binutils 2.28.1.
> At least that is still supported with buildroot.

You could say that about the toolchain people who decided to change
the behaviour in this area that has existed before July 2009, and
broke multiple software packages in the process.

What I don't want to do is to change it in some way that breaks
existing setups, or that ends up breaking again in the future.  This
is why I want input _from the toolchain people_ before we try to fix
the problem.

That isn't "against each other" - it's a request _for_ toolchain
people to be involved in this.

The fact that this thread doesn't involve any toolchain people says
a lot about the "working together" aspect.  So, please don't try and
lump this on me being "un-cooperative".

What I'm saying is talk to the toolchain people and find a solution
in conjunction _with_ them that we can be sure will work, rather
than guessing at some obscure undocumented method that could end up
breaking again.

Remember, _you_ have the problem, _I_ don't.  It's not for me to go
off and talk to the toolchain people on your behalf.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
