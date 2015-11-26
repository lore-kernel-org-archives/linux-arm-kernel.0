From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Nov 2015 19:33:01 +0100
Subject: [PATCH v2 net 6/6] net: mvneta: enable IP checksum with jumbo
 frames for Armada 38x on Port0
In-Reply-To: <1448561293-16431-7-git-send-email-mw@semihalf.com>
References: <1448561293-16431-1-git-send-email-mw@semihalf.com>
 <1448561293-16431-7-git-send-email-mw@semihalf.com>
Message-ID: <20151126193301.67259f76@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcin,

On Thu, 26 Nov 2015 19:08:13 +0100, Marcin Wojtas wrote:
> The Ethernet controller found in the Armada 38x SoC's family support
> TCP/IP checksumming with frame sizes larger than 1600 bytes, however
> only on port 0.
> 
> This commit enables it by setting 'tx-csum-limit' to 9800B in
> 'ethernet at 70000' node.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v3.18+

This and the previous patch is not a fix, and has no business going in
stable. It is enabling a better functionality, but it is clearly not a
fix.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
