From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Aug 2014 08:43:44 +0100
Subject: [PATCH] arm: Do not overwrite __machine_arch_type
In-Reply-To: <1408418491-29330-1-git-send-email-van.freenix@gmail.com>
References: <1408418491-29330-1-git-send-email-van.freenix@gmail.com>
Message-ID: <20140819074344.GA30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 11:21:31AM +0800, Peng Fan wrote:
> If using DT_MACHINE_START when enabled CONFIG_OF, the nr of mdesc is ~0.
> The value of __machine_arch_type is passsed from bootloader using reigster
> r1, and assigned in head-common.S. Remove this line to avoid overwrite it.

No.  The idea here is that the machine_is_xxx() methods are not used when
using DT, so this disables them.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
