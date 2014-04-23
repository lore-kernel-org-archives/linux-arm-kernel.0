From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Apr 2014 16:43:26 -0700
Subject: [PATCH 0/2] DT irq deferred probe support
In-Reply-To: <1398293861-7682-1-git-send-email-robherring2@gmail.com>
References: <1398293861-7682-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140423234326.GF6053@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [140423 15:58]:
> From: Rob Herring <robh@kernel.org>
> 
> This is atleast the 4th attempt to fix a long standing issue with DT 
> irq resolution needing to support deferred probe when irq parent is not 
> yet initialized. This version implements Russell King's suggestion to do 
> irq resolution when platform_get_irq is called. 
> 
> Tony, I squashed your warning fix (dropping the other part) and stole 
> much of your commit message. Let me know if you have any issues with 
> that.

Nope, looks good, just gave it a try and it fixes the problem for me.

Regards,

Tony
 
> Rob Herring (2):
>   of: selftest: add deferred probe interrupt test
>   of/irq: do irq resolution in platform_get_irq
> 
>  drivers/base/platform.c                        |  7 +++++-
>  drivers/of/irq.c                               | 26 +++++++++++++++++++++
>  drivers/of/platform.c                          |  4 +++-
>  drivers/of/selftest.c                          | 32 ++++++++++++++++++++++++++
>  drivers/of/testcase-data/tests-interrupts.dtsi | 12 ++++++++++
>  include/linux/of_irq.h                         |  7 +++++-
>  6 files changed, 85 insertions(+), 3 deletions(-)
> 
> -- 
> 1.9.1
> 
