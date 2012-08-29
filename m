From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 00:40:30 +0100
Subject: [PATCH 00/10] Make mach/gpio.h optional
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120829234030.GV18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 05:31:26PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series makes mach/gpio.h optional like we have done for other mach
> headers in preparation for multi-platform kernel images. Unfortunately,
> it adds more mach includes to drivers/, but really they are just now
> explicitly included and easily found.

This in general looks like a complete backwards step rather than a forwards
step for multi-platform kernels.  All these drivers are not going to be
usable in multi-platform kernel images, because with mach/ includes they're
not going to be picking up the correct set of headers.

So all these SoC types might as well not be part of the multi-platform
project until they get their act together with their headers.
