From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 11:59:40 +0100
Subject: [PATCH v2 2/6] ARM: tegra: nyan: Use external control for
 bq24735 charger
In-Reply-To: <20170122154753.31942-2-contact@paulk.fr>
References: <20170122154753.31942-1-contact@paulk.fr>
 <20170122154753.31942-2-contact@paulk.fr>
Message-ID: <20170125105940.GC9344@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 04:47:49PM +0100, Paul Kocialkowski wrote:
> Nyan boards come with an embedded controller that controls when to
> enable and disable the charge. Thus, it should not be left up to the
> kernel to handle that.
> 
> Using the ti,external-control property allows specifying this use-case.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Is the ti,ac-detect-gpios property still useful in that case? I guess it
would still allow to monitor whether or not a charger is connected, even
if the EC determines that it shouldn't charge.

Anyway, I've applied this.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/74d69b75/attachment-0001.sig>
