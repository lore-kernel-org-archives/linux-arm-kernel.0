From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Feb 2014 19:48:55 -0700
Subject: [PATCH V2] ARM: bcm2835: fix clock DT node names
In-Reply-To: <1392960587-29355-1-git-send-email-swarren@wwwdotorg.org>
References: <1392960587-29355-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <530C0497.9040808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 10:29 PM, Stephen Warren wrote:
> DT nodes should be named according to the type of object that they
> represent rather than the identity. DT nodes that contain a reg
> property should include a unit address in their name. Fix these issues.
> 
> Add clock-output-names properties to the nodes so that the clocks get
> named something meaningful. This works around the fact that the fixed
> clock driver names clocks after the short node name, i.e. not including
> the unit address.

I've applied this to bcm2835's for-3.15/dt branch.
