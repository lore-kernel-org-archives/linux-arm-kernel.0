From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 15 Jan 2015 11:04:04 +0100
Subject: [RFC 0/3] mmc: Add dynamic frequency scaling
In-Reply-To: <1421313626.19448.8.camel@AMDC1943>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFpGiaDJ3zjCSSbcia6iLS2+FLBRjGAheQAzvFsAkJax+A@mail.gmail.com>
 <1421313626.19448.8.camel@AMDC1943>
Message-ID: <CAPDyKFqe7UxSrQxuvGw7UWFQhvX0NZ83rvLrAEMZFpA4n0GcNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 10:20, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On czw, 2015-01-15 at 09:20 +0100, Ulf Hansson wrote:
>> + Mike, Stephen (Clock maintainers)
>>
>> On 12 January 2015 at 10:23, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>> > Hi,
>> >
>> >
>> > I would like to hear some comments about idea of scaling MMC clock
>> > frequency. The basic idea is to lower the clock when device is
>> > completely idle or not busy enough.
>>
>> We already have host drivers that implements runtime PM support.
>> Typically that would mean the clock will be gated once the device
>> becomes runtime PM suspended.
>>
>> Why should we decrease the frequency of an already gated clock?
>
> In case of idle state you're right that clkgate would be better. But
> what about finding a compromise between high performance (high
> frequency) and energy saving for different loads on MMC?

I guess a compromise could be beneficial for some SOC and use cases.
At least I remember, ST-Ericsson's UX500 SOC had such an out of tree
hack to track MMC load.

>
> The frequency scaling could help in that case. Anyway I should prepare
> some more benchmarks for such conditions.

Seems reasonable and please do!

Kind regards
Uffe
