From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 09:35:01 -0500
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160414143501.GA25212@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 05:12:55PM -0500, tthayer at opensource.altera.com wrote:
> This patch set adds the memory initialization functions for Altera's
> Arria10 peripherals, the first of which is the Ethernet EDAC. The
> first 3 patches add the memory initialization functionality. The
> last 3 patches add Ethernet EDAC support.

The ethernet part seems a bit strange to me to put under EDAC as EDAC 
is primarily memory controller ECC (and caches to some extent). Also you 
would not halt the system in case of an UC, but rather just drop the 
frame. This would need to be part of the ethernet driver in that case.
 
Of course, given that ethernet frames already have a CRC, ECC of the 
FIFO seems a bit redundant.

Rob
