From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 15 Sep 2014 16:07:46 +0200
Subject: [PATCH RESEND v9 5/5] rtc: Add driver for Maxim 77802 PMIC
 Real-Time-Clock
In-Reply-To: <20140912151334.cd53fca611a7de487f23241b@linux-foundation.org>
References: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>	<1410509864-10019-6-git-send-email-javier.martinez@collabora.co.uk>
 <20140912151334.cd53fca611a7de487f23241b@linux-foundation.org>
Message-ID: <5416F2B2.1060300@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On 09/13/2014 12:13 AM, Andrew Morton wrote:
> On Fri, 12 Sep 2014 10:17:43 +0200 Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> 
>> The MAX7802 PMIC has a Real-Time-Clock (RTC) with two alarms.
>> This patch adds support for the RTC and is based on a driver
>> added by Simon Glass to the Chrome OS kernel 3.8 tree.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Would it be appropriate to gather Simon's signoff?
> 

I don't know. The original driver written by Simon supported 2 devices:
max77686 and max77802. I split the max77802 bits and addressed all the issues
pointed out on early revisions so even when Simon is mentioned as the
MODULE_AUTHOR(), I didn't know if he would like his s-o-b to remain in the
patch since it was quite different than the original one from which was based.

>> +static inline int max77802_rtc_calculate_wday(u8 shifted)
>> +{
>> +	int counter = -1;
>> +
>> +	while (shifted) {
>> +		shifted >>= 1;
>> +		counter++;
>> +	}
> 
> Can't use log2() or similar?
> 

Yes, ffs() - 1 can be used instead of this function indeed.

I see that you already included this patch to your -mm tree [0]. Does it mean
that I've to send a follow-up patch on top of this to remove this function or
should I send a new version of this patch?

Best regards,
Javier

[0]:
http://ozlabs.org/~akpm/mmots/broken-out/rtc-add-driver-for-maxim-77802-pmic-real-time-clock.patch
