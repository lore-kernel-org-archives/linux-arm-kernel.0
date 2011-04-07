From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 7 Apr 2011 02:23:34 +0100
Subject: gpio.h interaction with other headers issue on pxa (maybe arm
	in general?)
In-Reply-To: <4D9C7475.6080900@cam.ac.uk>
References: <4D9C7475.6080900@cam.ac.uk>
Message-ID: <20110407012334.GB21071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 03:11:01PM +0100, Jonathan Cameron wrote:

Reflowed into 80 columns for legibility:

> Simply reorder the header includes to have kernel.h before gpio.h
> fixes this, but is it an indication of an underlying problem that
> should have a more general fix?

Seems like a standard missing include issue.  If the GPIO headers need
kernel.h they should include it directly rather than relying on the
other files pulling it in.
