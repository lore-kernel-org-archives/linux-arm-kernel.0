From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Aug 2013 10:09:56 +0200
Subject: [PATCH 4/9] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130813080956.GE9316@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:46:50PM +0200, Sebastian Hesselbarth wrote:
> This patch adds a check for DT passed reset-gpios property and deasserts/
> asserts reset pin on probe/remove with configurable delay. Corresponding
> binding documentation is also updated.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pci at vger.kernel.org
> ---
>  .../devicetree/bindings/pci/mvebu-pci.txt          |    2 ++
>  drivers/pci/host/pci-mvebu.c                       |   33 +++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> index 638673a..f2fa261 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -76,6 +76,8 @@ and the following optional properties:
>  - marvell,pcie-lane: the physical PCIe lane number, for ports having
>    multiple lanes. If this property is not found, we assume that the
>    value is 0.
> +- reset-gpios: optional gpio to PERST#
> +- reset-delay-ms: delay in ms to wait after reset de-assertion

I remember some recent discussion about this, and we now have this reset
framework, so perhaps it makes more sense to use the reset binding for
this? Cc'ing Stephen (as part of the device tree bindings maintainers
team) who was involved in that recent reset bindings discussion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/1383a882/attachment.sig>
