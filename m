From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 10:24:29 +0100
Subject: [PATCH 0/5] arm64: Initial support for Marvell Armada 7K/8K
In-Reply-To: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2808783.Lm9AZL1OAe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 09:47:40 Thomas Petazzoni wrote:
> Hello,
> 
> This series adds initial support for the new Armada 7K and 8K Marvell
> 64 bits processors. Details about those processors based on the
> Cortex-A72 can be found at:
> 
>   http://www.marvell.com/embedded-processors/armada-70xx/
>   http://www.marvell.com/embedded-processors/armada-80xx/
> 
> One characteristic of those processors is that internally they are
> built from several components:
> 
>  - One "AP", which contains the processor itself and a few core IP
>    blocks. The AP in 7K and 8K is called AP806, and is available on
>    two variants: dual Cortex-A72 and quad Cortex-A72.
> 
>  - Or or two "CP", which contains most of the I/Os (SATA, PCIe,
>    etc.). The CP in 7K and 8K is called CP110. One CP110 is available
>    in the 7K family, while two CP110 are available in the 8K family,
>    doubling the number of I/O interfaces.
> 
> The support added in this series only brings minimal support for the
> AP side (and not yet all IP blocks, obviously). Support for the CP
> part will come in the future.
> 
> Since the series touches similar files as the Armada 3700 series from
> Gregory Clement, it is based on it.

The new code looks ok, but I think I need to resubmit my cleanup of the
Documentation/arm/Marvell/README fiel that I submitted a while ago,
which now conflicts with the changes you did in patch 3.

If you don't mind, can you add my patch to your series to resolve
the conflict? I'll resend in a minute.

	Arnd
