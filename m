From: peter@korsgaard.com (Peter Korsgaard)
Date: Wed, 20 Jan 2016 08:40:11 +0100
Subject: [PATCH v5 1/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD
 driver
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63F61F4@penmbx01> (Wenyou
 Yang's message of "Wed, 20 Jan 2016 07:26:56 +0000")
References: <1452747845-2962-1-git-send-email-wenyou.yang@atmel.com>
 <1452747845-2962-2-git-send-email-wenyou.yang@atmel.com>
 <87pox41dy9.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63ECA51@penmbx01>
 <8737tzz33h.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63F61F4@penmbx01>
Message-ID: <87d1swvgv8.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Yang," == Yang, Wenyou <Wenyou.Yang@atmel.com> writes:

Hi,

>> But the charger driver can just as well do:
 >> 
 >> dev_get_regmap(dev->parent);
 >> 
 >> instead of:
 >> 
 >> dev_get_drvdata(pdev->dev.parent)->regmap.

 > For regulator, it works use the core do dev_get_regmap(dev->parent),
 > but for charger, it need to export *act8945a.

Why?

Just like the regulator core does, your battery driver can do:

dev_get_regmap(dev->parent);

-- 
Venlig hilsen,
Peter Korsgaard 
