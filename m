From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 7 Jan 2015 11:30:49 +0100
Subject: [RESEND PATCH 1/2] pinctrl: st: avoid multiple mutex lock
In-Reply-To: <CACRpkdbOftsepHFBv32j-ty2+N3vDJPP27iMEWwZKO3ciRv0ug@mail.gmail.com>
References: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>	<1420452254-30625-2-git-send-email-patrice.chotard@st.com>
 <CACRpkdbOftsepHFBv32j-ty2+N3vDJPP27iMEWwZKO3ciRv0ug@mail.gmail.com>
Message-ID: <54AD0AD9.3010308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus
On 01/07/2015 10:44 AM, Linus Walleij wrote:
> On Mon, Jan 5, 2015 at 11:04 AM, Patrice CHOTARD <patrice.chotard@st.com> wrote:
>
>> From: Francesco VIRLINZI <francesco.virlinzi@st.com>
>>
>> Using the sysfs inteface to inspect the pins configuration
>> the system can walk around a path which acquires the same
>> mutex twice.
>>
>> On STiH407 platform, for example :
>> cat /sys/kernel/debug/pinctrl/920f080.pin-controller-front0/pinconf-pins
>> hangs the kernel and never returns.
>>
>> With this patch the mutex is temporary freed.
>>
>> Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Patch applied to fixes. Sorry for the delay.

Don't worry ;-)

Thanks

>
> Yours,
> Linus Walleij
