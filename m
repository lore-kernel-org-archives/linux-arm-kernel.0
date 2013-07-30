From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 11:25:11 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
Message-ID: <20130730102511.GM9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 08:30:29PM -0400, jonsmirl at gmail.com wrote:

> This...
> tx-dma-channel = <&pdma0 7>; /* preliminary */
> rx-dma-channel = <&pdma0 6>; /* preliminary */

> Probably should be
> dmas = <&pdma0 7>,<&pdma0 6>;
> dma-names = "tx", "rx";

It should be - the latter is the generic DMA binding.  There's a lot of
bindings in the kernel that predate that but people are currently
working to transfer over, this is one of the examples of instability
that everyone is talking about.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/ac91dfe8/attachment.sig>
