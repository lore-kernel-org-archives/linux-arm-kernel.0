From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 17:27:32 +0000
Subject: [PATCH RFC] arm: Add argument to init_machine
In-Reply-To: <20101208172423.GA18569@huya.qualcomm.com>
References: <1291768976-7773-1-git-send-email-davidb@codeaurora.org>
	<20101208140722.GD9777@n2100.arm.linux.org.uk>
	<20101208172423.GA18569@huya.qualcomm.com>
Message-ID: <20101208172732.GQ9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 09:24:23AM -0800, David Brown wrote:
> On Wed, Dec 08, 2010 at 02:07:22PM +0000, Russell King - ARM Linux wrote:
> 
> > As far as the patch itself goes, it looks fine, but I'm not seeing
> > anything using this new facility in this patch.
> > 
> > I don't like adding things without seeing how they're going to be
> > used, as sometimes these things never get used.  Maybe you can give
> > some examples?
> 
> We've got some new board files that can make use of it.  I'll work on
> getting those to a point where I can send them out.  I mostly just
> wanted to make sure that the idea didn't cause excessive revulsion.

Well, that depends on how you're going to use this.

Generally, we find that it's best to arrange the common stuff as
libraries, and have the platform specific code call the library
functions to perform the common work.

Calling a common function from the platform methods and putting
lots of if (machine_is_xxx()) in it certainly isn't the right method.
