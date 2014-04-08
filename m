From: treding@nvidia.com (Thierry Reding)
Date: Tue, 8 Apr 2014 21:52:41 +0200
Subject: [RFC 1/5] PCI: tegra: Overhaul regulator usage
In-Reply-To: <53444AE3.6030603@wwwdotorg.org>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-2-git-send-email-treding@nvidia.com>
 <53444AE3.6030603@wwwdotorg.org>
Message-ID: <20140408195240.GA21978@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 09:15:47PM +0200, Stephen Warren wrote:
> On 04/04/2014 08:49 AM, Thierry Reding wrote:
> > The current usage of regulators for the Tegra PCIe block is wrong. It
> > doesn't accurately reflect the actual supply inputs of the IP block and
> > therefore isn't as flexible as it should be. Rectify this by describing
> > all possible supply inputs in the device tree binding documentation and
> > deprecate the old supply properties.
> 
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> 
> > +Power supplies for Tegra30:
> ...
> > +- Optional:
> > +  - If port 0 is enabled:
> > +    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
> > +    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> > +  - If at least one of ports 1 and 2 is enabled:
> > +    - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
> > +    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> 
> Did you get confirmation from HW/... that the mapping from pexa/b to
> PCIe ports you document above is correct? IIRC the two supplies might be
> related to lanes rather than ports?

Not yet, which is the primary reason this is still RFC. Just wanted to
get early feedback on the general direction of the series.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/03e93392/attachment-0001.sig>
