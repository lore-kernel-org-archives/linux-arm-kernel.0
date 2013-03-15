From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 15 Mar 2013 07:43:31 +0100
Subject: [PATCH 1/3] mfd: remove __exit_p annotation for
 twl4030_madc_remove
In-Reply-To: <1363298204-8014-1-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
Message-ID: <20130315064331.GC12559@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Mar 14, 2013 at 10:56:38PM +0100, Arnd Bergmann wrote:
> 4740f73fe5 "mfd: remove use of __devexit" removed the __devexit annotation
> on the twl4030_madc_remove function, but left an __exit_p() present on the
> pointer to this function. Using __exit_p was as wrong with the devexit in
> place as it is now, but now we get a gcc warning about an unused function.
> 
> In order for the twl4030_madc_remove to work correctly in built-in code, we
> have to remove the __exit_p.
> 
> Cc: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Please apply to MFD tree for 3.9
> 
>  drivers/mfd/twl4030-madc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied to mfd-fixes.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
