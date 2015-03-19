From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Mar 2015 22:06:06 +0100
Subject: [PATCH v2] usb: ehci-orion: add more constants for register values
In-Reply-To: <Pine.LNX.4.44L0.1503191625140.1098-100000@iolanthe.rowland.org>
References: <20150319154540.786e6b4e@free-electrons.com>
 <Pine.LNX.4.44L0.1503191625140.1098-100000@iolanthe.rowland.org>
Message-ID: <20150319220606.72468301@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan,

On Thu, 19 Mar 2015 16:30:09 -0400 (EDT), Alan Stern wrote:
> On Thu, 19 Mar 2015, Thomas Petazzoni wrote:
> 
> > These are indeed all valid concerns. However, as you can see, those
> > concerns are completely orthogonal to the patch: the original code
> > already has those issues.
> 
> Quite true.  You may add
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks. So I presume this means Greg will take the patch?

> > Regarding the addition of a timeout, I unfortunately have absolutely no
> > idea what would be the a proper timeout value at this place. I quickly
> > glanced through
> > http://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/ehci-specification-for-usb.pdf
> > for the documentation of this reset bit, but couldn't spot a maximum
> > accepted duration for the operation.
> 
> ehci-hcd uses 250 ms.  This seems to be an arbitrary value, but at 
> least it's better than hanging the system.

Ok, then I'll cook a patch to adjust this aspect of the driver.

Thanks for the suggestion,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
