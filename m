From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 28 Jan 2016 22:38:55 -0600
Subject: [PATCH 3/4] dmaengine: qcom_bam_dma: use correct pipe FIFO size
In-Reply-To: <56697BA9.5050805@linaro.org>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <1448961299-15161-4-git-send-email-stanimir.varbanov@linaro.org>
 <20151201172307.GA26687@Agamemnon.attlocal.net>
 <565F1FDB.4020106@linaro.org>
 <20151202172255.GA9599@Agamemnon.attlocal.net>
 <56697BA9.5050805@linaro.org>
Message-ID: <20160129043855.GA4608@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 03:18:33PM +0200, Stanimir Varbanov wrote:

<snip>

> >>> This is just using the #define.  That is ok, but if you use this instead of the
> >>> BAM_P_FIFO_SIZES then you need to fix your comment.  Or actually use the
> >>> register value.... otherwise looks fine.
> >>
> >> I did not follow your comment, but the intension of the patch is to set
> >> the proper FIFO size in BAM_P_FIFO_SIZES register, i.e. 32K - 8.
> > 
> > Sorry, I mixed up the usage and was thinking there was something you read out
> > that told you the size.  That's not how it works, unfortunately.  The
> > MAX_DATA_SIZE is fine, but the name is a little misleading.  Perhaps just
> > BAM_FIFO_SIZE?
> 
> OK I can rename BAM_MAX_DATA_SIZE to BAM_FIFO_SIZE, and use it when
> setting BAM_P_FIFO_SIZES register. Is that fine to you?

Yes that's fine with me.
