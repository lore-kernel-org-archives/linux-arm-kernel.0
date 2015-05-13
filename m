From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 17:42:51 +0100
Subject: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
In-Reply-To: <55535035.5070608@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
 <55535035.5070608@rock-chips.com>
Message-ID: <20150513164250.GB2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
> On 2015?05?13? 03:22, Mark Brown wrote:

> >Is it not possible to extend simple card to handle your use cases?
> >Given the very generic naming and the fact that things like jack
> >detection and so on should depend on the CODEC and board usually rather
> >than on the SoC it doesn't sound like this is Rockchip specific.

> >This also looks like you're reimplementing some device model enumeration
> >stuff which probably shouldn't be happening but let's understand the
> >problem you're trying to solve here before going too far into the code.

> Because we are trying to bring rt5650 in the project, so we intend to
> describe supported codecs with DTS via only a rockchip machine driver file,
> others remain pre-implement(like max98090 / rt5645 that vendor machine
> driver).

I don't undertand what you're saying here, sorry - why is this not just
a case of writing multiple machine drivers?

> I communicated with Dylan, and he told me that the jack detection is an
> issue in the simple-card, and suggested we are better to send them at
> present.

But what are these issues?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/ebaecac9/attachment.sig>
