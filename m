From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 Feb 2018 16:01:47 +0100
Subject: [v2,1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <1519380573.10722.94.camel@linux.intel.com>
References: <1443795153-40836-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <099870d3-e2bd-aad9-d526-5438596bb575@the2masters.de>
 <20180222214237.GH28112@lunn.ch>
 <bce65520-7f11-49f5-c806-59e508001321@the2masters.de>
 <20180222233457.GA6052@lunn.ch>
 <1519380573.10722.94.camel@linux.intel.com>
Message-ID: <20180223150147.GA17857@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The patch has been corrupted by you email client. But otherwise, yes.
> > 
> > Please take a look at:
> > 
> > https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html
> > 
> > It will give you hits about correctly formatting the patch. In
> > addition it should have:
> > 
> > Fixes: 4cd5773a2ae6 ("net: core: move mac_pton() to lib/net_utils.c")
> > 
> > before the --- line, to indicate what it is fixing.
> > 
> > This patch should be against
> > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git,
> > since it is a fix, and sent to <netdev@vger.kernel.org>.
> 
> Guys, consider this one instead:
> https://patchwork.ozlabs.org/patch/851008/

Hi Andy

Thanks for pointing this patch out.

What is the advantage of doing to the strnlen()? As Stefan says, the
code which follows will detect a short string, in that a NULL is not
in [0-9a-f], nor a : .

Thanks
	Andrew
