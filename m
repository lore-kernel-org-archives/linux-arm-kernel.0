From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 19 Mar 2015 16:30:09 -0400 (EDT)
Subject: [PATCH v2] usb: ehci-orion: add more constants for register values
In-Reply-To: <20150319154540.786e6b4e@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1503191625140.1098-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015, Thomas Petazzoni wrote:

> These are indeed all valid concerns. However, as you can see, those
> concerns are completely orthogonal to the patch: the original code
> already has those issues.

Quite true.  You may add

Acked-by: Alan Stern <stern@rowland.harvard.edu>

to the v2 patch.

> Regarding the addition of a timeout, I unfortunately have absolutely no
> idea what would be the a proper timeout value at this place. I quickly
> glanced through
> http://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/ehci-specification-for-usb.pdf
> for the documentation of this reset bit, but couldn't spot a maximum
> accepted duration for the operation.

ehci-hcd uses 250 ms.  This seems to be an arbitrary value, but at 
least it's better than hanging the system.

Alan Stern
