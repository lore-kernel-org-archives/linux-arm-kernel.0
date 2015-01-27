From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 12:14:24 +0000
Subject: [PATCH v9 3/5] regulators: axp20x: Use "clock-frequency"
 property for dcdc work frequency
In-Reply-To: <1421941147-9682-4-git-send-email-wens@csie.org>
References: <1421941147-9682-1-git-send-email-wens@csie.org>
 <1421941147-9682-4-git-send-email-wens@csie.org>
Message-ID: <20150127121424.GS21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 11:39:05PM +0800, Chen-Yu Tsai wrote:
> Since the dcdc regulator work frequency is a property of the regulators
> DT sub-tree, there is no issue of naming collisions, so we can use the
> standard "clock-frequency" binding for this.
> 
> The driver sets a reasonable default value (same as the datasheet), and
> only 1 dts has the old binding, with the default value.

I don't see any benefit from this change - not only is this an
incompatible change (which may affect out of tree users as well as in
tree users) but it's not really doing anything with the clock API which
I'd expect to be happening for a clock API property.  What's the goal
here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/4a10a876/attachment.sig>
