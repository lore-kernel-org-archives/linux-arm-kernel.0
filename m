From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Mar 2015 16:34:16 +0000
Subject: [PATCH v2 1/2] regulator: act8865: add input supply handling
In-Reply-To: <2033007.teD9r9y7xo@phil>
References: <1709506.shJhJsMxOa@phil> <20150307143922.GM28806@sirena.org.uk>
 <2033007.teD9r9y7xo@phil>
Message-ID: <20150307163416.GS28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 04:33:53PM +0100, Heiko Stuebner wrote:
> The act88600/act8846/act8865 regulators have a number of input supplies
> supplying the individual regulators. This may even be recursively like on
> most Rockchip boards using the act8846 where REG4 is most of the time
> connected to the inl1-supply.

Applied, thanks.  The recursive supplies are very common - DCDCs are
vastly more efficient than LDOs so if you've got the capacity and care
about power it's much better to drop your main supply voltage down to
something near the LDO headroom with a DCDC in order to improve system
performance.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150307/2a52fb38/attachment.sig>
