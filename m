From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Aug 2013 11:56:09 -0400 (EDT)
Subject: [PATCH] USB: ohci-at91: add usb_clk for transition to common
 clk framework
In-Reply-To: <51FA7B6A.80106@overkiz.com>
Message-ID: <Pine.LNX.4.44L0.1308011153180.1534-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Aug 2013, boris brezillon wrote:

> > What happens if uclk isn't found but it is needed?
> It will not fail but I guess the usb host won't work as the clock won't 
> be correctly
> configured.
> 
> I agree with you: this is not a good solution.
> 
> Another option is to keep the previous version of this patch and put 
> uclk handling
> in "#ifdef CONFIG_COMMON_CLK #endif" sections.
> 
> Would this be acceptable ?

Yes.  However, a more elegant approach is to protect the relevant 
statements with: if (defined(CONFIG_COMMON_CLK)).  This preprocessor 
evaluates this to a 0 or 1, so the compiler will not generate output 
for the protected source code if the symbol isn't defined.

Alan Stern
