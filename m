From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 13 Oct 2018 09:28:23 +0200
Subject: [GIT PULL] Couple more arm64 fixes for 4.19
In-Reply-To: <20181012154629.GB11387@arm.com>
References: <20181012154629.GB11387@arm.com>
Message-ID: <20181013072823.GA27804@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 04:46:29PM +0100, Will Deacon wrote:
> Hi Greg,
> 
> Please pull these two arm64 fixes for 4.19. One of them fixes a nasty
> WARN() that has started triggering because we assumed that memory
> reservations from firmware would always correspond to regions of the
> physical address space that we have mapped as memory. Unfortunately,
> some existing device-tree files break this assumption and we need to
> continue supporting them. The other fix addresses an issue where a
> CHAIN PMU event can be requested as a 32-bit counter via perf, which
> makes no sense in isolation since these events are intended to be used
> in conjunction with another event when creating a 64-bit counter.
> 
> This is summarised in the tag.

Now merged, thanks.

greg k-h
