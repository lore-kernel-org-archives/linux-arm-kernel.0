From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 01 Aug 2014 11:31:29 +0300
Subject: [PATCH v3 1/4] mfd: pm8xxx-spmi: add support for Qualcomm SPMI
 PMICs
In-Reply-To: <53DA02C0.2050606@mm-sol.com>
References: <1406205921-7452-1-git-send-email-svarbanov@mm-sol.com>
 <1406205921-7452-2-git-send-email-svarbanov@mm-sol.com>
 <53D8182A.5050204@codeaurora.org> <53DA02C0.2050606@mm-sol.com>
Message-ID: <53DB5061.8080403@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 11:48 AM, Stanimir Varbanov wrote:
> Hi David,
> 
> Thanks for the comments!
> 
> On 07/30/2014 12:54 AM, David Collins wrote:
>> On 07/24/2014 05:45 AM, Stanimir Varbanov wrote:
>>> From: Josh Cartwright <joshc@codeaurora.org>
>>>
>>> The Qualcomm SPMI PMIC chips are components used with the
>>> Snapdragon 800 series SoC family.  This driver exists
>>> largely as a glue mfd component, it exists to be an owner
>>> of an SPMI regmap for children devices described in
>>> device tree.
>>>
>>> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  drivers/mfd/Kconfig       |   16 +++++++++++
>>>  drivers/mfd/Makefile      |    1 +
>>>  drivers/mfd/pm8xxx-spmi.c |   65 +++++++++++++++++++++++++++++++++++++++++++++
>>
>> Would it be possible to rename this driver: qcom-spmi-pmic.c?  The driver
>> will be supporting several PMICs that do not fit the pm8xxx naming scheme.
>>  One of which is even specified in the compatible list of this driver
>> (pma8084).  There is presently downstream support for the following PMICs:
>> PM8019, PM8110, PM8226, PM8841, PM8916, PM8941, PM8994, PMA8084, PMD9635,
>> PMI8962, and PMI8994 [1].  Four of these do not fit the "PM8XXX" template.
> 
> I haven't strong opinion on the file names. The qcom prefix is the one
> which annoying me. If you look at /drivers/mfd the company name prefixes
> are very few.
> 
> The *compatible* strings are the important thing here. So If MFD
> maintainer is fine with this name I'm fine too.

Lee, are you OK with suggested names qcom-spmi-pmic and qcom-ssbi-pmic?

-- 
regards,
Stan
