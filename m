From: girish.shivananjappa@linaro.org (Girish K S)
Date: Fri, 16 Sep 2011 09:41:04 +0530
Subject: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
In-Reply-To: <0356427A-B949-4DA6-9F5D-FE0DD54AEDFF@marvell.com>
References: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
	<0356427A-B949-4DA6-9F5D-FE0DD54AEDFF@marvell.com>
Message-ID: <CAGxe1ZG4QjwB5OfrxupG_C+DtQ7sTQ4_EURaF-QrqPPSA3A0jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

but there is only one host controller to handle these commands.
the generic sdhci driver has cmd19 hard coded, thats the reason I
asked the question.
you can also check it in the function sdhci_execute_tuning it is hard coded as
cmd.opcode = MMC_SEND_TUNING_BLOCK; where the macro value is 19.
So in case of SD card insertion it will send a SEND_TUNING_BLOCK
command to the device. but if
MMC card is inserted then it will send a BUS_TEST_W command to the device.

correct me if i am wrong
regards
Girish


On 15 September 2011 21:53, Philip Rakity <prakity@marvell.com> wrote:
>
> Different committee's --- Different standards.
>
> There is no issue with overlap.
>
>
> On Sep 15, 2011, at 4:58 AM, Girish K S wrote:
>
>> Dear all,
>> ? ? ? ? ? ? The eMMC 4.5 specification mentions that the CMD21 in
>> class 2 is a SEND_TUNING BLOCK command. where as the SD card
>> specification
>> in the given link says CMD19 in class 2 is the SEND_TUNING_BLOCK
>> http://www.scribd.com/doc/50685191/53/Figure-4-8-Send-Tuning-Block-Command.
>> Also the implementation in the drivers/mmc/host/sdhci.c uses the CMD19
>> as the SEND_TUNING_BLOCK.
>> Can anybody clarify why there is overlapping in this command number.
>> May be my understand is wrong.
>>
>> In the MMC spec the CMD19 is BUS_TEST_W in class 0 and CMD21 is
>> reserved till eMMC 4.41 version.
>> But in the SD specification (given link) CMD19 is SEND_TUNING_BLOCK
>> and CMD21 is reserved.
>>
>> Thanks and regards
>> Girish K S
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
>
