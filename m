From: ian.molton@codethink.co.uk (Ian Molton)
Date: Fri, 24 Aug 2012 16:56:09 +0200
Subject: [PATCH 5/6] arm: mvebu: add Aurora L2 Cache Controller to the DT
In-Reply-To: <1345799361-23735-6-git-send-email-gregory.clement@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
 <1345799361-23735-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50379609.1020006@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/12 11:09, Gregory CLEMENT wrote:
> + compatible = "marvell,aurora-cache-with-outer";

This reads wrong.

perhaps aurora-with-outer-cache?

or better, perhaps something like:

compatible = "marvell,armada370", "marvell,armada-370-xp";
    L2: l2-cache {
        compatible = "marvell,aurora-cache-with-outer";
        reg = <0xd0008000 0x1000>;
        cache-id-part = <0x100>;
        wt-override;
        with-outer="yes";
    };
