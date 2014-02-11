From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Feb 2014 12:55:13 -0300
Subject: [PATCH 0/2] Armada 375/38x MBus support
In-Reply-To: <1392060298-27094-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392060298-27094-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140211155512.GA24205@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:24:56PM -0300, Ezequiel Garcia wrote:
> As part of the submission of the Armada 375/38x initial support, these
> two small patches add MBus support.
> 
> You will find that despite the MBus support being identical for the whole
> SoC family: Armada 370/XP/375 and 38x, we have per-SoC compatible for each
> of them.
> 
> Such decision is being currently discussed; see:
> 
> http://www.spinics.net/lists/arm-kernel/msg306480.html
> 

These patches are not required, so please omit them entirely.
The new agreement [1] is to add SoC-specific compatible strings and also
declare the nodes as compatibles with the already supported SoC,
whenever appropriate.

For instance, the devicetrees for Armada 375 would have this mbus node:

  mbus {
    compatible = "marvell,armada375-mbus", "marvell,armada370-mbus"
  }

And therefore, we don't need any changes in the driver for now.

[1] http://www.spinics.net/lists/arm-kernel/msg306727.html
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
