From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Dec 2009 11:29:13 +0000
Subject: [RFC PATCH 01/10] PCMCIA: soc_common: convert to a stand alone
	module
In-Reply-To: <20091205110417.GA23213@isilmar.linta.de>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
	<4B194458.6040403@cam.ac.uk>
	<20091204172417.GE20386@n2100.arm.linux.org.uk>
	<20091205095633.GA20187@comet.dominikbrodowski.net>
	<20091205102816.GA10581@n2100.arm.linux.org.uk>
	<20091205110417.GA23213@isilmar.linta.de>
Message-ID: <20091205112913.GB10581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 05, 2009 at 12:04:17PM +0100, Dominik Brodowski wrote:
> Russell,
> 
> On Sat, Dec 05, 2009 at 10:28:16AM +0000, Russell King - ARM Linux wrote:
> > On Sat, Dec 05, 2009 at 10:56:33AM +0100, Dominik Brodowski wrote:
> > > Russell,
> > > 
> > > On Fri, Dec 04, 2009 at 05:24:17PM +0000, Russell King - ARM Linux wrote:
> > > > For the time being, I'll merge your patch into my git tree, but unless
> > > > Dominik hands my patches back to me for merging, it will be lost.
> > > 
> > > your patches -- which you asked me to merge and push upstream -- are on
> > > their way to Linus. I'll merge this bugfix to your patch later and push it
> > > upstream, too, unless you prefer to do that independently.
> > 
> > Yes I did at the time, but things change.  Since you've been totally silent
> > on the merge conflicts between your PCMCIA tree and my tree which SFR
> > reported on December 1st:
> 
> Well, as this was an addition through your tree, I didn't consider it
> neccessary to comment on it.

Which, in spite of the discussion surrounding the conflict, and the
resulting fall-out from it, would seem to have been the wrong decision.

> 
> > | Hi Dominik,
> > | 
> > | Today's linux-next merge of the pcmcia tree got a conflict in
> > | drivers/pcmcia/sa1100_h3600.c between commit
> > | 6ce8f65e71f0d80ee23b543be09789dd865a99be ("ARM: 5811/1: pcmcia: convert
> > | sa1100_h3600 driver to gpiolib") from the arm tree and commit
> > | 66024db57d5b9011e274b314affad68f370c0d6f ("PCMCIA: stop duplicating
> > | pci_irq in soc_pcmcia_socket") from the pcmcia tree.
> > | 
> > | I fixed it up (see below) and can carry the fix as necessary.  Please
> > | check the fix below.
> > ...
> > 
> > To which there was this reply:
> > | Fix looks good to me, and testing next-20091201 on real device (h3600)
> > | shows no problems with pcmcia.
> > | 
> > | Perhaps this merge conflict can be avoided by merging Russell's PCMCIA
> > | patches through arm tree. But, anyway, it's Russell and Dominik
> > | to decide.
> > 
> > And a reply from me agreeing that it would probably make more sense in
> > light of this for my patches to go through my tree.
> 
> Well, another option would have been to merge the other changes to
> drivers/pcmcia/ via PCMCIA -- something which has not even been suggested.

That would mean merging a bunch of other non-PCMCIA related changes
through your tree as well.

Do you want all the non-PCMCIA related changes in your tree as well?

> More and more I think some if not all PCMCIA socket drivers should reside in
> subdirectories to drivers/pcmcia/ .

That's a completely separate issue.
