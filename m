From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2018 21:58:55 +0000
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20181107215854.GD12248@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On Wed, Sep 26, 2018 at 02:56:17PM +0100, Julien Thierry wrote:
> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
> using it to access memory. When taking an exception, it is possible that
> the context during which the exception occured had SP mis-aligned. The
> entry code needs to make sure that the stack is aligned before using it to
> save the context.

Do you know what we haven't had reports of this crashing? Is it because GCC
tends to keep the SP aligned anyway, so we're getting away with it for the
moment? Trying to work out whether this is a candidate for -stable.

Cheers,

Will
