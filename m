From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Mar 2017 16:56:32 +0100
Subject: [PATCH] ARM: sun8i: a33: remove highest OPP to fix CPU crashes
In-Reply-To: <20170320112551.25825-1-quentin.schulz@free-electrons.com>
References: <20170320112551.25825-1-quentin.schulz@free-electrons.com>
Message-ID: <20170321155632.k7vtmkorucsspnun@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:25:51PM +0100, Quentin Schulz wrote:
> The highest supported frequency (1.2GHz) requires to "overvolt" the CPU.
> However, some boards still do not have the cpu-supply DT property in the
> cpu DT node which means that the CPU will always run with the same input
> voltage but try to run at 1.2GHz frequency. This is the source of
> (experienced) CPU crashes.
> 
> Remove the OPP which requires overvolting the CPU until all boards have
> a cpu-supply property.
> 
> Fixes: 03749eb88e635ad67818827adde8e5eea7b64571 ("ARM: dts: sun8i: add
> opp-v2 table for A33")

The commit ID must be 12 chars, as documented in
Documentation/process/submitting-patches.rst.

You can also use the pretty format given there to be sure to have it
right.

> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/7ac25a32/attachment.sig>
