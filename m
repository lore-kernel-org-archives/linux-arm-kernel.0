From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jan 2014 18:07:50 +0000
Subject: [PATCH v4] arm: remove !CPU_V6 and !GENERIC_ATOMIC64 build
 dependencies for XEN
In-Reply-To: <1390311864-19119-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1390311864-19119-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20140121180750.GO30706@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 01:44:24PM +0000, Stefano Stabellini wrote:
> Remove !GENERIC_ATOMIC64 build dependency:
> - introduce xen_atomic64_xchg
> - use it to implement xchg_xen_ulong
> 
> Remove !CPU_V6 build dependency:
> - introduce __cmpxchg8 and __cmpxchg16, compiled even ifdef
>   CONFIG_CPU_V6
> - implement sync_cmpxchg using __cmpxchg8 and __cmpxchg16
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: arnd at arndb.de
> CC: linux at arm.linux.org.uk
> CC: will.deacon at arm.com
> CC: catalin.marinas at arm.com
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> CC: xen-devel at lists.xenproject.org

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Cheers Stefano,

Will
