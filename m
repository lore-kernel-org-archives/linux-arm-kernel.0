From: agust@denx.de (Anatolij Gustschin)
Date: Thu, 3 Apr 2014 16:56:57 +0200
Subject: [PATCH] ARM: i.MX6: update KSZ9031 phy fixup
In-Reply-To: <1396533947.25686.22.camel@EMBLYSD005.adetelgroup.com>
References: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
 <20140402220125.4e203cd2@crub>
 <1396533947.25686.22.camel@EMBLYSD005.adetelgroup.com>
Message-ID: <20140403165657.510b6493@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 03 Apr 2014 16:05:47 +0200
Hubert Chaumette <hchaumette@adeneo-embedded.com> wrote:
...
> > It would be better to configure the pad skews in the board specific
> > way in the device tree. There is a binding for ksz9021 PHY in
> > Documentation/devicetree/bindings/net/micrel-ksz9021.txt.
> 
> I wonder why it it's not used in arch/arm/boot/dts/imx6q-sabrelite.dts
> instead of ksz9021rn_phy_fixup().

Probably because nobody cared to use it.

> > I have a patch for setting ksz9031rn GTX/RX CLK pad skew in a similar
> > way over device tree and plan to submit it when the net-next merge
> > window for v3.16 opens.
> 
> So, you have already implemented the ksz9031 binding ?

Partially (for GTX/RX CLK). I'm attaching a patch that I currently have.
For ksz9031rn in my DTS fec node I used:

	/* ksz9031rn: min 0, max 1860, step 60 */
        rxc-skew-ps = <1620>;
        txc-skew-ps = <1620>;

Unfortunately I'm short on time and won't be able to implement other
pad skew settings in the near future, so please fill free to extend
and push the patch.

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-imx6-configure-ksz90x1rn-PHY-pad-skew-settings-o.patch
Type: text/x-patch
Size: 6002 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/f898a40d/attachment.bin>
