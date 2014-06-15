From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 15 Jun 2014 21:50:45 +0800
Subject: [PATCH v2 1/2] ARM: imx6qdl: switch to use macro for clock ID
In-Reply-To: <20140615131237.GU23430@n2100.arm.linux.org.uk>
References: <1402837204-30474-1-git-send-email-shawn.guo@freescale.com>
 <20140615131237.GU23430@n2100.arm.linux.org.uk>
Message-ID: <20140615135044.GB8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 15, 2014 at 02:12:37PM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 15, 2014 at 09:00:03PM +0800, Shawn Guo wrote:
> > Instead of using enum for clock ID, let's switch imx6qdl clock driver to
> > use macro.  In this case, device tree can reuse these macros to improve
> > readability.
> 
> Long overdue.  I recently needed to find out the clocks for the LDB, and
> this is the process I followed:
> 
> 1. Look up the clock names in the imx6qdl.dtsi file.
> 2. Convert them to clock index.
> 3. Look in Documentation/devicetree/bindings/imx6q-clock.txt to translate
>    the clock index to another name.
> 4. Look in arch/arm/mach-imx/clk-imx6q.c to find out what register(s) they
>    access.
> 5. Look the registers up in the IMX6 reference manuals to convert the
>    register bits which are being manipulated to names that the manuals
>    use.
> 6. Refer to the CCM clock tree diagram to find out where in the heirarchy
>    the clock actually sits.

Yes, I definitely understand the pain, and that's why I create the patch
to make it less painful.

> 
> This is incredibly time consuming and error-prone, and really, I wish that
> the names used in clk-imx6q.c were as close as possible to those used in
> the reference manual to cut down on the number of indirections required to
> understand this stuff.

When we create the imx6q clock driver, we did name the clocks by looking
at Reference Manual.  But that's an early version document, and the
clock name in the document changes over time.  I admit there are quite
some clock names mismatch between code and document, but for most of
them it shouldn't be so hard to map them.

Shawn
