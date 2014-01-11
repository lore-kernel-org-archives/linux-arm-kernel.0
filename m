From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 11 Jan 2014 20:52:17 +0100
Subject: [PATCH RFC 00/10] Generic Device Tree based power domain look-up
In-Reply-To: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1743034.81eWccWixG@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 of January 2014 20:42:42 Tomasz Figa wrote:
> Up till now there was no single generic method to bind devices to their
> power domains using Device Tree. Each platform has been doing this using
> its own way, example of which are Exynos power domain bindings [1] and
> look-up code [2].
> 
> This series is intended to change this and provide generic DT bindings for
> power domain specification and generic code performing look-up of power
> domains and binding them to devices.
> 
> Patches 1, 2, 3 are not directly related to this series, but they are
> dependencies of further patches making mach-s3c64xx a user of introduced
> code. Patch 4 is the most important part of this series, as it's the one
> introducing $subject. Further patches are fixing and adding two users,
> mach-exynos (removing the legacy code) and mach-s3c64xx (no DT support for
> power domains before). Last two patches are adding display support for
> Mini6410 board, including a node for display controller (FIMD) which is
> a power domain consumer.
> 
> Successfully tested on S3C6410-based Mini6410 board.
> 

I left the references for the end of this cover letter and finally forgot
about them. Please accept my apologies ;).

[1] Documentation/devicetree/bindings/arm/exynos/power_domain.txt
[2] arch/arm/mach-exynos/pm_domains.c

Also it might be good to mention that I was heavily inspired by
implementation of clock providers in Common Clock Framework in case of
provider registration and look-up and also by my Exynos power domain
implementation (now removed by this series ;)) in case of code binding
devices to power domains.

Best regards,
Tomasz
