From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 8 Nov 2016 12:07:35 +0100
Subject: [PATCH] ARM: tegra: nyan: Mark all USB ports as host
In-Reply-To: <58046fbb-8e19-e629-770a-940a40ca6ef9@nvidia.com>
References: <20160918102852.6593-1-contact@paulk.fr>
 <20161107132854.GF12559@ulmo.ba.sec>
 <13e7ff98-8bc2-ccf7-94bb-4e1d3c61b20d@nvidia.com>
 <20161108085420.GG2478@tbergstrom-lnx.Nvidia.com>
 <58046fbb-8e19-e629-770a-940a40ca6ef9@nvidia.com>
Message-ID: <20161108110735.GA13098@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 09:47:42AM +0000, Jon Hunter wrote:
> 
> On 08/11/16 08:54, Peter De Schrijver wrote:
> > On Mon, Nov 07, 2016 at 02:09:31PM +0000, Jon Hunter wrote:
> >>
> >> On 07/11/16 13:28, Thierry Reding wrote:
> >>> * PGP Signed by an unknown key
> >>>
> >>> On Sun, Sep 18, 2016 at 12:28:52PM +0200, Paul Kocialkowski wrote:
> >>>> Nyan boards only have host USB ports (2 external, 1 internal), there is
> >>>> no OTG-enabled connector.
> >>>>
> >>>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> >>>> ---
> >>>>  arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> Where is this information coming from? I don't have one of the Nyans
> >>> myself, but one of the Tegra132 devices I have, which I think was
> >>> derived from one of the Nyans uses one of the external host ports as
> >>> forced recovery port, for which it would need OTG.
> >>>
> >>> I suspect that the way to get U-Boot onto the Nyans is via tegrarcm?
> >>> In that case I think one of the ports must be OTG.
> >>
> >> It is true that the port on the back on the nyan-big can be used with
> >> recovery mode. I was thinking that this is not a true OTG port as it is
> >> just a 4-pin type A socket and does not have an ID pin. Thinking some
> >> more about this the USB spec does include a "Host Negotiation Protocol
> >> (HNP)" that allows a host and device to swap roles and so keeping it as
> >> OTG seems valid afterall.
> > 
> > I don't think the bootrom implements that though. I expect recovery mode
> > to just program the controller in device mode, without performing any
> > negotiation.
> 
> I am not talking about the bootrom and I would not expect the bootrom to
> do that. However, the kernel could.

Either way, configuring the controller in device mode is enough to make
the host detect it, otherwise tegrarcm wouldn't work.

>From the point of view of the binding I think "otg" is the most accurate
option because we know that the controller can operate in both modes. If
it currently doesn't or how exactly switching modes is done is outside
the scope of this property.

Is everyone okay with just dropping this patch?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/a45c4288/attachment.sig>
