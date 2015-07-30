From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Jul 2015 11:52:33 +0100
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <CAOMqctQTc-8_rU6URCPHXno-OqH6wf_rHY4mW+Sf-epNhCwhFQ@mail.gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
 <20150729171613.GI11162@sirena.org.uk>
 <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
 <20150729184043.GL11162@sirena.org.uk>
 <CAOMqctQTc-8_rU6URCPHXno-OqH6wf_rHY4mW+Sf-epNhCwhFQ@mail.gmail.com>
Message-ID: <20150730105233.GO11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 10:24:37AM +0200, Michal Suchanek wrote:

> So my suggestion is to

> 1) search of ofpart subnode in mtd node. If present read address and
> reg from it and search partitions as subnodes of the ofpart node. In
> this case unknown nodes can cause error.

> 2) failing that issue a warning and try to parse ofpart partitions
> from the mtd node itself. In this case unknown nodes cannot cause
> error for compatibility with other drivers including the already
> exisitn s3c64xx controller-data node.

> The parser code can be the same for both cases and only operate on
> different node with a flag to reject unknown subnodes or not.

That seems reasonable to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/b635d61a/attachment.sig>
