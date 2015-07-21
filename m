From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 21 Jul 2015 10:25:31 +0200
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <55ADE829.4030108@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <55AD73F4.2050502@wwwdotorg.org> <55ADE829.4030108@mail.ru>
Message-ID: <4778199.vGjAP5lpOS@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juli 2015, 09:35:21 schrieb Andrey Danin:
> On 21.07.2015 1:19, Stephen Warren wrote:
> > On 07/20/2015 02:35 PM, Andrey Danin wrote:
> >> NVEC driver was reimplemented to use tegra i2c. Use common i2c bindings
> >> for NVEC node.
> >> 
> >> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> >> b/arch/arm/boot/dts/tegra20-paz00.dts
> >> 
> >> +        nvec: nvec at 45 {
> >> +            compatible = "nvidia,nvec-slave";
> >> +            reg = <0x45>;
> > 
> > I think you need to or in I2C_OWN_SLAVE_ADDRESS from
> > <dt-bindings/i2c/i2c.h> here?
> 
> Sorry, I mentioned it in letter 0 only.
> I will rework nvec driver and device tree according to i2c core slave
> implementation later. v3 of this patchset is for fixing tegra i2c driver
> only.

I think in this case it would be better to leave nvec and dt as it is for now, 
and just add the slave function to tegra-i2c. Otherwise we will again have two 
different "nvidia,nvec-slave" bindings (one for the intermediate hack and one 
for the final representation). As an alternative, you could also add slave 
function and port nvec in the same series.

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150721/75633402/attachment.sig>
