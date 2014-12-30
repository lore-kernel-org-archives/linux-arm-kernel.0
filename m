From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Dec 2014 16:51:10 +0000
Subject: [PATCH v5 2/6] ASoC: dwc: Prepare clock before use
In-Reply-To: <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
 <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <20141230165110.GK17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 10:55:44AM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> Some I2S clocks may require some time to get the clock ready
> for operation and so need to be prepared before they are enabled.
> So, prepare the clock as well as enabling it, but combine the
> two through clk_prepare_enable.

Applied, though the changelog is inaccurate - the need to do things
outside of hardirq context is the reason the common clock API has a
prepare stage but it's just a flat out requirement of the common clock
API to prepare clocks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141230/f7405b0c/attachment.sig>
