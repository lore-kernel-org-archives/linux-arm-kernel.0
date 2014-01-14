From: bp@alien8.de (Borislav Petkov)
Date: Tue, 14 Jan 2014 22:48:50 +0100
Subject: [PATCH v5 0/4] Krait L1/L2 EDAC driver
In-Reply-To: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
References: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140114214850.GQ29865@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 01:30:30PM -0800, Stephen Boyd wrote:
> This patchset adds support for the Krait L1/L2 cache error detection
> hardware. The first patch adds the Krait l2 indirection
> register code. This patch is in need of an ACK from ARM folks.
> The next two patches add the driver and the binding and 
> the final patch hooks it all up by adding the device tree node.
> 
> I think Boris will pick up the first and third patches since they depend
> on each other. The final dts change could go through arm-soc via davidb's tree
> and the Documentation patch could go through the devicetree tree. Or patches 1
> through 3 can go through Boris' tree.
> 
> Changes since v4:
>  * Prefixed l2 accessors functions with krait_
>  * Dropped first two patches as Boris says he picked them up

Hey Stephen,

I'm going to send upstream only

[PATCH v4 1/6] edac: Don't try to cancel workqueue when it's never setup

as it is a clear bugfix.

The second one

[PATCH v4 2/6] genirq: export percpu irq functions for module usage

will have to wait for when the driver goes in. But the driver depends on
"ARM: Add Krait L2 register accessor functions" which still waits for
ACKs, right?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
