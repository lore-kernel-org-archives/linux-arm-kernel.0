From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 3 Dec 2013 13:01:39 -0500
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <529E109A.7050700@citrix.com>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
 <529E109A.7050700@citrix.com>
Message-ID: <20131203180139.GG3734@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 05:10:50PM +0000, David Vrabel wrote:
> On 03/12/13 15:40, Julien Grall wrote:
> > On ARM (32 bits and 64 bits), the double-word is 8-bytes aligned. This will
> > result on different structure from Xen and Linux repositories.
> > 
> > As Linux is using __packed__ attribute, it must have a 4-bytes padding before
> > each "id" field.
> > 
> > This change breaks guest block support with older kernel. IMHO, it's acceptable
> > because Xen on ARM is still on Tech Preview and the hypercall ABI is not yet
> > freezed.
> > 
> > Only one architecture (x86_32) doesn't have 64-bit ABI for the block interface.
> > Don't add padding if Linux is compiled for this architecture.
> 
> I'm now satisfied that this is the right thing to do.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>

Before we go any further, I need testing confirmation that with this patch
can still run on x86 hardware the following combinations:

 32-bit guest on 64-bit dom0
 64-bit guest on 32-bit dom0

and with an 3.12 dom0

B/c I am not seeing that mentioned anywhere and I think that is creating
confusion with folks thinking it would break the x86-world (which it shouldn't).

> 
> David
