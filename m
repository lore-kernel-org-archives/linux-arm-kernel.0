From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 22 Aug 2014 09:31:20 -0700
Subject: [PATCH 3/3] ARM: zynq: DT: Add Ethernet phys
In-Reply-To: <20140822162048.GB8477@obsidianresearch.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
 <5a7b6f57-b6c0-4fb3-af0d-d403277c0207@BN1AFFO11FD045.protection.gbl>
 <53F5D8D9.7040604@suse.de>
 <f166a186-301c-4288-97cf-71f8173c07e7@BN1AFFO11FD010.protection.gbl>
 <20140822162048.GB8477@obsidianresearch.com>
Message-ID: <d31d72f2-acac-4aa3-b992-fc244ac6db4e@BY2FFO11FD005.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-22 at 10:20AM -0600, Jason Gunthorpe wrote:
> On Thu, Aug 21, 2014 at 08:49:19AM -0700, S?ren Brinkmann wrote:
> 
> > So my thinkings:
> >  - the compatible string with the -c22 is used and documented in the phy
> >    bindings, it should be there.
> 
> Yes
> 
> >  - the ID based strings seem to be not needed since, IIUC, the core
> >    reads the ID from the PHY and uses it, so I just left it out not
> >    trying to figure out how to obtain the correct ID
> 
> It is certainly optional, I added the property to solve some obscure
> problems with probing, but I've noticed people using it more broadly.
> I suspect it also speeds up booting a tiny bit.
> 
> >  - the marvell compatible strings are used in our vendor tree. They
> >    aren't used anywhere but in our vendor tree. I though keeping them is
> >    nice since it identifies the PHY fully. And in case that level of
> >    detail is needed at some point it is already there.
> 
> DT is complex enough already, don't include useless compatible strings
> in mainline - people will see and tend to blindly copy. Ideally your
> vendor tree would use the standard property :|

There are different opinions on this. I also heard to just add such
strings, so in case this level of differentiation becomes necessary at
some later point, it is already existing.

	S?ren
