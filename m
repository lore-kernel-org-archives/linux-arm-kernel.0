From: tthayer@opensource.altera.com (Thor Thayer)
Date: Thu, 4 Jun 2015 16:34:49 -0500
Subject: [PATCHv2 2/4] edac, altera: Refactor EDAC for Altera CycloneV SoC.
In-Reply-To: <55706E25.8050105@opensource.altera.com>
References: <1433428128-7292-1-git-send-email-tthayer@opensource.altera.com>
 <1433428128-7292-3-git-send-email-tthayer@opensource.altera.com>
 <55706E25.8050105@opensource.altera.com>
Message-ID: <5570C479.7010902@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/04/2015 10:26 AM, Dinh Nguyen wrote:
> On 06/04/2015 09:28 AM, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> The Arria10 SOC uses a completely different SDRAM controller from the
>> earlier CycloneV and ArriaV SoCs. This patch abstracts the SDRAM bits
>> for the CycloneV/ArriaV SoCs in preparation for the Arria10 support.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2: Make c5_data static.
>> ---
>>   drivers/edac/altera_edac.c |  194 ++++++++++++++++++++------------------------
>>   drivers/edac/altera_edac.h |  116 ++++++++++++++++++++++++++
>>   2 files changed, 206 insertions(+), 104 deletions(-)
>>   create mode 100644 drivers/edac/altera_edac.h
>>
>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>> index a9e7c69..a8350f6 100644
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
>
> What branch are you basing this patch on? I get the following error when
> applied to both v4.1-rc6, linux-next, and linux-edac/linux-next.
>
> Applying: edac, altera: Refactor EDAC for Altera CycloneV SoC.
> error: patch failed: drivers/edac/altera_edac.c:400
> error: drivers/edac/altera_edac.c: patch does not apply
> Patch failed at 0001 edac, altera: Refactor EDAC for Altera CycloneV SoC.
>
> Dinh
>

OK. I'll refactor and resend. I was using Altera's internal for-next branch.
