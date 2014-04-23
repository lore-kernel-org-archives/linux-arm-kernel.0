From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Apr 2014 22:54:33 +0400
Subject: [PATCH 05/14] ARM: shmobile: koelsch-reference: Work around core
 clock issues
In-Reply-To: <20140423002254.GD5738@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
 <53cf0cf7ba2ef785b339826a0765bb6b1756adeb.1397774191.git.horms+renesas@verge.net.au>
 <5356D0B8.5010406@cogentembedded.com> <20140423002254.GD5738@verge.net.au>
Message-ID: <53580C69.20602@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/23/2014 04:22 AM, Simon Horman wrote:

>>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

>>> Due to issues with runtime PM clock management, clocks not explicitly
>>> managed by their drivers may not be enabled at all, or be inadvertently
>>> disabled by the clk_disable_unused() late initcall.

>>> Until this is fixed, add a temporary workaround, calling
>>> shmobile_clk_workaround() with enable == true.

>>> For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
>>> thermal. More clocks can be added if needed.

>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

>>     It is strange but this workaround doesn't seem to help me booting Koelsch
>> reference kernel with NFS root: it still crashes due to imprecise
>> external abort once the userland starts. Only the actual drivers/sh/

    Unfortunately, I currently don't have time to find out what is wrong with 
the workaround...

>> fixing series by Ben/Geert helps with booting further. I therefore
>> would like to have it merged by Simon the sooner the better...

> For my reference, specifically which patches are you referring to?

    Here the link to the cover letter of the 17 patch series:
http://marc.info/?l=linux-sh&m=139756526122104

WBR, Sergei
