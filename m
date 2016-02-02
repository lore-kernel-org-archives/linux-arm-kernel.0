From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Feb 2016 19:38:39 +0000
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1454069479.10861.30.camel@mtksdaap41>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
 <56AA5A5C.9080402@openwrt.org>
 <20160128231306.GD4130@sirena.org.uk>
 <1454061134.10861.14.camel@mtksdaap41>
 <20160129112717.GP4130@sirena.org.uk>
 <1454069479.10861.30.camel@mtksdaap41>
Message-ID: <20160202193839.GX4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 08:11:19PM +0800, menghui lin wrote:
> On Fri, 2016-01-29 at 12:27 +0100, Mark Brown wrote:

> > None of this is answering my question - I know what the current API is,
> > describing it doesn't tell me about actual users or how they are able to
> > sensibly use the interface.  Bear in mind that the definitions of the
> > various modes are all relative and what one device thinks is high usage
> > may be low usage for another device.

> Assuming valid_modes_mask and initial_mode are specified, a possible
> way to modify regulator_set_mode() is to allow mode change only if the
> regulator is controlled exclusively by a certain consumer or the
> requested mode provides stronger power capability than current mode.
> Here I assume that power capability fast > normal > idle > standby.

How does the driver know if it needs to change the mode (ie, how can it
tell if the current mode is inadequate) and surely if we can only change
in one direction this isn't terribly useful?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/ef0615f7/attachment.sig>
