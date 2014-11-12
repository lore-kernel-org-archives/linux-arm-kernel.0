From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 12 Nov 2014 07:45:08 -0700
Subject: [RFC 1/2] mfd: qcom-rpm: Expose sleep state resources to clients
In-Reply-To: <20141112095200.GD24004@x1>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20141111120457.GZ24004@x1> <20141111183319.GD16980@sonymobile.com>
 <20141112095200.GD24004@x1>
Message-ID: <20141112144508.GD45276@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12 2014 at 02:52 -0700, Lee Jones wrote:
>On Tue, 11 Nov 2014, Bjorn Andersson wrote:
>
>> On Tue 11 Nov 04:04 PST 2014, Lee Jones wrote:
>>
>> > On Mon, 10 Nov 2014, Bjorn Andersson wrote:
>> >

> > > +	writel_relaxed(BIT(state), RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
>> >
>> > How are the state bits organised?
>> >
>>
>> BIT(0) is active mode, BIT(1) is sleep mode, as specified below. I could add
>> some sanity checking here if you would like to.
>
>I'm just double checking that you know what that means.
>
>BIT(0) == b01
>BIT(1) == b10
>
>It seems strange to represent a single boolean state over 2 bits.
>
>Also, what happens if b11 or b00 occurs?
>
Lee is correct, it should be 0 for Active and 1 for Sleep set. 


Lina
