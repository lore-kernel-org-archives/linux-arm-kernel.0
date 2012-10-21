From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 21 Oct 2012 21:09:02 +0200
Subject: [RFC 00/11] Convert Kirkwood to pinctrl
In-Reply-To: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
References: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121021210902.4dbd3e09@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sat, 20 Oct 2012 17:07:32 +0200, Andrew Lunn wrote:

> This patchset converts all kirkwood DT boards to pinctrl.
> It is an RFC for a number of reasons:

Thanks for doing this work!

> Do we want to enable the use of mvebu GPIO driver
> outside of mach-mvebu?

Yes.

> Do we want to enable the use of mvebu pinctrl driver
> outside of mach-mvebu?

Yes.

Generally speaking, I think it is a good idea for
mach-{mvebu,kirkwood,dove,mv78xx0,orion5x} to share as much
infrastructure code as possible. A first step is obviously to migrate
everybody to use the drivers/gpio mvebu driver and the drivers/pinctrl
mvebu driver, and get rid of plat-orion/{gpio,mpp}.c once this work is
done.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
