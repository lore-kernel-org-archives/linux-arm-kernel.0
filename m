From: Josh.wu@atmel.com (Wu, Josh)
Date: Wed, 7 Dec 2011 18:12:52 +0800
Subject: [PATCH 1/2] [media] V4L: atmel-isi: add code to
 enable/disableISI_MCK clock
In-Reply-To: <20111207084958.GA14542@n2100.arm.linux.org.uk>
References: <1322647604-30662-1-git-send-email-josh.wu@atmel.com>
 <20111207084958.GA14542@n2100.arm.linux.org.uk>
Message-ID: <4C79549CB6F772498162A641D92D5328039E9C15@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell King

On Wed, Dec 07, 2011 at 4:50 PM, Russell King wrote:

> On Wed, Nov 30, 2011 at 06:06:43PM +0800, Josh Wu wrote:
>> +	/* Get ISI_MCK, provided by programmable clock or external clock
*/
>> +	isi->mck = clk_get(dev, "isi_mck");
>> +	if (IS_ERR_OR_NULL(isi->mck)) {

> This should be IS_ERR()

So it means the clk_get() will never return NULL even when clk structure
is NULL in clk lookup entry. Right?

>> +		dev_err(dev, "Failed to get isi_mck\n");
>> +		ret = isi->mck ? PTR_ERR(isi->mck) : -EINVAL;

>		ret = PTR_ERR(isi->mck);

Best Regards,
Josh Wu
