From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Mon, 30 Mar 2015 16:28:11 +0200
Subject: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
In-Reply-To: <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
References: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
 <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150330162811.3673482b@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015 14:59:31 +0000, Dave Martin wrote:
> Commit 734745c serial/amba-pl011: Activate TX IRQ passively
> adds some unnecessary complexity and overhead in the form of
> a softirq mechanism for transmitting in the absence of interrupts.
> 
> After some discussion [1], this turns out to be unnecessary.
> 
> This patch simplifies the code flow to reduce the reliance on
> subtle behaviour and avoid fragility under future maintenance.
> 
> To this end, the TX softirq mechanism is removed and instead
> pl011_start_tx() will now simply stuff the FIFO until full
> (guaranteeing future TX IRQs), or until there are no more chars
> to write (in which case we don't care whether an IRQ happens).
> 
> [1] Thanks to Jakub Kici?ski for his input and similar patch.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Signed-off-by: Jakub Kicinski <kubakici@wp.pl>
