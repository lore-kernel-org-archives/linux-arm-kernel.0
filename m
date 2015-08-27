From: agross@codeaurora.org (Andy Gross)
Date: Thu, 27 Aug 2015 11:32:00 -0500
Subject: [PATCH v2] soc: qcom: smd: Use correct remote processor ID
In-Reply-To: <55DF2C35.4030207@mm-sol.com>
References: <1440618165-9410-1-git-send-email-agross@codeaurora.org>
 <55DF2C35.4030207@mm-sol.com>
Message-ID: <20150827163200.GB13642@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 06:26:45PM +0300, Stanimir Varbanov wrote:
> On 08/26/2015 10:42 PM, Andy Gross wrote:
> > This patch fixes SMEM addressing issues when remote processors need to use
> > secure SMEM partitions.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  .../devicetree/bindings/soc/qcom/qcom,smd.txt      |    6 ++++++
> >  drivers/soc/qcom/smd.c                             |   15 +++++++++++----
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> > index f65c76d..97d9b3e 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> > @@ -37,6 +37,12 @@ The edge is described by the following properties:
> >  	Definition: the identifier of the remote processor in the smd channel
> >  		    allocation table
> >  
> > +- qcom,remote-pid:
> > +	Usage: optional
> > +	Value type: <u32>
> > +	Definition: the identifier for the remote processor as known by the rest
> > +		    of the system.
> > +
> >  = SMD DEVICES
> >  
> >  In turn, subnodes of the "edges" represent devices tied to SMD channels on that
> > diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
> > index 327adcf..5706a81 100644
> > --- a/drivers/soc/qcom/smd.c
> > +++ b/drivers/soc/qcom/smd.c
> > @@ -111,6 +111,7 @@ struct qcom_smd_edge {
> >  	struct qcom_smd *smd;
> >  	struct device_node *of_node;
> >  	unsigned edge_id;
> > +	unsigned remote_pid;
> 
> Andy, you forgot to add this new field in structure description header.

Good catch.  Thanks!

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
