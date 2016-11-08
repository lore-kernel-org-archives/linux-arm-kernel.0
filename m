From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 08 Nov 2016 10:09:24 +0100
Subject: [PATCH] ARM: tegra: nyan: Mark all USB ports as host
In-Reply-To: <20161108085420.GG2478@tbergstrom-lnx.Nvidia.com>
References: <20160918102852.6593-1-contact@paulk.fr>
 <20161107132854.GF12559@ulmo.ba.sec>
 <13e7ff98-8bc2-ccf7-94bb-4e1d3c61b20d@nvidia.com>
 <20161108085420.GG2478@tbergstrom-lnx.Nvidia.com>
Message-ID: <1478596164.2045.2.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 08 novembre 2016 ? 10:54 +0200, Peter De Schrijver a ?crit?:
> On Mon, Nov 07, 2016 at 02:09:31PM +0000, Jon Hunter wrote:
> > 
> > On 07/11/16 13:28, Thierry Reding wrote:
> > > * PGP Signed by an unknown key
> > > 
> > > On Sun, Sep 18, 2016 at 12:28:52PM +0200, Paul Kocialkowski wrote:
> > > > Nyan boards only have host USB ports (2 external, 1 internal), there is
> > > > no OTG-enabled connector.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > > ?arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
> > > > ?1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Where is this information coming from? I don't have one of the Nyans
> > > myself, but one of the Tegra132 devices I have, which I think was
> > > derived from one of the Nyans uses one of the external host ports as
> > > forced recovery port, for which it would need OTG.
> > > 
> > > I suspect that the way to get U-Boot onto the Nyans is via tegrarcm?
> > > In that case I think one of the ports must be OTG.
> > 
> > It is true that the port on the back on the nyan-big can be used with
> > recovery mode. I was thinking that this is not a true OTG port as it is
> > just a 4-pin type A socket and does not have an ID pin. Thinking some
> > more about this the USB spec does include a "Host Negotiation Protocol
> > (HNP)" that allows a host and device to swap roles and so keeping it as
> > OTG seems valid afterall.
> 
> I don't think the bootrom implements that though. I expect recovery mode
> to just program the controller in device mode, without performing any
> negotiation.

That would make sense.

However, if there's a way (even not implemented yet, but a possible way) to have
the kernel configure this port as USB device instead of host dynamically (e.g.
without changing this bit in the dts), then I think it makes sense to keep the
OTG marking and drop this patch.

After all, switching to USB device mode doesn't necessarily have to come from
the ID pin.

-- 
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/66a1f1dd/attachment.sig>
