From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Oct 2016 10:32:05 +0100
Subject: [PATCH v2 2/9] dt-bindings: interrupt-controller: add DT binding
 for meson GPIO interrupt controller
In-Reply-To: <20161026214234.4q6wmecehqh6q32o@rob-hp-laptop>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-3-git-send-email-jbrunet@baylibre.com>
 <20161026214234.4q6wmecehqh6q32o@rob-hp-laptop>
Message-ID: <20161027093205.GA27135@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 04:42:35PM -0500, Rob Herring wrote:
> On Wed, Oct 19, 2016 at 05:21:13PM +0200, Jerome Brunet wrote:
> > 
> > This commit adds the device tree bindings description for Amlogic's GPIO
> > interrupt controller available on the meson8, meson8b and gxbb SoC families
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> > Rob, I did not include the Ack you gave for the RFC as bindings have slightly
> > changed. Only the interrupt property has be removed following a discussion I
> > had with Marc
> 
> As Mark R already said, you should keep the interrupts property.

To be clear, the interrupt routing should be described *somehow*, though
I don't think the generic interrupts property is correct, as this is an
interrupt *router*, i.e. this device doesn't own the interrupt, it just
joins two parts of the line together (and so flags are meaningless).

Thanks,
Mark.
