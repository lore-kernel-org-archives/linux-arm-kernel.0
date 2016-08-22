From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 18:04:21 +0200
Subject: [linux-sunxi] Re: [PATCH 2/2] ASoC: sunxi: compatibility for
 sun6i to SPDIF
In-Reply-To: <CAGb2v65Hyp8U1OMrfy0Bo9-qC0eO5de+NjWQzch87_2Ty+fBqQ@mail.gmail.com>
References: <20160730142716.29377-1-codekipper@gmail.com>
 <20160730142716.29377-3-codekipper@gmail.com>
 <170941469890365@web9j.yandex.ru> <20160730152049.GU6215@lukather>
 <CAGb2v65Hyp8U1OMrfy0Bo9-qC0eO5de+NjWQzch87_2Ty+fBqQ@mail.gmail.com>
Message-ID: <20160822160421.GR7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 01, 2016 at 09:39:34PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sat, Jul 30, 2016 at 11:20 PM, maxime.ripard at free-electrons.com
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Jul 30, 2016 at 10:52:45PM +0800, Icenowy Zheng wrote:
> >> > + if (of_device_is_compatible(pdev->dev.of_node,
> >> > + "allwinner,sun6i-a31-spdif")) {
> >> > + host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> >> > + if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
> >> > + ret = -EPROBE_DEFER;
> >> > + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
> >> > + goto err_disable_apb_clk;
> >> > + }
> >> > + if (!IS_ERR(host->rst))
> >> > + reset_control_deassert(host->rst);
> >> > + }
> >> > +
> >> I think you do not need the compatible.
> >> You can just detect whether the reset is present.
> >
> > That would weaken the error check. If we're running on the A31 and are
> > missing our reset property, it would go unnoticed.
> 
> We've been doing it this way with the mmc controller and the usb hosts though.
> IIRC you once said in the older SoCs, the reset control is tied to the clock
> gate in the hardware.
> 
> The _optional variant is also funny, though I understand it is a design
> of the reset controller framework.

Yes, I know. But that doesn't prevent that design from being better.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/282d2412/attachment.sig>
