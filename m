From: w@1wt.eu (Willy Tarreau)
Date: Wed, 4 Sep 2013 18:32:45 +0200
Subject: [PATCH] net: mvneta: properly disable HW PHY polling and ensure
 adjust_link() works
In-Reply-To: <1378304478-21237-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1378304478-21237-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130904163245.GI20552@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas!

On Wed, Sep 04, 2013 at 04:21:18PM +0200, Thomas Petazzoni wrote:
> This commit fixes a long-standing bug that has been reported by many
> users: on some Armada 370 platforms, only the network interface that
> has been used in U-Boot to tftp the kernel works properly in
> Linux. The other network interfaces can see a 'link up', but are
> unable to transmit data. The reports were generally made on the Armada
> 370-based Mirabox, but have also been given on the Armada 370-RD
> board.
(...)
> This patch has been tested on Armada 370 Mirabox, and now both network
> interfaces are usable after boot.

Just as a complementary check, I can also confirm that the OpenBlocks
AX3 continues to work fine after this change.

Best regards!
Willy
