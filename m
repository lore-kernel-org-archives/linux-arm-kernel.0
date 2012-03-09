From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 9 Mar 2012 10:58:34 +0100
Subject: [PATCH v10] Regulator: Add Anatop regulator driver
In-Reply-To: <4F59B899.2080704@linaro.org>
References: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
 <20120308141847.GG27213@game.jcrosoft.org>
 <4F59B899.2080704@linaro.org>
Message-ID: <20120309095834.GM27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:00 Fri 09 Mar     , Ying-Chun Liu (PaulLiu) wrote:
> (2012?03?08? 22:18), Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> +static int __devexit anatop_regulator_remove(struct platform_device *pdev)
> >> +{
> >> +	struct regulator_dev *rdev = platform_get_drvdata(pdev);
> >> +	struct anatop_regulator *sreg = rdev_get_drvdata(rdev);
> >> +	kfree(sreg->name);
> >> +	regulator_unregister(rdev);
> > return from the unregister
> >> +	return 0;
> >> +}
> > Best Regards,
> > J.
> 
> Hi Jean-Christophe,
> 
> I've modify the patch based on your review. However, the last one cannot
> be made because regulator_unregister is void return.
so we have a issue here regulator_unregister MUST return an error conde

Best Regards,
J.
