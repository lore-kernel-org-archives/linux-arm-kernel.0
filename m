From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Nov 2012 13:23:42 +0000
Subject: [PATCH 207/493] i2c: remove use of __devinit
In-Reply-To: <20121120092046.24496415@endymion.delvare>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
 <20121120092046.24496415@endymion.delvare>
Message-ID: <20121120132342.GP3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:20:46AM +0100, Jean Delvare wrote:
> Hi Bill,
> 
> On Mon, 19 Nov 2012 13:22:36 -0500, Bill Pemberton wrote:
> > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > needed.
> 
> Can you please point me/us to the discussion explaining the rationale
> behind this move, and the explanation of what will be done exactly?
> While I can easily understand that we want to drop CONFIG_HOTPLUG and
> always enable hot-plug support, I don't see where we are going with
> removing __devinit annotations and the like.

It's actually very simple to understand.

1. CONFIG_HOTPLUG is going away; it's already defined to always be 'Y'.
2. This means that the the devinit sections will not be discarded anymore.
3. As a result, there's no point the devinit sections existing anymore.
4. As there's no devinit sections, the __devinit marker is entirely
   redundant and useless.

The reason this is being done is because the benefit to cost ratio of this
is far too high; it's well proven that people constantly get these markings
wrong, and with most kernels having had hotplug enabled anyway, it's not
providing much in the way of space saving benefit over the number of section
conflicts it causes.  So, it's been decided a few years ago that this is
going to happen, with that justification, and it's been accepted by 300
odd kernel developers in at least one kernel summit when it was talked
about... and it's been mentioned on mailing lists several times.
