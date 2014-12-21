From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Dec 2014 13:05:51 +0100
Subject: [PATCH] ARM: mvebu: Fix pinctrl configuration for Armada 370 DB
In-Reply-To: <1418836043-19171-1-git-send-email-gregory.clement@free-electrons.com>
References: <1418836043-19171-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141221120551.GA28671@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 06:07:23PM +0100, Gregory CLEMENT wrote:
> The commit b4607572ef86 (ARM: mvebu: remove conflicting muxing on
> Armada 370 DB) removes the hog pins muxing. As it is explained in the
> commit log it solves a warning a boot time, but more important it also
> allows using the Giga port 0 of the board.
> 
> Unfortunately in the same time the commit 95d8dafe8554 (arm: mvebu:
> move Armada 370/XP pinctrl node definition armada-370-xp.dtsi) was
> merged and it introduced again the hog pins muxing. Because of it, the
> Giga port 0 of the board is no more usable.
> 
> This commit remove again the conflicting muxing (hopefully for the
> last time).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Added to mvebu/fixes

The commit IDs have changed somewhere along the way, so i fixed them
in the changelog.

   Andrew
