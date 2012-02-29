From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 29 Feb 2012 09:56:02 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <20120229093436.GA2077@linaro.org>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <20120227180355.GB2023@linaro.org>
 <1330371219.10008.34.camel@dagon.hellion.org.uk>
 <20120228102040.GB2063@linaro.org>
 <1330426133.31269.70.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.00.1202281149210.23091@kaball-desktop>
 <20120229093436.GA2077@linaro.org>
Message-ID: <1330509362.4270.20.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-29 at 09:34 +0000, Dave Martin wrote:
> On Tue, Feb 28, 2012 at 12:28:29PM +0000, Stefano Stabellini wrote:

> > I don't have a very strong opinion on which register we should use, but
> > I would like to avoid r7 if it is already actively used by gcc.
> 
> But there is no framepointer for Thumb-2 code (?)

Peter Maydell suggested there was:
> r7 is (used by gcc as) the Thumb frame pointer; I don't know if this
> makes it worth avoiding in this context.

Sounds like it might be a gcc-ism, possibly a non-default option?

Anyway, I think r12 will be fine for our purposes so the point is rather
moot.

Ian.
