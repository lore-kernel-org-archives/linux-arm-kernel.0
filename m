From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 09:40:26 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.15 #1
In-Reply-To: <e984aa91-cf82-8823-1cd6-ed0d194bd5ba@st.com>
References: <8c7fe79d-ebd3-ee7c-f056-1d3aa225edee@st.com>
 <CAK8P3a3sfq13v8sVox8xiXvHpSyzsvV_4LEYsoNtdfLLhyS7MA@mail.gmail.com>
 <e984aa91-cf82-8823-1cd6-ed0d194bd5ba@st.com>
Message-ID: <CAK8P3a3RhiQcgn+4FDrvBtT1as8LhaR0SLnFMwc+j9PPu611ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 9:33 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 10/19/2017 10:57 PM, Arnd Bergmann wrote:
>> On Tue, Oct 17, 2017 at 12:16 PM, Alexandre Torgue
>>
>> Pulled into next/soc.
>>
>> Splitting out the first patch is fine, but there really is no need to have
>> one
>> patch per new Kconfig option you enable, it's less work and more readable
>> to
>> have a combined patch that explains what the options are and why you need
>> all of them.
>>
>>          Arnd
>>
>
> ok. So you mean I would have to merge "Add DMAMUX support", "Add I2C F7
> support", "Add MDMA support" in one patch before to submit the pull request
> ? If yes, it will be done for next PR.

Right, it's about finding the right balance. Most of the time, splitting up a
patch into smaller independent units makes sense when you explain
what each one does, but in cases like this (adding just one config option
or one DT node), it becomes more readable if you do multiple related
changes at once.

The best test is usually what you put in the changelog. If you have multiple
patches with almost-identical descriptions, merge them. If you have one
patch with a description that talks about unrelated problems, split it up.

       Arnd
