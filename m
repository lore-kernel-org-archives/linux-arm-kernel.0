From: max.schwarz@online.de (Max Schwarz)
Date: Fri, 18 Apr 2014 01:06:27 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <20140417183835.GG12304@sirena.org.uk>
References: <3748421.ND1tAjvgKS@typ> <5059282.MitP6iZ8n1@typ>
 <20140417183835.GG12304@sirena.org.uk>
Message-ID: <15224827.56gI5cqpbK@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 April 2014 at 19:38:35, Mark Brown wrote:

> If you're only doing a few accesses then surely there's no meaningful
> overhead from just writing what you want?  So long as you don't cache
> these registers regmap won't really get in the way.

I think Heiko and I have been operating under the misconception that caching 
is somehow enabled by default - which is not the case. Thanks for clearing 
that up ;-)

Heiko - I'm now sure that we are fine with the access pattern we employ right 
now (always set the mask bits for writes). We also don't need to mark 
registers as volatile (has no meaning without caching).

In the meantime I developed a patch for regmap, but I think the better route 
would be to leave things as they are. If you guys still think "proper" regmap 
support is the way to go, the patch is attached.

Cheers,
  Max
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-regmap-support-for-registers-with-write-mask-in-uppe.patch
Type: text/x-patch
Size: 5540 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/c7e0e05c/attachment-0001.bin>
