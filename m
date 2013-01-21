From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 16:16:11 +0000
Subject: [PATCH 02/33] ARM: Convert to devm_ioremap_resource()
In-Reply-To: <20130121160547.GA10790@avionic-0098.adnet.avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
 <1358762966-20791-3-git-send-email-thierry.reding@avionic-design.de>
 <20130121155846.GN23505@n2100.arm.linux.org.uk>
 <20130121160547.GA10790@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130121161611.GS23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 05:05:47PM +0100, Thierry Reding wrote:
> On Mon, Jan 21, 2013 at 03:58:46PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 21, 2013 at 11:08:55AM +0100, Thierry Reding wrote:
> > > Convert all uses of devm_request_and_ioremap() to the newly introduced
> > > devm_ioremap_resource() which provides more consistent error handling.
> > 
> > Does this include the resource part of the handling too?
> 
> I'm not sure I understand your question. devm_ioremap_resource() does a
> devm_request_mem_region() internally if that's what you were asking.

Ah, that's fine then.  The function name is a little misleading, and as
it doesn't exist in mainline at present, it is not something I know about.
