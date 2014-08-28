From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Thu, 28 Aug 2014 10:58:29 +0300
Subject: use IORESOURCE_REG resource type for non-translatable addresses
 in DT
In-Reply-To: <CAJAp7OhoRQ1eWack1e=OL0cS4Fxmgxc7OWeNxcj1qt7Q-x-sQA@mail.gmail.com>
References: <53D788A7.4020303@mm-sol.com> <3794875.CZFbAag5Sv@wuerfel>
 <53D7AA72.6010309@mm-sol.com>
 <20140729234522.E9FF1C40738@trevor.secretlab.ca>
 <53D84558.7060406@codeaurora.org>
 <CAL_JsqJjH0OH+X=fzwqAPeWarjoLev7v6Nv_QhAa+nZyztMnFA@mail.gmail.com>
 <20140730060619.GC19933@codeaurora.org>
 <CAJAp7OhoRQ1eWack1e=OL0cS4Fxmgxc7OWeNxcj1qt7Q-x-sQA@mail.gmail.com>
Message-ID: <53FEE125.2080600@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 09:24 PM, Bjorn Andersson wrote:
> On Tue, Jul 29, 2014 at 11:06 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 07/29, Rob Herring wrote:
> [..]
>>>
>>> You might as well do of_property_read_u32 in the below example.
>>>
>>
>> Fair enough. The example is probably too simple. Things are
>> sometimes slightly more complicated and a simple
>> of_property_read_u32() isn't going to work in the case of
>> multiple reg values or when reg-names is in play.
>>
> 
> But do we have such cases in the Qualcomm PMICs?

yes, we have few - rtc, iadc and partially regulators.

> 
> The only case I've hit so far is for gpios and mpps, where it feels
> like reg should be base, size and not simply base reg of first gpio -
> but that's a different thing.
> 
> Also, so far it seems like most drivers just code the base address in
> the driver, as we have very specific compatibles.
> 
> 
> How about we stop trying so hard to make this "perfect" and just merge
> something close to Josh's original proposal and ignore this problem?
> Currently all we're doing is delaying any possibility of getting
> drivers for the individual blocks merged.
> If we have the dt bindings require the reg to be there, we can discuss
> and change this all we want later!

I totally agree with you, the latest PMIC version of the patches sent
two weeks ago follow this assumption but I didn't receive any
ack/reviewed-by from anyone and we miss the merge window. :(


-- 
regards,
Stan
