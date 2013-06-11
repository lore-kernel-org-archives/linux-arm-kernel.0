From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 11 Jun 2013 15:05:14 +0100
Subject: [PATCH v2 02/11] clocksource:global_timer: Add ARM global timer
 support.
In-Reply-To: <51B5D7A6.1020101@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856087-6452-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
 <51B5D7A6.1020101@st.com>
Message-ID: <51B72E9A.6070006@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/13 14:41, Srinivas Kandagatla wrote:
> On 10/06/13 14:13, Linus Walleij wrote:
>> On Mon, Jun 10, 2013 at 11:21 AM, Srinivas KANDAGATLA
>> Isn't it better to pass a struct device_node *np around and have that as
>> NULL in the non-DT boot path?
> I will try it and see how it will look.

I did try the change you suggested regarding passing struct device_node
*np around for both DT and non-DT boot paths.

Doing this is not adding any value to the driver, because
 1. Currently the driver only support DT boot paths, in my previous RFC
patches, Arnd suggested to get rid of the header as all platforms are DT
now.
 2. Passing device_node around is not adding any value w.r.t reducing
code or any thing.

So, I think I will stay with what is there originally, unless you have a
strong reason.

Thanks,
srini

> 
> Thanks,
> srini
>>
>> (Maybe somebody in the community asked you to do this, then I
>> will live with it.)
> 
>>
>> Yours,
>> Linus Walleij
>>
>>
> 
