From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Nov 2018 11:03:55 +0100
Subject: [PATCH v2 06/10] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
In-Reply-To: <f7d19f6e-0dcd-753c-a407-fcec4fa1474b@nvidia.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-7-thierry.reding@gmail.com>
 <f7d19f6e-0dcd-753c-a407-fcec4fa1474b@nvidia.com>
Message-ID: <20181113100355.GA15642@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 09:39:08AM +0000, Jon Hunter wrote:
> 
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Mikko Perttunen <mperttunen@nvidia.com>
> > 
> > Add bindings for the Tegra Combined UART device used to talk to the
> > UART console on Tegra194 systems.
> > 
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/serial/nvidia,tegra194-tcu.txt   | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > new file mode 100644
> > index 000000000000..085a8591accd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > @@ -0,0 +1,35 @@
> > +NVIDIA Tegra Combined UART (TCU)
> > +
> > +The TCU is a system for sharing a hardware UART instance among multiple
> > +systems within the Tegra SoC. It is implemented through a mailbox-
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
> > +- mbox-names:
> > +    "rx" - Mailbox for receiving data from hardware UART
> > +    "tx" - Mailbox for transmitting data to hardware UART
> > +- mboxes: Mailboxes corresponding to the mbox-names.
> 
> Looks like there is some trailing white-space in the above line and git
> warns after applying this patch.

I'm not seeing it. I remember seeing that trailing space in an earlier
version of this patch and fixing it up. Did you perhaps end up applying
the wrong version?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/e776e2f8/attachment.sig>
