From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 May 2012 13:01:29 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531095723.GU8026@tbergstrom-lnx.Nvidia.com>
References: <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
 <20120531092603.GM5377@arwen.pp.htv.fi>
 <20120531094301.GT8026@tbergstrom-lnx.Nvidia.com>
 <20120531094616.GP5377@arwen.pp.htv.fi>
 <20120531095723.GU8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120531100112.GR5377@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 12:57:23PM +0300, Peter De Schrijver wrote:
> 
> > 
> > Well, that's just because struct device doesn't know about its own clock
> > providers, right ? Should that be patched too ?
> > 
> > Russell, as the orignal author of the clk API, what do you think ?
> 
> Even if it would know, how would that solve the problem? only the
> clockframework is supposed to know about struct clk.

you have the device and you have the clock, you need to toggle a bit on
the clock address space. I guess that pretty much says it, no ? Unless
your implementation of struct clk doesn't tell you clk register offset
which is rather unlikely.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/1cc895c9/attachment.sig>
