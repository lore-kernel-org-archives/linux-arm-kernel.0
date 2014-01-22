From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 22 Jan 2014 09:43:51 +0000
Subject: [Xen-devel] [PATCH v4] arm: remove !CPU_V6 and
 !GENERIC_ATOMIC64 build dependencies for XEN
In-Reply-To: <1390311864-19119-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1390311864-19119-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1390383831.32519.26.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-01-21 at 13:44 +0000, Stefano Stabellini wrote:
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

Acked-by: Ian Campbell <ian.campbell@citrix.com>
