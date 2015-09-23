From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 13:15:15 -0500
Subject: [Patch v2 02/10] soc: qcom: smd-rpm: Add existing platform support
In-Reply-To: <20150923171840.GD24668@usrtlx11787.corpusers.net>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
 <1443027209-19444-3-git-send-email-agross@codeaurora.org>
 <20150923171840.GD24668@usrtlx11787.corpusers.net>
Message-ID: <20150923181515.GB24756@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 10:18:40AM -0700, Bjorn Andersson wrote:
> On Wed 23 Sep 09:53 PDT 2015, Andy Gross wrote:
> 
> > This patch adds support for all current Qualcomm platforms which utilize
> > RPM over SMD.  This includes both MSM8916 and APQ8084.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |    2 ++
> >  drivers/soc/qcom/smd-rpm.c                         |    2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> > index 3710dd5..7d05246 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> > @@ -20,6 +20,8 @@ resources.
> >  	Value type: <string>
> >  	Definition: must be one of:
> >  		    "qcom,rpm-msm8974"
> > +		    "qcom,rpm-msm8916"
> > +		    "qcom,rpm-apq8084"
> >  
> >  - qcom,smd-channels:
> >  	Usage: required
> > diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> > index 1392ccf..455083c 100644
> > --- a/drivers/soc/qcom/smd-rpm.c
> > +++ b/drivers/soc/qcom/smd-rpm.c
> > @@ -212,6 +212,8 @@ static void qcom_smd_rpm_remove(struct qcom_smd_device *sdev)
> >  
> >  static const struct of_device_id qcom_smd_rpm_of_match[] = {
> >  	{ .compatible = "qcom,rpm-msm8974" },
> > +	{ .compatible = "qcom,rpm-msm8916" },
> > +	{ .compatible = "qcom,rpm-apq8084" },
> >  	{}
> 
> This is now how the alphabet works, please update the order and add:
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> Regards,
> Bjorn

I'll fixup before applying.  Thanks!


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
