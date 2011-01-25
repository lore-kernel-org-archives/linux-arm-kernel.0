From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 16:20:16 -0800
Subject: [PATCH v2 01/11] msm: Add CPU queries
In-Reply-To: <1295914163.29639.77.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Mon, 24 Jan 2011 16:09:23 -0800")
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-2-git-send-email-davidb@codeaurora.org>
	<1295914163.29639.77.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <8yak4htj0lb.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24 2011, Daniel Walker wrote:

> On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
>> +#define cpu_is_msm7x01()       0
>> +#define cpu_is_msm7x30()       0
>> +#define cpu_is_qsd8x50()       0
>> +#define cpu_is_msm8x60()       0
>
> Now that I look at this again, why not drop the "x" all together ?

That might be better for the 8x60.  The complexity is that most of the
MSM chips have some variants, where the CPU running Linux isn't changed,
but the modem CPU is different (think CDMA/UMTS).  Until 8960, that was
distinguished by the second letter.

Either way doesn't quite match reality, unfortunately.  There are
devices using a MSM7201 and others using a MSM7601.  As far as Linux is
concerned, there isn't any difference between them.  If someone wanted
to try and identify the device they have with the code, it could be
confusing for either name chosen.

I was planning on turning msm8x60 into msm8660, since that seems to be
the most common one.  Perhaps the decoder ring should be put into the
help text for the options so people can at least figure out which is
which.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
