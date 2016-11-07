From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 7 Nov 2016 11:03:31 +0100
Subject: [PATCH] staging: vc04_services: add vchiq_pagelist_info structure
In-Reply-To: <20161031081035.22677-1-mzoran@crowfest.net>
References: <20161031081035.22677-1-mzoran@crowfest.net>
Message-ID: <20161107100331.GA19666@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 01:10:35AM -0700, Michael Zoran wrote:
> The current dma_map_sg based implementation for bulk messages
> computes many offsets into a single allocation multiple times in
> both the create and free code paths.  This is inefficient,
> error prone and in fact still has a few lingering issues
> with arm64.
> 
> This change replaces a small portion of that inplementation with
> new code that uses a new struct vchiq_pagelist_info to store the
> needed information rather then complex offset calculations.
> 
> This improved implementation should be more efficient and easier
> to understand and maintain.
> 
> Tests Run(Both Pass):
> vchiq_test -p 1
> vchiq_test -f 10
> 
> Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> ---
>  .../interface/vchiq_arm/vchiq_2835_arm.c           | 223 +++++++++++----------
>  1 file changed, 113 insertions(+), 110 deletions(-)

This doesn't apply to the tree anymore because of your previous patch :(

Can you refresh it and resend?

thanks,

greg k-h
