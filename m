From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 23 Oct 2016 19:55:29 -0700
Subject: [PATCH V7 4/4] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <CAHp75Vd+u5va3kyqcapeF9JATUfv5gBnoEM_W+frDmMXs5f2Uw@mail.gmail.com>
References: <1477067879-23750-1-git-send-email-okaya@codeaurora.org>
 <1477067879-23750-5-git-send-email-okaya@codeaurora.org>
 <CAHp75Vd+u5va3kyqcapeF9JATUfv5gBnoEM_W+frDmMXs5f2Uw@mail.gmail.com>
Message-ID: <36163853-ac4a-e146-0c1b-eaf42e8b234d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 12:11 PM, Andy Shevchenko wrote:
>> +static void hidma_free_msis(struct hidma_dev *dmadev)
>> > +{
>> > +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> Perhaps one #ifdef and two definitions of functions?

I don't think it will make a difference. I'll have to move
#ifdef around the caller of hidma_free_msis instead which
I think is uglier.

The hidma_write_msi_msg function gets called only when 
CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined. If I don't put 
this around the function definition, I get unused function
warning from the compiler. This is the reason why preprocessor
definition is outside of the function definition.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
