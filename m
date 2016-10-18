From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 18 Oct 2016 13:08:52 -0700
Subject: [PATCH 1/2] mmc: sdhci-iproc: Add brcm, sdhci-iproc compat string
 in bindings document
In-Reply-To: <20161018131614.lskxbdir3ghun5md@rob-hp-laptop>
References: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
 <1476297352-7812-2-git-send-email-scott.branden@broadcom.com>
 <20161018131614.lskxbdir3ghun5md@rob-hp-laptop>
Message-ID: <93502f42-ae86-742f-a8b1-3645005fa98e@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 16-10-18 06:16 AM, Rob Herring wrote:
> On Wed, Oct 12, 2016 at 11:35:51AM -0700, Scott Branden wrote:
>> Adds brcm,sdhci-iproc compat string to DT bindings document for
>> the iProc SDHCI driver.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>> index be56d2b..aa58b94 100644
>> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>> @@ -7,6 +7,7 @@ Required properties:
>>  - compatible : Should be one of the following
>>  	       "brcm,bcm2835-sdhci"
>>  	       "brcm,sdhci-iproc-cygnus"
>> +	       "brcm,sdhci-iproc"
>
> Seems kind of generic. SoC specific compatible strings please.
>
The compatibility string is generic on purpose as it is not intended to 
be SoC specific but work on all new iproc SoCs that have the proper 
fixes in place for this block (unlike bcm2835 and cygnus class devices 
which can only do 32-bit accesses).  I could call it brcm,sdhci-iproc-v2 
if that is better or leave it as is.  Please let me know your preferences.

Regards,
Scott
