From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 18 Oct 2017 18:21:38 +0800
Subject: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
In-Reply-To: <59E72290.6060604@arm.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
 <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
 <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
 <20171018090649.e7qgdf2dwmr7yxc3@pd.tnic>
 <4b51bd4e-2bf7-3aed-f17c-565b49781009@huawei.com>
 <20171018092547.guf54e6aqbzzfxrq@pd.tnic> <59E72290.6060604@arm.com>
Message-ID: <cdbf7880-a515-6394-fc24-6a4498cace2c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/18 17:44, James Morse wrote:
>> The thing is abbreviated as "SEI" and apparently means "System Error
>> Interrupt". Nothing else.
> ARM has 'external abort', which are either synchronous or asynchronous, both are
> delivered as different types of exception.
> 
> Asynchronous external abort is treated as a special kind of interrupt, 'SError
> Interrupt', (where SError stands for System Error, but its rarely written like
> that). 'SEI' is a relatively new abbreviation for SError interrupt.
> 
> 
> What should we call this thing? In the ACPI code I'd prefer 'SEI' as that is
> what the ACPI spec calls it. Here we are talking about an GHES notification.
> 
> But in the arm64 arch code this should be called SError Interrupt as this is
> what the ARM-ARM calls it. This code cares about exception routing and interrupt
> masking.
> 
> 
> But, I don't really care.

Thanks very much James's clear explanation.
I agree with James.

In the ACPI sepc, we usually call SEI as SError Interrupt, we rarely call SError to System Error,
Anyway I will explain clearly about the abbreviations in my next version patch.
