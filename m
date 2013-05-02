From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 16:31:34 +0100
Subject: [PATCH v3 20/32] arm64: KVM: Plug the arch timer
In-Reply-To: <5177C577.2050209@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-21-git-send-email-marc.zyngier@arm.com>
 <20130423230024.GH20569@gmail.com> <5177C577.2050209@arm.com>
Message-ID: <20130502153134.GH20730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:43:51PM +0100, Marc Zyngier wrote:
> On 24/04/13 00:00, Christoffer Dall wrote:
> > On Mon, Apr 08, 2013 at 05:17:22PM +0100, Marc Zyngier wrote:
> >> Add support for the in-kernel timer emulation. The include file
> >> is a complete duplicate of the 32bit one - something to fix
> >> at one point.
> > 
> > again, I'd really like to see this fixed before we merge the code...
> 
> Feel free to suggest a solution. None of the one I tried are nice.

Both arch timers and GIC are now drivers outside the arch/ directories.
To me it makes sense for emulated device drivers to also live outside
the arch/ directories, something like virt/kvm/drivers? As you said,
ioapic is already in virt/kvm.

-- 
Catalin
