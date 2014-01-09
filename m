From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Jan 2014 10:30:05 +0000
Subject: [PATCH v3] arm: remove !CPU_V6 and !GENERIC_ATOMIC64 build
 dependencies for XEN
In-Reply-To: <1389204023-26912-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1389204023-26912-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20140109103004.GB11089@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On Wed, Jan 08, 2014 at 06:00:23PM +0000, Stefano Stabellini wrote:
> Remove !GENERIC_ATOMIC64 build dependency:
> - rename atomic64_xchg to armv7_atomic64_xchg and define it even ifdef
>   GENERIC_ATOMIC64;
> - call armv7_atomic64_xchg directly from xen/events.h.
> 
> Remove !CPU_V6 build dependency:
> - introduce __cmpxchg8 and __cmpxchg16, compiled even ifdef
>   CONFIG_CPU_V6;
> - implement sync_cmpxchg using __cmpxchg8 and __cmpxchg16.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: arnd at arndb.de
> CC: linux at arm.linux.org.uk
> CC: will.deacon at arm.com
> CC: gang.chen at asianux.com
> CC: catalin.marinas at arm.com
> CC: jaccon.bastiaansen at gmail.com
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> 

I'm confused here. It looks like you want to call armv7 code in a v6 kernel.
What am I missing?

Will
