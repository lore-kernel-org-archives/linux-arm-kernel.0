From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Sep 2014 19:41:11 +0100
Subject: [PATCH v1] soc: qcom: do not disable the iface clock in probe
In-Reply-To: <A61C4CA5-7558-4B3D-BF05-BBDD1C3F550F@codeaurora.org>
References: <1408081268-5748-1-git-send-email-srinivas.kandagatla@linaro.org>
 <A61C4CA5-7558-4B3D-BF05-BBDD1C3F550F@codeaurora.org>
Message-ID: <5421BEC7.60003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/14 18:42, Kumar Gala wrote:
>
> On Aug 15, 2014, at 12:41 AM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> The use case here is when we have a bootconsole which is printing the
>> characters on serial console and gsbi driver comes up after some time.
>> As gsbi driver disables the clock in probe the bootconsole locks up.
>>
>> This patch fixes the problem by disabling the clock in platform remove
>> rather than in probe.
>>
>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> Changes since RFC:
>> 	- none, just a subject line change.
>
> Srini,
>
> We need some changes to the commit message for this to get into v3.17.
>
Sure.. I will send v2 with change log referring to 
http://www.spinics.net/lists/linux-arm-msm/msg10589.html


--srini
> Probably some references to:
>
> http://www.spinics.net/lists/linux-arm-msm/msg10589.html
>
> Adding Kevin to provide details on what else should be in commit message w/regards to the regression we introduced.
>
> - k
>
