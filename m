From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Fri, 09 Mar 2012 16:00:25 +0800
Subject: [PATCH v10] Regulator: Add Anatop regulator driver
In-Reply-To: <20120308141847.GG27213@game.jcrosoft.org>
References: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
 <20120308141847.GG27213@game.jcrosoft.org>
Message-ID: <4F59B899.2080704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?03?08? 22:18), Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +static int __devexit anatop_regulator_remove(struct platform_device *pdev)
>> +{
>> +	struct regulator_dev *rdev = platform_get_drvdata(pdev);
>> +	struct anatop_regulator *sreg = rdev_get_drvdata(rdev);
>> +	kfree(sreg->name);
>> +	regulator_unregister(rdev);
> return from the unregister
>> +	return 0;
>> +}
> Best Regards,
> J.

Hi Jean-Christophe,

I've modify the patch based on your review. However, the last one cannot
be made because regulator_unregister is void return.

Yours Sincerely,
Paul
