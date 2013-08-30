From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Aug 2013 10:56:59 +0100
Subject: [alsa-devel] [PATCH RFC 00/13] Adding SPDIF support to
 kirkwood-i2s
In-Reply-To: <5220571F.5020006@metafoo.de>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <51FFB267.3030107@metafoo.de>
 <87wqnzhek5.wl%kuninori.morimoto.gx@renesas.com>
 <87li3jr6et.wl%kuninori.morimoto.gx@renesas.com>
 <5220571F.5020006@metafoo.de>
Message-ID: <20130830095659.GV10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 10:26:07AM +0200, Lars-Peter Clausen wrote:
> On 08/30/2013 09:20 AM, Kuninori Morimoto wrote:

> > My understanding for this ASoC DT support milestone is that

> >  1) merge codec/component
> >  2) add .of_xlate_dai_name on it
> >  3) add DT support

> > But, do you think 1) is possible ?
> > Becouse, now, too many functions are based on/using "codec"
> > struct snd_soc_codec / struct snd_soc_codec_driver.
> > In reality, merging these is super difficult IMO.

> The idea is to use the component struct as a base class for the codec and
> platform struct. So drivers will keep seeing what they see now and don't
> need to be updated. Lots of the fields that can be shared between component,
> platform and codec are only used by the core.

Indeed, and doing things that can be done with a direct search and
replace is not so bad.  Splitting  things up makes life easier too.  I'd
been planning to start looking at the merge of CODEC and component
myself during the next release cycle.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130830/2711b8cf/attachment.sig>
