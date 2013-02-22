From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Feb 2013 10:35:28 +0800
Subject: [PATCH] kbuild: create an "include chroot" for DT bindings
In-Reply-To: <51266AC1.8040507@wwwdotorg.org>
References: <1361394356-19385-1-git-send-email-swarren@wwwdotorg.org>
 <20130221043751.GB17738@S2101-09.ap.freescale.net>
 <51266AC1.8040507@wwwdotorg.org>
Message-ID: <20130222023526.GA27371@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 11:43:13AM -0700, Stephen Warren wrote:
> There are two things that include DT-related headers:
> 
> a) Device trees (*.dts, *.dtsi)
> b) The kernel
> 
> All the headers relevant here fall into category (a) by definition. I'd
> actually expect most to also fall into category (b), although I can see
> that category (b) might be a strict subset of category (a).
> 
> I believe you're proposing only storing category (b) headers in
> include/dt-bindings/, and storing any others I suppose in arch/*/boot/dts/.
> 
> But, my thoughts are that /all/ these headers (both categories) should
> be stored in one place for consistency.
> 
> That way, if/when the DT binding docs, these headers, and the DT files
> themselves move out of the kernel, we'll end up with some other
> repository/repositories that might have the following top-level
> directories (or at least these sets of logical data):
> 
> 1) DT binding documents
> 2) Headers that define constants for (1)
> 3) DT files (*.dts/*.dtsi)
> 
> We need at least some of (2) in the kernel for drivers to share the
> constant definitions, so my proposal is to simply copy /all/ the headers
> from (2) into the kernel's include/dt-bindings/. That keeps things
> simple; simply copy everything and maintain the same hierarchy under
> that "root" directory. Otherwise, we'll be constantly wondering which
> headers to copy, perhaps moving things back/forth as people realize that
> the kernel needs them, etc.

You need to anyway identify the headers needed by a) but not b) and
remove them from linux/include/dt-bindings/, when all DTS gets moved
out of kernel tree.  Otherwise, you end up leaving those headers only
needed by DTS in the kernel tree.

Shawn
