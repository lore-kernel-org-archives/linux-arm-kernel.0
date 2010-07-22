From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 23 Jul 2010 02:13:38 +0300
Subject: [PATCH v2 10/20] omap: zoom: add fixed regulator device for wlan
In-Reply-To: <4C48287D.1000603@nokia.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-11-git-send-email-ohad@wizery.com>
	<20100721175930.GD10930@sirena.org.uk>
	<4C48287D.1000603@nokia.com>
Message-ID: <AANLkTin2dyLNo1RMQgLG-4DtN-CsXqNNLAfITXDbMIvl@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 2:16 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> On 07/21/2010 08:59 PM, ext Mark Brown wrote:
>>
>> On Wed, Jul 21, 2010 at 08:33:44PM +0300, Ohad Ben-Cohen wrote:
>>
>>> +static struct regulator_consumer_supply zoom_vmmc3_supply = {
>>> + ? ? ? .supply ? ? ? ? = "vmmc",
>>> +};
>>
>> This looks like a misconfiguration on the consumer - I'd strongly expect
>> the consumer to have a dev_name specified also with the name being in
>> terms of the consumer device.
>
> you need to add something like
>
> .dev_name ? ? ? = "mmci-omap-hs.2"

I already set the .dev member of the consumer in a similar manner to
how all other regulators are configured in this board - please check
out patch 13:

https://patchwork.kernel.org/patch/113418/

Does this look reasonable to you ?

Thanks,
Ohad.

>
> regards,
> -roger
>
