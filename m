From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 May 2014 16:47:48 +0100
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
In-Reply-To: <53838023.2080807@redhat.com>
References: <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
Message-ID: <20140527154748.GX12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 07:55:47PM +0200, Hans de Goede wrote:

> 				power-on-seq = "gpio_reg_enable", "usleep 1000", "clk_32khz", "usleep 200";

...

> Where power-on-seq would tell the mmc-core exactly how to bring up the sdio
> device, using standard prefixes so that the mmc-core knows that something is
> a clock / gpio / reset / whatever.

There was some work on such generic power on sequences in DT from 
Alexandre Courbot a while ago, search for "Runtime Interpreter Power
Sequences".  It ground to a halt IIRC mainly because it was never clear
that this should ever be encoded outside of the driver for a device but
the binding was pretty good and well reviewed, it's a good place to
start if there's a desire to do things like this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/b99e7b44/attachment.sig>
