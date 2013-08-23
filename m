From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 17:58:00 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130823125803.GN6617@n2100.arm.linux.org.uk>
References: <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
Message-ID: <20130823165800.GB30617@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 01:58:03PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 23, 2013 at 01:13:14PM +0100, Liam Girdwood wrote:

> > You asked me privately to Ack the series so you could carry it in your
> > own tree for upstreaming. Sorry if I misunderstood this request, but it
> > seemed straightforward.

> What I'm after are acks for those patches which are acceptable - which
> I believe is the entire series with the exception of the HACK patch.

If there no dependency then why is that patch included as part of this
series, especially so early on?  Obviously we shouldn't cause problems
for existing machines in mainline so I stopped applying patches which
seemed like they might depend on that one.  I had at the time been
expecting a revised version of the series to follow in due course with a
better fix as at the time the hack was sent you'd only just determined
what the problem was.

> The split of the DMA backend from the CPU DAI backend is something
> which early ASoC forced, but that has "mostly" been fixed with (as
> far as I'm currently aware through testing) the problem I've been

Essentially all the dmaengine based platforms in mainline use a shared
device for DMA and DAI; I'm fairly sure someone would have mentioned if
there were problems.  

As you have been repeatedly told the Kirkwood drivers are the first
drivers submitted to mainline which use DPCM and therefore it is not
surprising that there are a few issues which need to be worked through,
there were a few revisions to the framework which went in as a result of
review during the mainline merge.  The problem you are seeing here is
due to this being the first platform with a *shared* device to use DPCM.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/346cbdd5/attachment.sig>
