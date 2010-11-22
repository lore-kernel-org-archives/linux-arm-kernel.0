From: per.fransson.ml@gmail.com (Per Fransson)
Date: Mon, 22 Nov 2010 23:14:21 +0100
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
	<AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
	<AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
Message-ID: <AANLkTikQX9YqR42u6ppzceHL58JqBsVxR3YJr6_BarbY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> That's for the situation when the other core tries to send an IPI at
>> the same time. Unlikely but both cores may deadlock.
>>
>
> Am I right that deadlock can occur only if the same IPI was sent? And
> there should
> be no situation when CRASH_DUMP IPI was sent from different processors at
> the same time.
>

I hope you are right, but I can't see why we couldn't get a crash IPI
from several
processors at the same time, unfortunately.

Even if such a thing can happen however, the timeout in my original suggestion
(ignoring the interrupt enabling) should keep us from deadlocking indefinitely.

/Per

>> I actually had a patch to allow this which was really complicated and
>> it still failed in a real-world scenario which I could foresee.
>>
>> --
>> Catalin
>>
>> _______________________________________________
>> kexec mailing list
>> kexec at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>
>
>
> --
> Best regards,
> Maxim Uvarov
>
