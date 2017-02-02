From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:30:58 +0100
Subject: [RFC v3 08/10] KVM: arm/arm64: Set up a background timer for the
 physical timer emulation
In-Reply-To: <1485970990-13775-9-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-9-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202103058.GG27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:08PM -0500, Jintack Lim wrote:
> Set a background timer for the EL1 physical timer emulation while VMs
> are running, so that VMs get the physical timer interrupts in a timely
> manner.
> 
> Schedule the background timer on entry to the VM and cancel it on exit.
> This would not have any performance impact to the guest OSes that
> currently use the virtual timer since the physical timer is always not
> enabled.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
