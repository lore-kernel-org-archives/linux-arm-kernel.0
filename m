From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Jan 2014 10:54:46 +0000
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <20140115093641.4167.83109@quantum>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
 <20140109015158.7168.60274@quantum>
 <52D4B502.3080409@codeaurora.org>
 <20140115093641.4167.83109@quantum>
Message-ID: <20140115105446.GF15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 01:36:41AM -0800, Mike Turquette wrote:

> Providing common functions for the basic case (e.g. read-modify-write on
> a register using a known mask) is reasonable. But that is exactly what
> the existing basic clock types do (sans regmap) and they have all become
> pretty ugly over time. And the clk-composite implementation just makes
> me a sad panda.

What we've tried to do with regulators is just have multiple helper
functions in the core rather than trying to merge their implementation,
the drivers pick the right one for their usage, and in cases where there
aren't many drivers doing the same thing we just have the driver either
copy the bits of the implementation they reuse or call the helper
function from within the implementation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/8b75c283/attachment.sig>
