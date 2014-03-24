From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Mar 2014 11:06:16 +0000
Subject: [RFC PATCH] ASoC: wm8904: add CCF support
In-Reply-To: <532F9557.2000402@atmel.com>
References: <1395370262-23305-1-git-send-email-voice.shen@atmel.com>
 <20140321103747.GK23372@e106331-lin.cambridge.arm.com>
 <20140321115511.GM11706@sirena.org.uk> <532F9557.2000402@atmel.com>
Message-ID: <20140324110616.GG2269@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 10:15:51AM +0800, Bo Shen wrote:
> On 03/21/2014 07:55 PM, Mark Brown wrote:
> >On Fri, Mar 21, 2014 at 10:37:47AM +0000, Mark Rutland wrote:
> >>On Fri, Mar 21, 2014 at 02:51:02AM +0000, Bo Shen wrote:

> >>>+  - wlf,sysclk-from-mclk: set the sys clock is driven from mclk,

> >>Why can the kernel not decide this?

> >It can.

> I really don't know how it decided by kernel (hardcode in machine driver ?),
> can you point me directly? Thanks.

It can just look to see if there is a suitable system clock present,
this shouldn't be hard.  If there's a clock connected at a suitable
rate it should use that, otherwise if there's a clock at an unsuitable
rate it should either change the rate of the clock or use the FLL.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/c223255f/attachment.sig>
