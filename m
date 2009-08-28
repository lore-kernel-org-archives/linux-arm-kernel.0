From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 28 Aug 2009 12:34:24 +0900
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <200908271357.n7RDv4U9028131@chronolytics.com>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<200908271357.n7RDv4U9028131@chronolytics.com>
Message-ID: <20090828033424.GH3928@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Aug 27, 2009 at 09:57:04AM -0400, David F. Carlson wrote:
 
> I have been working with the 6410 tree in several places.  A merge of samsung
> tree would be greatly appreciated.

Thanks.  Please note that this work is just starting, and it is a learning
curve for most people inside the samsung soc linux team as they have not
participated in the mainline development process so far.  So it will probably
a slow but steady start.

Though the decision has been made, and they will work on this from now on
throughout the coming months.

> Please remember that since I am working SmartQ and there are 3 other 6410
> based MACHs in Ben's next-s3c tree.  
> 
> So, please, MACH_SMDK6410 != CPU_6410 and
>             MACH_SMDK6410 != PLAT_64XX.

Yes, this is a common accident/mistake in the current code.  We'll try to sort
them out before submitting patches for review.  But even if they persist, I'm
sure you or others will be happy to point those out at that time.

> The common peripheral support needs to be factored out so that "thin" MACH
> configs can set some per-MACH GPIOs/chipsets (LCD, power,etc.)

That sounds definitely useful, but it's probably another topic on its own.
Right now the aim is to get the code cleaned up and submitted.  Samsung is
only working/testing with the SMDK's.  Once more and more machines will get
mainline, there can probably be more code sharing among them.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
