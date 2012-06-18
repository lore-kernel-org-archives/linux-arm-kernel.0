From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 12:35:48 +0100
Subject: [RFC PATCH 5/8] AMP: smp: Extend number of IPIs
In-Reply-To: <1340019011-18642-6-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-6-git-send-email-monstr@monstr.eu>
Message-ID: <20120618113548.GE12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 01:30:08PM +0200, Michal Simek wrote:
> GIC supports up to 16 IPIs.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> 
> ---
> Please correct me if this code is also designed for different
> interrupt controller which doesn't support 16 IPIs.

This code is not specific to the GIC.  We use NR_IPI to indicate the
number of IPIs that the kernel actually uses, not the number which the
hardware provides.
