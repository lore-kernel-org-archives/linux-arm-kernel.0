From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 15:18:35 -0500
Subject: [PATCH 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
In-Reply-To: <3ddaafbd-d8cb-3cca-be4e-8c5c53fd9734@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-3-mperttunen@nvidia.com>
 <3ddaafbd-d8cb-3cca-be4e-8c5c53fd9734@nvidia.com>
Message-ID: <20180522201835.GA24611@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 04:15:09PM +0100, Jon Hunter wrote:
> 
> On 08/05/18 12:43, Mikko Perttunen wrote:
> > Add bindings for the Tegra Combined UART device used to talk to the
> > UART console on Tegra194 systems.
> > 
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > new file mode 100644
> > index 000000000000..86763bc5d74f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > @@ -0,0 +1,35 @@
> > +NVIDIA Tegra Combined UART (TCU)
> > +
> > +The TCU is a system for sharing a hardware UART instance among multiple
> > +systems withing the Tegra SoC. It is implemented through a mailbox-
> > +based protocol where each "virtual UART" has a pair of mailboxes, one
> > +for transmitting and one for receiving, that is used to communicate
> > +with the hardware implementing the TCU.
> > +
> > +Required properties:
> > +- name : Should be tcu
> > +- compatible
> > +    Array of strings
> > +    One of:
> > +    - "nvidia,tegra194-tcu"
> 
> Nit. We should say what device the above compatibility is applicable for ...
> 
>     - "nvidia,tegra194-tcu": for Tegra194

Yeah, everyone seems to do that, but I find it to be redundant.

Rob
