From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Oct 2014 12:53:43 +0100
Subject: [PATCH RESEND 1/2] arm: hwcap: add new hwcap for identifying PXN
 bits
In-Reply-To: <1414151155-26890-1-git-send-email-js07.lee@gmail.com>
References: <1414151155-26890-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141024115342.GQ27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 08:45:54PM +0900, Jungseung Lee wrote:
> Modern ARMv7-A/R cores can optionally implement below new
> hardware feature:
> 
> - PXN:
> Privileged execute-never(PXN) is a security feature. PXN bit
> determines whether the processor can execute software from
> the region. This is effective solution against ret2usr attack.
> On an implementation that does not include the LPAE, PXN is
> optionally supported.
> 
> This patch adds new HWCAP defines to describe new feature.
> 
> In ARM world, elf_hwcap is used both internally in the kernel and
> for user space to keep track of optional features.
> HWCAP_PXN is exceptionally not exposed to user space since the user
> doesn't need to know.

Still no good.  Adding it into elf_hwcap always exposes it to the user.
Plus, these are a limited commodity, so we don't want to waste them.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
