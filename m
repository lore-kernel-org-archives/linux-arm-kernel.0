From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Nov 2014 22:15:42 -0500
Subject: [PATCH 4/6] ARM: mvebu: remove conflicting muxing on Armada 370 DB
In-Reply-To: <1414512524-24466-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141107031542.GB3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 05:08:42PM +0100, Thomas Petazzoni wrote:
> Back when audio was enabled, the muxing of some MPP pins was causing
> problems. However, since commit fea038ed55ae ("ARM: mvebu: Add proper
> pin muxing on the Armada 370 DB board"), those problematic MPP pins
> have been assigned a proper muxing for the Ethernet interfaces. This
> proper muxing is now conflicting with the hog pins muxing that had
> been added as part of 249f3822509b ("ARM: mvebu: add audio support to
> Armada 370 DB").
> 
> Therefore, this commit simply removes the hog pins muxing, which
> solves a warning a boot time due to the conflicting muxing
> requirements.
> 
> Fixes: fea038ed55ae ("ARM: mvebu: Add proper pin muxing on the Armada 370 DB board")
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------
>  1 file changed, 24 deletions(-)

Patches 5 and 6 applied to mvebu/dt with Andrew's Ack.

I didn't Cc this one to stable since it is only removing a warning.
Later on, if needed, someone can request it be backported and the Fixes
tag will assist with that.

thx,

Jason.
