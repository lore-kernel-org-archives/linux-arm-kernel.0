From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Feb 2018 16:49:52 -0800
Subject: [PATCH -next] meson-gx-socinfo: make local function
 meson_gx_socinfo_init static
In-Reply-To: <3cb83737-bb60-7648-e72e-2d39590c8418@baylibre.com> (Neil
 Armstrong's message of "Tue, 6 Feb 2018 13:25:19 +0100")
References: <1515593988-78626-1-git-send-email-weiyongjun1@huawei.com>
 <3cb83737-bb60-7648-e72e-2d39590c8418@baylibre.com>
Message-ID: <7hh8qr9ebz.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 10/01/2018 15:19, Wei Yongjun wrote:
>> Fixes the following sparse warnings:
>> 
>> drivers/soc/amlogic/meson-gx-socinfo.c:100:12: warning:
>>  symbol 'meson_gx_socinfo_init' was not declared. Should it be static?
>> 
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
>> index f2d8c3c..ea091f1 100644
>> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
>> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
>> @@ -97,7 +97,7 @@ static const char *socinfo_to_soc_id(u32 socinfo)
>>  	return "Unknown";
>>  }
>>  
>> -int __init meson_gx_socinfo_init(void)
>> +static int __init meson_gx_socinfo_init(void)
>>  {
>>  	struct soc_device_attribute *soc_dev_attr;
>>  	struct soc_device *soc_dev;
>> 
>> 
>> 
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for v4.17, with Neil's ack.

Kevin
