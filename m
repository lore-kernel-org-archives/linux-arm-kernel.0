From: radoslaw.pietrzyk@gmail.com (=?UTF-8?Q?Rados=C5=82aw_Pietrzyk?=)
Date: Tue, 19 Dec 2017 09:37:08 +0100
Subject: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C
 controller
In-Reply-To: <dae4399e-4209-b052-a4c0-8a11c17ce032@st.com>
References: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <990c3275-35b3-68da-453c-d1a80e867df7@st.com>
 <CAFvLkMS6+o3D88Rj23of56KtjonwFAVD_aEP3eWaA2H=U5WP4Q@mail.gmail.com>
 <2d892fec-0496-8a6f-51c9-439b933d9975@st.com>
 <CAFvLkMS9Q801biCBYp+fJeiOo22zr436Td43PH3GG8E6diSL3A@mail.gmail.com>
 <b24d9699-a88d-6a83-ceaf-140ea8b4db97@st.com>
 <CAFvLkMTsgxpjoGRgq7J0NFkT=YsOTYL6smkVhOPcfD=26Hzutg@mail.gmail.com>
 <20171207105229.jxxyfofsgub27nip@ninjato>
 <dae4399e-4209-b052-a4c0-8a11c17ce032@st.com>
Message-ID: <CAFvLkMQ9UxDhNAcSm3Cy2KetrAf0+kbME=hkWgPUoXe28NaLFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My understanding is that this driver is currently vulnerable to any
IRQ delays that may happen in the system and this patch eliminates the
problem but you may prove me wrong.

2017-12-07 14:23 GMT+01:00 Pierre Yves MORDRET <pierre-yves.mordret@st.com>:
>
> I do believe some investigation has to be done prior merging this patch.
> The impact is genuine and has to be tested thoroughly before granting an ack.
>
> Thus I prefer having a better understanding of the issue.
> I will try to work on this later on.
>
> Regards
>
>
> On 12/07/2017 11:52 AM, Wolfram Sang wrote:
>> On Tue, Oct 24, 2017 at 01:45:43PM +0200, Rados?aw Pietrzyk wrote:
>>> I'm afraid that didn't help and the problem still exists even with
>>> those patches applied.
>>
>> So, my reading is: There is an issue which needs to be investigated?
>> Does applying the patch make sense until the issue is fully understood?
>>
