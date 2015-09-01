From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 31 Aug 2015 21:55:02 -0700
Subject: [PATCH 1/3] soc: qcom: smd: Represent channel layout in structures
In-Reply-To: <1441071594-15941-2-git-send-email-sboyd@codeaurora.org>
References: <1441071594-15941-1-git-send-email-sboyd@codeaurora.org>
 <1441071594-15941-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150901045502.GB13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 31 Aug 18:39 PDT 2015, Stephen Boyd wrote:

> The rx and tx channel info are laid out in memory next to each
> other, and there are two types of channel info structures, byte
> based and word based. We have 4 pointers to these info
> structures, when we really only need two to point to the
> different types of structures. Encapsulate the byte based and word
> based tx/rx structures in a "full channel" structure that
> describes the layout of memory and reduces the number of pointers
> in the smd channel structure by two.
> 

Saving the extra pointer doesn't feel like worth the change, but
representing the pair of info structs as one sounds like a reasonable
cleanup.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/soc/qcom/smd.c | 61 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
> index edd9d9a37238..c16547b85e05 100644
> --- a/drivers/soc/qcom/smd.c
> +++ b/drivers/soc/qcom/smd.c
> @@ -65,7 +65,9 @@
>   */
>  
>  struct smd_channel_info;
> +struct smd_full_channel_info;

I would have called this "smd_channel_info_pair"...

>  struct smd_channel_info_word;
> +struct smd_full_channel_info_word;
>  

Regards,
Bjorn
