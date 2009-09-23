From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Sep 2009 12:53:27 +0800
Subject: [PATCH/RFC] Runtime PM: ARM: subarch-specific extensions of
	pdev_archdata
In-Reply-To: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> On ARM platforms, power management can be very platform specific.
> This patch allows ARM subarches to extend the platform_device
> pdev_archdata for each subarch by creating a new struct pdev_machdata
> and allowing each subarch to customize it as needed.
>
> As a starting point, each subarch's <mach/device.h> creates an empty
> struct pdev_machdata.
>

Shouldn't that pdev_archdata and pdev_machdata be pointer or something
so that multiple platform_device can share something in common?
