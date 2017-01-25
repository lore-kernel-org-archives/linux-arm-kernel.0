From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jan 2017 10:16:13 +0100
Subject: [PATCH v3 5/13] mmc: sunxi: Mask DATA0 when updating the clock
In-Reply-To: <CAPDyKFpX14Ojse_0gZZtQiUtSP_w9tN+Wu5OBx2Uv42FLSY5OA@mail.gmail.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <c36c2e2289ff3268d4a57b265f23725d882a23ed.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFpX14Ojse_0gZZtQiUtSP_w9tN+Wu5OBx2Uv42FLSY5OA@mail.gmail.com>
Message-ID: <20170125091613.hmlqoeh6hlqh57wh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 09:18:46AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A64 MMC controllers need DATA0 to be masked while updating the clock,
> > otherwise any subsequent command will result in a timeout.
> 
> Could you elaborate on what mask DATA0 really means? I don't follow.

To be honest, I don't really know :)

This is how it's called both in the vendor tree and the datasheet. I
*think* it might be the first data line on the bus, but I'm not sure
exactly why that would cause any issue when updating the clock.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/8ae4b973/attachment.sig>
