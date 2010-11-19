From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 19 Nov 2010 18:32:27 +0000
Subject: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
In-Reply-To: <1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 19 Nov 2010 23:01:06 +0530")
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <yw1xfwux411g.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The AXI protocol specifies that the write response can only
> be sent back to an AXI master when the last write data has been
> accepted. This optimization enables the PL310 to send the write
> response of certain write transactions as soon as the store buffer
> accepts the write address. This behavior is not compatible with
> the AXI protocol and is disabled by default. You enable this
> optimization by setting the Early BRESP Enable bit in the
> Auxiliary Control Register (bit [30]).

Did you measure the performance difference this makes, if any?

-- 
M?ns Rullg?rd
mans at mansr.com
