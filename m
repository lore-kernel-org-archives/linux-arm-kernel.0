From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 18:05:30 +0000
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1294335614.22825.154.camel@mulgrave.site>
References: <20110105200008.GJ8638@n2100.arm.linux.org.uk>
	<1294259637.16957.25.camel@mulgrave.site>
	<AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
	<20110105210448.GM8638@n2100.arm.linux.org.uk>
	<AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm@mail.gmail.com>
	<1294262208.2952.4.camel@heimdal.trondhjem.org>
	<AANLkTi=3Gu-rz=-OdNtUXn4qw60Df6=YePnzvB=s-+Ov@mail.gmail.com>
	<1294268808.2952.18.camel@heimdal.trondhjem.org>
	<1294270104.16957.73.camel@mulgrave.site>
	<1294335614.22825.154.camel@mulgrave.site>
Message-ID: <20110106180530.GI31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 11:40:13AM -0600, James Bottomley wrote:
> On Wed, 2011-01-05 at 23:28 +0000, James Bottomley wrote:
> > Can you explain how the code works? it looks to me like you read the xdr
> > stuff through the vmap region then write it out directly to the pages? 
> 
> OK, I think I see how this is supposed to work:  It's a sequential loop
> of reading in via the pages (i.e. through the kernel mapping) and then
> updating those pages via the vmap.  In which case, I think this patch is
> what you need.
> 
> The theory of operation is that the readdir on pages actually uses the
> network DMA operations to perform, so when it's finished, the underlying

What network DMA operations - what if your NIC doesn't do DMA because
it's an SMSC device?
