From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 25 Jan 2017 12:01:55 +0100
Subject: [PATCH v2 2/6] ARM: tegra: nyan: Use external control for
 bq24735 charger
In-Reply-To: <20170125105940.GC9344@ulmo.ba.sec>
References: <20170122154753.31942-1-contact@paulk.fr>
 <20170122154753.31942-2-contact@paulk.fr>
 <20170125105940.GC9344@ulmo.ba.sec>
Message-ID: <1485342115.1224.0.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 25 janvier 2017 ? 11:59 +0100, Thierry Reding a ?crit?:
> On Sun, Jan 22, 2017 at 04:47:49PM +0100, Paul Kocialkowski wrote:
> > Nyan boards come with an embedded controller that controls when to
> > enable and disable the charge. Thus, it should not be left up to the
> > kernel to handle that.
> > 
> > Using the ti,external-control property allows specifying this use-case.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > ?arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
> > ?1 file changed, 1 insertion(+)
> 
> Is the ti,ac-detect-gpios property still useful in that case? I guess it
> would still allow to monitor whether or not a charger is connected, even
> if the EC determines that it shouldn't charge.

Yes, this is mostly what the bq24735 is used for in nyan devices: reporting
connection and disconnection events.

> Anyway, I've applied this.

Thanks!

-- 
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/63ff1be2/attachment-0001.sig>
