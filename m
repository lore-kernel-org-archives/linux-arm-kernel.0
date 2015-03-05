From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 5 Mar 2015 09:52:14 +0800
Subject: [PATCH] ARM: at91: dts: sama5d3/sama5d4: reduce NFC command
 registers memory region
In-Reply-To: <54F72276.8060605@atmel.com>
References: <1421305683-8739-1-git-send-email-josh.wu@atmel.com>	<20150115094527.3fde882a@bbrezillon>	<54B78F73.9000504@atmel.com>
 <20150115110501.53b4584c@bbrezillon> <54F72276.8060605@atmel.com>
Message-ID: <54F7B6CE.8060403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Nicolas

On 3/4/2015 11:19 PM, Nicolas Ferre wrote:
> Le 15/01/2015 11:05, Boris Brezillon a ?crit :
>> Hi Josh,
>>
>> On Thu, 15 Jan 2015 17:59:15 +0800
>> Josh Wu <josh.wu@atmel.com> wrote:
>>
>>> Hi? Boris
>>>
>>> Thanks for the review.
>>>
>>> On 1/15/2015 4:45 PM, Boris Brezillon wrote:
>>>> Hi Josh,
>>>>
>>>> On Thu, 15 Jan 2015 15:08:03 +0800
>>>> Josh Wu <josh.wu@atmel.com> wrote:
>>>>
>>>>> To get NFC status, we need to read the NFC command registers, which is a
>>>>> 256M memory mapping address. To check the status, you just read such
>>>>> address from NFC command registers.
>>>>> For example, to check NFCBUSY (bit 27), you need to read 0x08000000
>>>>> (bit 27 is set to 1) of the NFC command register.
>>>>> If you want to check NFCBUSY (bit 27) and NFCWR (bit 26) in same time,
>>>>> you need to read 0x0c000000 (bit 27 and bit 26 are set to 1).
>>>> Are NFCBUSY and NFCWR found in NFCDATA_STATUS and those found in HSMC_SR
>>>> representing the same thing.
>>> yes. it is. I just check with IP team. The NFCBUSY of NFCDATA_STATUS is
>>> also refer to NFC_BUSY of HSMC_SR.
>>>
>>>> If they are, I think you can just use HSMC_SR instead of NFCDATA_STATUS
>>>> to check the status [1] and drop the last bit in the NFC Command
>>>> Resgiters range.
>>> Thank you. your code works (just need some typo change).
>>> I want to send [1] code with your signed-off and my acked to mtd list.
>>> Is it okay for you?
>> Sure, no problem.
> Hi Josh,
>
> What is the status of this patch set?

The v2 of this patch is sent. But it's not taken by Brain.
I just ping Brain yesterday. Check the v2 patch here:
http://patchwork.ozlabs.org/patch/431752/

Best Regards,
Josh Wu
>
> Bye,
