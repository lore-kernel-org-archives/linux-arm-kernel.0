From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 2 Oct 2013 11:35:55 +0200
Subject: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <20131002090257.GA3059@katana>
References: <1380623952-4252-1-git-send-email-maxime.coquelin@st.com>
 <1380623952-4252-2-git-send-email-maxime.coquelin@st.com>
 <524B346C.8070607@wwwdotorg.org> <524BDB00.3010508@st.com>
 <20131002090257.GA3059@katana>
Message-ID: <524BE8FB.40000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/02/2013 11:02 AM, Wolfram Sang wrote:
>>>> +Optional properties :
>>>> +- i2c-min-scl-pulse-width-us : The minimum valid SCL pulse width that is allowed
>>>> +  through the deglitch circuit. In units of us.
>>>> +- i2c-min-sda-pulse-width-us : The minimum valid SDA pulse width that is allowed
>>>> +  through the deglitch circuit. In units of us.
>>> Are those properties specific to this binding, or intended to be
>>> generic? If specific to this binding, a vendor prefix should be present
>>> in the property name. If not, you probably want to document the
>>> properties in some common file.
>> Ok.
>> In last revision, I put this properties as specific to this binding.
>> Wolfram proposed to make this generic, but it looks like this IP is the
>> only one
>> needing such properties.
>>
>> Wolfram, what would you advise?
> It might be the only SoC now, but I could imagine that other will have
> something similar in the future. I am not perfectly sure, though. So, I
> asked for opinions from DT experts when I suggested those bindings. We
> could start with vendor specific bindings and generalize them later if
> similar ones appear. Yet my experience is that old drivers rarely get
> converted to the new bindings.
Ok.
But if I start with vendor specific bindings, we will have to support it
forever, right?
>
>> If you still prefer to make this properties generics, in which file should I
>> document it? I don't see any common i2c binding document for now.
> Yeah, it is missing sadly. That's on my todo-list, like many other
> things...
OK :-)

Thanks,

Maxime
