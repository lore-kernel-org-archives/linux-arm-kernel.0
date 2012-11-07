From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 7 Nov 2012 00:41:17 -0600
Subject: [PATCH v2 2/2] mailbox: split internal header from API header
In-Reply-To: <50990849.4050003@st.com>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
 <1352170552-29564-3-git-send-email-omar.luna@linaro.org>
 <50990849.4050003@st.com>
Message-ID: <CALLhW=486Vf22Pag-N59kDcYvCDoF_ZF0AjazH7s5bnBzqCfsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Loic,

On 6 November 2012 06:53, Loic PALLARDY <loic.pallardy@st.com> wrote:
>
>
> On 11/06/2012 03:55 AM, Omar Ramirez Luna wrote:
>> Now internal structures can remain hidden to the user and just API
>> related functions and defines are made available.
>>
>> Signed-off-by: Omar Ramirez Luna<omar.luna@linaro.org>
>> ---
>>   drivers/mailbox/mailbox.c |   34 ++++++++++++++++++++++++++++++++
>>   drivers/mailbox/mailbox.h |   48 +--------------------------------------------
>>   include/linux/mailbox.h   |   22 +++++++++++++++++++
> I agree with the file split but I think mailbox framework API should be
> more generic.
> omap_ prefix should not be used. mailbox_ prefix will be better.

Ok.

> Message type must be more opened like for example:
> struct mailbox_msg {
>         int             size;
>         unsigned char   header;
>         unsigned char   *pdata;
> };

We can analyze the requirement for having such structure, presumably
you expect variable size messages, in OMAP case it is a 4 byte value,
but I'm open to change in order to accommodate other users needs.

Cheers,

Omar
