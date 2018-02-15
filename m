From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 15 Feb 2018 11:57:14 -0300
Subject: [PATCH 2/2] perf inject: Emit instruction records on ETM trace
 discontinuity
In-Reply-To: <20180213222233.GA23553@xps15>
References: <1518011845-24063-1-git-send-email-robert.walker@arm.com>
 <1518011845-24063-3-git-send-email-robert.walker@arm.com>
 <20180213222233.GA23553@xps15>
Message-ID: <20180215145714.GE30974@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Feb 13, 2018 at 03:22:33PM -0700, Mathieu Poirier escreveu:
> On Wed, Feb 07, 2018 at 01:57:25PM +0000, Robert Walker wrote:
> > @@ -946,20 +982,19 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  		/* Run trace decoder until buffer consumed or end of trace */
> >  		do {
> >  			processed = 0;
> > -
> 
> this...
> 
> >  			err = cs_etm_decoder__process_data_block(
> >  				etmq->decoder,
> >  				etmq->offset,
> >  				&buffer.buf[buffer_used],
> >  				buffer.len - buffer_used,
> >  				&processed);
> > -
> 
> and this should have gone in the first patch.
> 
> >  			if (err)
> >  				return err;
> >  
> >  			etmq->offset += processed;
> >  			buffer_used += processed;
> >  
> > +			/* Process each packet in this chunk */
> 
> And probably this too.
> 
> With the above changes:
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Hi Robert,

	Can you please address Mathieu's comments, and if you agree with
them, resubmit?

Thanks!

- Arnaldo
