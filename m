From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Apr 2015 10:58:03 +0100
Subject: [PATCH 0/2] Cygnus Audio Driver
In-Reply-To: <551EEAF8.7050108@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <20150331064338.GE2869@sirena.org.uk>
 <551EEAF8.7050108@broadcom.com>
Message-ID: <20150406095803.GD6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 12:33:12PM -0700, Scott Branden wrote:
> On 15-03-30 11:43 PM, Mark Brown wrote:
> >On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:

> >>The audio PLL is embedded in the audio block and only used
> >>by the audio block. The audio PLL registers are also in the middle of
> >>the audio register map.

> >When you say it's only used by the audio block do you mean to say that
> >the audio block exposes no clock signals other than the bit and frame
> >clocks?

> The audio block exposes the MCLK in addition to the bit and frame clock.

OK, then it's going to need to be a clock provider at some point - the
clock will be going into external devices which are going to need to be
able to interact with the clock (for example, to get the rate).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/9c025e98/attachment.sig>
