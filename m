From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 10:32:05 +0200
Subject: [PATCH 3/7] crypto: marvell: Copy IV vectors by DMA transfers for
 acipher requests
In-Reply-To: <5762636A.2020800@free-electrons.com> (Romain Perier's message of
 "Thu, 16 Jun 2016 10:29:30 +0200")
References: <1466018134-10779-1-git-send-email-romain.perier@free-electrons.com>
 <1466018134-10779-4-git-send-email-romain.perier@free-electrons.com>
 <20160615220716.6ad3b856@bbrezillon>
 <5762636A.2020800@free-electrons.com>
Message-ID: <87oa71bkl6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On jeu., juin 16 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

>
>>> diff --git a/drivers/crypto/marvell/cesa.h b/drivers/crypto/marvell/cesa.h
>>> index 74071e4..74b84bd 100644
>>> --- a/drivers/crypto/marvell/cesa.h
>>> +++ b/drivers/crypto/marvell/cesa.h
>>> @@ -275,6 +275,7 @@ struct mv_cesa_op_ctx {
>>>   #define CESA_TDMA_DUMMY				0
>>>   #define CESA_TDMA_DATA				1
>>>   #define CESA_TDMA_OP				2
>>> +#define CESA_TDMA_IV				4
>>
>> Should be 3 and not 4: TDMA_TYPE is an enum, not a bit field.
>
> Ok
>
>>
>> Sometime it's better to offend the < 80 characters rule than doing
>> funky stuff ;).
>
> I just wanted to make checkpatch happy :D

In this case you can use a temporary variable.


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
