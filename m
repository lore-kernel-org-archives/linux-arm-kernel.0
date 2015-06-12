From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Jun 2015 16:24:37 -0700
Subject: [PATCH v2 6/6] regulator: qcom-spmi: Add vendor specific
 configuration
In-Reply-To: <CAL_JsqL6R5jz1Xhgav0a0SeWqcRT200sofP-G_zQLfDVeqwarA@mail.gmail.com>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
 <1434069427-3642-7-git-send-email-sboyd@codeaurora.org>
 <CAL_JsqL6R5jz1Xhgav0a0SeWqcRT200sofP-G_zQLfDVeqwarA@mail.gmail.com>
Message-ID: <557B6A35.70009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2015 08:13 PM, Rob Herring wrote:
> On Thu, Jun 11, 2015 at 7:37 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Add support for over current protection (OCP), pin control
>> selection, soft start and soft start strength, auto-mode, input
>> current limiting, and pull down.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> Changes from v1:
>> * New patch split from original SPMI regulator driver
>>
>>  .../bindings/regulator/qcom,spmi-regulator.txt     |  62 +++++
>>  drivers/regulator/qcom_spmi-regulator.c            | 298 ++++++++++++++++++++-
>>  2 files changed, 358 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
>> index 75b4604bad07..ab01a152e930 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
>> @@ -99,6 +99,68 @@ see regulator.txt - with additional custom properties described below:
>>                     soft start are active all the time. 0 = Set initial mode to
>>                     low power mode (LPM).
>>
>> +- qcom,auto-mode-enable:
> Auto regulator modes are fairly common. Can't we have a common property here?

Should we use regulator-init-mode? We could make
spmi_regulator_of_map_mode() turn "2" into REGULATOR_MODE_FAST and then
use that to enable auto mode.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
