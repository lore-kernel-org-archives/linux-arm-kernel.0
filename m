From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Wed, 25 Jun 2014 18:41:07 +0200
Subject: [linux-sunxi] Re: [PATCH v2 12/20] clk: sunxi: Add A23 APB0
 support to sun6i-a31-apb0-clk
In-Reply-To: <CAGb2v64hFc7oVdydoNzKVqjnyNUxuqMXX2AiV3aJLFizKvkOPA@mail.gmail.com>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-13-git-send-email-wens@csie.org>
 <20140618102623.GQ19730@lukather>
 <CAGb2v64D6qBtXGXzn25443s_oj_=Z-u_P6+-MX52Lz54+9bQyQ@mail.gmail.com>
 <20140619092847.GW19730@lukather>
 <CAGb2v64hFc7oVdydoNzKVqjnyNUxuqMXX2AiV3aJLFizKvkOPA@mail.gmail.com>
Message-ID: <20140625164107.GA19569@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 02:13:58PM +0800, Chen-Yu Tsai wrote:
> > If these two clocks are these different though, maybe it would just be
> > easier to add a new driver. These are trivial enough anyway.
> 
> Yes it is. But it adds more of the same boilerplate code than actual
> differences of the hardware.
> 
> I'm inclined to keep it as it is for now, unless someone strongly
> objects.

I'm not strongly objecting, but I'd strongly prefer to go with two
drivers.

I don't really want to end up in the same case than with clk-sunxi.c,
which handles a lot of weird corner case for one particular clock,
while most of them are just a single-bit gate.

Especially when they have nothing in common, which is pretty much the
case here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/d7d93676/attachment.sig>
