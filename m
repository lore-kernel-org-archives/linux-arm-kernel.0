From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 28 Jul 2015 11:03:00 +0100
Subject: [Xen-devel] [PATCH v3] xen/events: Support event channel rebind
 on ARM
In-Reply-To: <1438074642-20809-1-git-send-email-julien.grall@citrix.com>
References: <1438074642-20809-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55B75354.8050003@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/15 10:10, Julien Grall wrote:
> Currently, the event channel rebind code is gated with the presence of
> the vector callback.
> 
> The virtual interrupt controller on ARM has the concept of per-CPU
> interrupt (PPI) which allow us to support per-VCPU event channel.
> Therefore there is no need of vector callback for ARM.
> 
> Xen is already using a free PPI to notify the guest VCPU of an event.
> Furthermore, the xen code initialization in Linux (see
> arch/arm/xen/enlighten.c) is requesting correctly a per-CPU IRQ.
> 
> Introduce new helper xen_support_evtchn_rebind to allow architecture
> decide whether rebind an event is support or not. It will always return
> 1 on ARM and keep the same behavior on x86.
> 
> This is also allow us to drop the usage of xen_have_vector_callback
> entirely in the ARM code.

Applied to for-linus-4.3, thanks.

David
