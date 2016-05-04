From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 May 2016 19:25:55 +0100
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after
 bootloader initialization
In-Reply-To: <5729E4B5.2090702@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
 <20160429113059.GX3217@sirena.org.uk>
 <57234BA2.6020304@samsung.com>
 <20160429164448.GY3217@sirena.org.uk> <57272298.50701@samsung.com>
 <20160502105501.GE6292@sirena.org.uk>
 <20160503180022.GA3008@rob-hp-laptop>
 <5729E4B5.2090702@samsung.com>
Message-ID: <20160504182555.GE6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2016 at 02:01:57PM +0200, Krzysztof Kozlowski wrote:

> This looks like pwrseq for MMC devices so the idea is to:
> 1. Move drivers/mmc/core/pwrseq* to separate directory
> (drivers/power/pwrseq ?)
> 2. Add support for pwrseq to USB core,
> 3. Add new pwrseq driver (or extend existing one): toggling the regulator.
> 4. Add pwrseq phandle to the DT node of USB hub (to the binding
> mentioned by Rob?).

> Does it look sensible?

It certainly seems like a similar problem space, USB seems very much
like MMC in both the spec and the way it tends to get used.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/c430248f/attachment.sig>
