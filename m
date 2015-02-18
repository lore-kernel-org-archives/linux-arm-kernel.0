From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 18 Feb 2015 11:27:46 +0000
Subject: [PATCH 1/2] arm/xen: Correctly check if the event channel
 interrupt is present
In-Reply-To: <1423722898-16110-2-git-send-email-julien.grall@linaro.org>
References: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
 <1423722898-16110-2-git-send-email-julien.grall@linaro.org>
Message-ID: <1424258866.27775.15.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-02-12 at 06:34 +0000, Julien Grall wrote:
> The function irq_of_parse_and_map returns 0 when the IRQ is not found.
> 
> Furthermore xen_events_irq is only read when the CPU is bring up, so
> it's not necessary to use the attribute __read_mostly.

Part of the purpose of __read_mostly is to move such things out of
sharing cachelines with other more hot read/write things, as much as it
is to group all the "read only" things together.
