From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Jan 2013 23:48:12 +0800
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
Message-ID: <20130123154804.GB4565@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 12:39:35PM +0000, Hebbar, Gururaja wrote:
> On Fri, Jan 04, 2013 at 17:56:12, Mark Brown wrote:

> > The CODEC driver biases should be changed over to be supplies, this
> > makes the above much more natural - the routing there is a hack for
> > older versions of ASoc.  Otherwise this looks fine.

> ON TLV320AIC3x Codec, MIC Bias power on/off share the same register bits
> with Bias voltage output.

So you need to use an event to write the actual enable bit.

> SGTL5000 --> Single register for MIC BIAS enable & output impedance of MIC
> Bias. The driver uses SND_SOC_DAPM_POST_PMU & SND_SOC_DAPM_PRE_PMD macro to
> handle the MIC Bias enable & disable event.

This is the way these things should be handled.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/8e8582a0/attachment.sig>
