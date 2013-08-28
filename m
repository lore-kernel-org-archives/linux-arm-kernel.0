From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Aug 2013 02:22:15 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130823174505.GQ6617@n2100.arm.linux.org.uk>
References: <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
 <20130823165800.GB30617@sirena.org.uk>
 <20130823174505.GQ6617@n2100.arm.linux.org.uk>
Message-ID: <20130828012215.GF10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 06:45:05PM +0100, Russell King - ARM Linux wrote:

> Look Mark, frankly, shut your fucking mouth up about DPCM.  This bug has
> nothing what so ever to do with DPCM, and the more times you try and
> state that doesn't change that *FACT*.  And it is a FACT.

You must know that this and the rest of your e-mail are not an
appropriate or constructive way to interact with people.

I now regret that have not confronted you on this more openly and
directly before but unfortunately I had hoped that stepping back would
help with deescalation.  I know I have needed to take a step back on
several occasions myself in order to be calmer in my response.

> So that's why it fails _without_ any DPCM stuff?  That's why the codecs
> fail to have their set_bias stuff called?

So, it is true that the widgets get double created in all cases where
the same struct device is used for both platform and DAI.  However if
DPCM is not used nothing really notices since the SoC side widgets don't
do anything useful.  The relevance of DPCM is that it tries to use the
widgets and therefore causes practical problems in normal use, otherwise
it's just a memory leak on init.

As you know the issue with the DAPMless CODECs was unrelated to this,
was due to poor test coverage of such devices and has been resolved by
making DAPM mandatory for CODECs to eliminate the possibility of similar
regressions caused by the need for special casing.

> You've had this problem described by IRC, including extracts from the
> ASoC code indicating where things go wrong.  I've shown you the debug
> I've used.  I've shown you the result of that debug.  You've had
> descriptions of this problem via email too.  Yet you refuse to acknowledge
> that there could possibly be a problem here.

I am fairly sure that I have agreed that there is a bug and at the very
least not said that everything is fine.  Just for the record there
clearly is a bug with double creation of DAI widgets when the same
struct device is used to register both a DAI and a platform.  You will
also recall that Liam said he would provide a patch when he has time.

As I have told you before your generally confrontational and demanding
approach is not a good one for getting help from people, it doesn't help
push your problems up the priority list or generate positive attention.
Especially with the more extreme examples it can actively work against
engagement; at an unconscious level it makes things less fun and at a
conscious level not only are breaks for calm needed but I know that I at
least have no desire to encourage anyone to believe that this is a good
way of getting results.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/eb576630/attachment.sig>
