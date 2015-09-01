From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 31 Aug 2015 21:50:55 -0700
Subject: [PATCH] soc: qcom: Make qcom_smem_get() return a pointer
In-Reply-To: <1441071666-16156-1-git-send-email-sboyd@codeaurora.org>
References: <1441071666-16156-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150901045055.GA13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 31 Aug 18:41 PDT 2015, Stephen Boyd wrote:

> Passing a void ** almost always requires a cast at the call site.
> Instead of littering the code with casts every time this function
> is called, have qcom_smem_get() return a void pointer to the
> location of the smem item. This frees the caller from having to
> cast the pointer with the small downside of doing some extra work
> to find the item in the case that the caller doesn't care to use
> the pointer.
> 

We still need to find the item even if the caller is not interested, to
know if we should have returned -ENOENT, so I think it's just a matter
of style.

I did have the API to return the pointer earlier in development, but it
didn't look good and uniform. But in the final piece, that was picked
up, I think it makes more sense (and looks better) to do it this way.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> This is on top of the smd and smem big endian support.
> 

How sneaky of you, then we need to approve those patches before we
add new consumers of this API...

Regards,
Bjorn
