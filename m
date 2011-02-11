From: davidb@codeaurora.org (David Brown)
Date: Fri, 11 Feb 2011 15:16:39 -0800
Subject: [PATCH 2/3] msm: iommu: Generalize platform data for multiple
	targets
In-Reply-To: <1297464456.4852.34.camel@m0nster> (Daniel Walker's message of
	"Fri, 11 Feb 2011 14:47:36 -0800")
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
	<1297456098-3241-2-git-send-email-stepanm@codeaurora.org>
	<1297462350.4852.31.camel@m0nster> <8ya7hd6kxk1.fsf@huya.qualcomm.com>
	<1297464456.4852.34.camel@m0nster>
Message-ID: <8ya1v3ekvqg.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11 2011, Daniel Walker wrote:

> On Fri, 2011-02-11 at 14:37 -0800, David Brown wrote:

>> It is functionality that will be shared across multiple socs.  Putting
>> the name of a specific soc would just be misleading.  Currently, it's
>> our only iommu.  Support for another family that uses a different iommu
>> could perhaps call it iommu2.
>
> Your missing my point. I'm saying it doesn't look flexible enough to
> allow support for multiple SoCs .. Is everything going to be identical
> across all the supported socs ?

It wouldn't help, though.  If the addresses differ across targets, we
don't want defines that are conditionally defined, so we would need
multiple tables, giving the address for specific targets.  Still no
reason to have an indirection on the names.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
