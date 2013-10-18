From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 13:48:32 +0100
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20131018103019.GW25034@n2100.arm.linux.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20131018003439.GG2443@sirena.org.uk>
 <20131018103019.GW25034@n2100.arm.linux.org.uk>
Message-ID: <20131018124832.GK2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 11:30:19AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 18, 2013 at 01:34:39AM +0100, Mark Brown wrote:

> > The last set of DPCMish patches was reported to work so should be a
> > fairly small refactoring away from being OK - the main thing is to
> > create back end DAIs for the physical links and then put the widgets
> > that manage the enable of the S/PDIF and I2S interfaces between the FE
> > and BE DAIs instead of directly connecting them to widgets on the CODEC.

> ROTFL.  You're now telling JF to do exactly what I did in my last patch.
> Your two-faced-ness is utterly astounding.

> "widgets that manage the enable of the S/PDIF and I2S interfaces between
> the FE and BE DAIs" is exactly what I did and you told me that was wrong.
> Make up your fscking mind.

No, this is not the case.  The major problem with your last set of
patches was that they did not create any back end DAIs, instead they
created purely DAPM routes from the single traditional DAI out to
widgets in the CODEC.  What I'm asking Jean-Francois to do above is
create and use back end DAIs.

Please let me also remind you that confrontational behaviour such as the
ad hominem remarks above is not at all constructive or helpful, please
keep the discussion civil.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/e792c37b/attachment.sig>
