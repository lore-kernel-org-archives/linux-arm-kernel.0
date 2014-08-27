From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 27 Aug 2014 22:58:42 +0200
Subject: [PATCH 00/11] Fix arm64 issues highlighted by sparse and smatch
In-Reply-To: <20140826170529.GZ23445@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <20140826145614.GE6689@cbox> <20140826170529.GZ23445@arm.com>
Message-ID: <20140827205842.GA19836@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 06:05:29PM +0100, Will Deacon wrote:
> Hi Christoffer,
> 
> On Tue, Aug 26, 2014 at 03:56:14PM +0100, Christoffer Dall wrote:
> > On Tue, Aug 26, 2014 at 03:13:19PM +0100, Will Deacon wrote:
> > > Hi all,
> > > 
> > > After the static checking talk at kernel summit, I felt empowered to go
> > > and run sparse and smatch over the arm64 defconfig. As I anticipated,
> > > this spotted a few issues in the arch code, so I've fixed up the ones
> > > that aren't just noise in this series. Most are simply incorrect
> > > address space annotations, but fixing these is useful for spotting real
> > > issues in the future.
> > > 
> > > I don't think any of these fix critical bugs, but they all deserve to be
> > > addressed. I tagged the compat watchpoint fix for stable, as that code
> > > has been broken since we merged the architecture port.
> > > 
> > 
> > Do you want me to queue the kvm ones or did you have other plans to
> > upstream this entire series as one?
> 
> They're all independent, so please take the kvm ones via your tree. I can
> send a separate pull if you prefer? Jason -- would you like an
> irqchip-specific pull for those?
> 
> > Also, do you consider these fixes for 3.17 (what about cc for stable in
> > that case), or for 3.18?
> 
> The only one I CC'd stable for was the compat ptrace watchpoint patch,
> because that's something that we've been getting wrong and will cause
> breakage with a 32-bit GDB. I don't consider the others urgent (i.e. happy
> if you wait until 3.18).
> 
Applied to queue, thanks.
-Christoffer
