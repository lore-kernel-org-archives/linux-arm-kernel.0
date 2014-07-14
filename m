From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 12:31:18 +0100
Subject: [PATCH V2 1/2] ASoC: samsung: Add machine driver for Odroid X2/U3
In-Reply-To: <53C3BEB9.7000706@samsung.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
 <20140630184658.GE23300@sirena.org.uk>
 <53C3BEB9.7000706@samsung.com>
Message-ID: <20140714113118.GE6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 01:27:53PM +0200, Sylwester Nawrocki wrote:

> Too bad, I noticed this comment only just now.  I'll consider this and
> will try again and see how simple-card could be used.  There is also the
> samsung-i2s-sec secondary 'overlay' CPU DAI that would need to be handled,
> and we have it now internally specified in the machine driver through
> cpu_dai_name, rather than cpu_of_node.
> There might be some more work in the driver needed to support the
> secondary I2S interface generically with DT.

You should be converting the device to DPCM for both that and the
compressed audio path.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/767589e9/attachment.sig>
