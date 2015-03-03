From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Mar 2015 11:44:51 +0100
Subject: [PATCH] ARM: ARMADA XP: WRT1900AC: Add support for the Ethernet
 switch
In-Reply-To: <54F57A41.1040102@free-electrons.com>
References: <1425154848-15441-1-git-send-email-andrew@lunn.ch>
 <54F57A41.1040102@free-electrons.com>
Message-ID: <20150303104451.GA10252@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 10:09:21AM +0100, Gregory CLEMENT wrote:
> Hi Andrew,
> 
> On 28/02/2015 21:20, Andrew Lunn wrote:
> > Add a DSA section to the DT blob representing the Ethernet switch.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > This patch requires at runtime patches in net-next,
> > 4c732668f98b96a0fa2645ac220fd9bbc17838c4
> 
> This dts fragment looks sane. The dependencies is only at runtime so
> it is less annoying for bissectability. So I tend applying it, however
> what happens if patch 4c732668f98b96a0fa2645ac220fd9bbc17838c4 is not
> present. Does the kernel crash? Or does it only make the Ethernet
> switch not available?

Hi Gregory

It does not crash. During probe of DSA, it fails to find the phy's
attached to the switch ports. This causes the probe to fail and the
switch drive gets unloaded.

       Andrew
