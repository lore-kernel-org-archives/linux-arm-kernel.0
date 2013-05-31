From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 31 May 2013 11:36:17 +0100
Subject: [PATCH RFC 1/6] [HACK!] arm64/xen: create links to arch/arm
 include files and Xen code
In-Reply-To: <1369930713-6063-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
 <1369930713-6063-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130531103617.GA18045@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 05:18:28PM +0100, Stefano Stabellini wrote:
> Most of Xen support for ARM is common between ARMv7 and ARMv8.
> Create links to the code under arch/arm (bleah).
> 
> Other, probably better alternatives:
> 
> - move the code to a different location, maybe the header files to
> include/xen/arm and the code to drivers/xen/arm (still pretty ugly)?
> 
> - create a copy of the code to arch/arm64 (even worse);

KVM handles this in the Makefile by referencing back to arch/arm or even
the generic kvm directory. I think that's the 'cleanest' ;)

-- 
Catalin
