From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 1 May 2012 18:37:01 -0400
Subject: [PATCH] usb: [ARM] fix unresolved err() reference in
 host/ohci-pxa27x.c
In-Reply-To: <1335908214-4803-1-git-send-email-paul.gortmaker@windriver.com>
References: <1335908214-4803-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120501223701.GA29719@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 05:36:54PM -0400, Paul Gortmaker wrote:
> Commit af4e1ee04026908086d7ed252db2619a8ceaa333 (usb-next)
> 
>     "USB: remove err() macro"
> 
> was preceeded by a tree-wide cleanup of users, however this
> one squeaked through the cracks because it had whitespace
> between the function name and the bracket for the args.
> 
> Map it onto dev_err, just like all the "pre-commits" made
> in advance of af4e1ee04026, such as the example seen in
> the commit d57b177208b6ec20cacd7321ee32ef02f9f9e7fa:
> 
>     "USB: ohci-xls.c: remove err() usage"
> 
> Build tested with the ARM magician_defconfig settings.

Thanks so much for these three patches, sorry for messing up the build
and missing these three calls.

greg k-h
