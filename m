From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 30 Sep 2013 18:26:16 -0300
Subject: [PATCH 0/4] Kirkwood: minor cleanups
In-Reply-To: <20130930211650.GF6735@lunn.ch>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130930211650.GF6735@lunn.ch>
Message-ID: <20130930212615.GA8823@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:16:50PM +0200, Andrew Lunn wrote:
> > The third and fourth patch are related: the latter strictly depends on
> > the former. The idea behind these two patches is basically to convert
> > the "keep the ethernet clocks enabled by calling clk_enable()" hack
> > into a simpler and cleaner usage of the CLK_IGNORE_UNUSED flags which
> > prevent these clocks from being ever gated.
> 
> Hi Ezequiel
> 
> This should work, but what would be nicer is to look and see if there
> is a node in DT for each device. If it does not have a node, don't set
> CLK_IGNORE_UNUSED, so that the clock does get turned off, and we save
> a bit of power. Quite a few of the kirkwood devices only have one
> ethernet.
> 

Good idea. I'll take a look at it.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
