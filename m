From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Apr 2012 11:48:58 +0100
Subject: [PATCH 1/2] clk: Provide dummy clk_unregister()
In-Reply-To: <20120418095435.GX24211@n2100.arm.linux.org.uk>
References: <1334736433-3402-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120418095435.GX24211@n2100.arm.linux.org.uk>
Message-ID: <20120418104857.GI3021@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 10:54:35AM +0100, Russell King - ARM Linux wrote:

> Don't make unregister calls return values.  Think about this situation
> for a moment:

> 	You call an unregister function in a drivers ->remove function.
> 	The unregister function fails.  However, the reason the ->remove
> 	function is being called is because the module is being removed.
> 	You can't stop the module being removed once the process has
> 	started.  What do you do with this error?

> To put it another way, if an unregister function fails, you're buggered.

I absolutely agree, I think this is a stupid pattern for us to have
(generally the return values just get ignored...) but sadly it appears
to be the pattern that we have return values but ignore them probably
because the driver model does this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/a8e2a324/attachment.sig>
