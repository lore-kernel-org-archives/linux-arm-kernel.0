From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 12:58:39 +0000
Subject: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
In-Reply-To: <20140121114845.GA2598@e103592.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140121114845.GA2598@e103592.cambridge.arm.com>
Message-ID: <20140127125839.GL15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 11:49:01AM +0000, Dave Martin wrote:
> I do have a worry that because the kernel won't normally use this
> information, by default it will get pasted between .dts files, won't get
> tested and will be wrong rather often.  It also violates the DT principle
> that probeable information should not be present in the DT -- ePAPR
> obviously envisages systems where cache geometry information is not
> probeable, but that's not the case for architected caches on ARM, except
> in rare cases where the CLIDR is wrong.

That statement is wrong.  There are caches on ARM CPUs where there is no
CLIDR register.  I suggest reading the earlier DDI0100 revisions.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
