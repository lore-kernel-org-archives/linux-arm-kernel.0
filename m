From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Aug 2017 17:07:03 +0100
Subject: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
In-Reply-To: <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
 <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
 <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
Message-ID: <20170822160703.nusf7sv6k4gj3pti@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 12:39:42PM -0700, Lori Hikichi wrote:

> By far the most common usage case for Cygnus is a configuration which
> uses only the three i2s/tdm ports. In this case each port is assigned
> a clock.  Each clock has the same capabilities so there would never be
> a reason change the static mapping.

The usual reason would be to bring things into sync.

> Now for the case when the "non-audio block" uses one of these clocks.
> In this situation we will only need one i2s port because this
> configuration of the chip is not audio intensive.  When the system
> is designed we know if this non-audio block will be in use, it is not
> a runtime configurable thing. Again, a static mapping is fine.

Is this limitation when the other block is in use a physical limitation
or is it just a case of not seeing the use case.

> At the time it did not seem necessary to make addition driver changes to
> support a use case that will very likely never arise. As it turns out,
> we are working on a new version of this audio block.  The clocking
> configuration for this new version is more complex and I am already in
> the process of creating clock bindings for all this this. I am hopeful
> that the driver for this new version will be applicable to Cygnus.

If the clocking is more complex that seems like even more reason to not
fix this in the binding, and possibly to do as I think I suggested
earlier and use the common clock bindings to manage this rather than
doing something custom and driver specific.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/11261f81/attachment-0001.sig>
