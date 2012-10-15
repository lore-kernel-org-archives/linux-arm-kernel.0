From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Oct 2012 15:32:20 +0800
Subject: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
In-Reply-To: <20121015084920.75d4aa53@endymion.delvare>
References: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
 <50588A8F.30203@wwwdotorg.org> <50591C9C.2080809@atmel.com>
 <5059E484.6090708@wwwdotorg.org> <20120919175433.3841a954@endymion.delvare>
 <5074E349.30605@atmel.com> <507B7C07.3070702@atmel.com>
 <20121015084920.75d4aa53@endymion.delvare>
Message-ID: <507BBC04.9050609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean Delvare,

On 10/15/2012 14:49, Jean Delvare wrote:
> On Mon, 15 Oct 2012 10:59:19 +0800, Bo Shen wrote:
>> On 10/10/2012 10:54, Bo Shen wrote:
>>> On 9/19/2012 23:54, Jean Delvare wrote:
>>>> On Wed, 19 Sep 2012 09:28:04 -0600, Stephen Warren wrote:
>>>>> The problematic code appears to be:
>>>>>
>>>>> snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
>>>>>
>>>>> Instead, I think that should be something more like:
>>>>>
>>>>> adap->name = dev_name(&pdev->dev);
>>>>
>>>> strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name))
>>   >> if anything, as adap->name is a buffer, not a pointer.
>>>
>>> I am sorry for late. I have tested with DT, it works.
>>>
>>> Please send this patch to fix the issue.
>>> Thanks.
>>
>> Ping?
>>
>> Will you send this patch?
>
> Which patch, please? On September 18th, you sent a first version.
> Stephen Warren asked you for a change, but you never sent version two
> of the patch including the requested change. So don't be surprised if
> your patch never got applied.
>

I am sorry. I take a long vacation, so, I didnot send out version two.

>> Or, I send this patch and add your S.O.B, which do you prefer?
>
> I prefer that you send patch v2 and let the interested parties review
> and apply it. Do not add S-o-B for anyone else, ever.

OK. I will send out v2 as soon as possible.

>
> Note that i2c-gpio is normally handled by Wolfram Sang, not me.

Thanks for your information.

BRs,
Bo Shen
