From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 16:56:14 +0200
Subject: [PATCH 00/11] Fix arm64 issues highlighted by sparse and smatch
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140826145614.GE6689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:19PM +0100, Will Deacon wrote:
> Hi all,
> 
> After the static checking talk at kernel summit, I felt empowered to go
> and run sparse and smatch over the arm64 defconfig. As I anticipated,
> this spotted a few issues in the arch code, so I've fixed up the ones
> that aren't just noise in this series. Most are simply incorrect
> address space annotations, but fixing these is useful for spotting real
> issues in the future.
> 
> I don't think any of these fix critical bugs, but they all deserve to be
> addressed. I tagged the compat watchpoint fix for stable, as that code
> has been broken since we merged the architecture port.
> 
Thanks for these!

Do you want me to queue the kvm ones or did you have other plans to
upstream this entire series as one?

Also, do you consider these fixes for 3.17 (what about cc for stable in
that case), or for 3.18?

-Christoffer
