From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 2 Mar 2018 13:13:20 +0000
Subject: [PATCH v3 01/25] dt-bindings: soc: qcom: Add bindings for APR bus
In-Reply-To: <20180301203413.GN12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
 <20180301203413.GN12864@sirena.org.uk>
Message-ID: <2608d36a-cf4e-5b06-a26a-8d4ee0bb41ad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review,

On 01/03/18 20:34, Mark Brown wrote:
> On Thu, Feb 22, 2018 at 10:03:42AM +0000, Srinivas Kandagatla wrote:
>> On 22/02/18 00:14, Rob Herring wrote:
> 
>>> Am I saying a single DT node for this? Yes, perhaps.
>> Yes, I will give that a go.
>>
>> So we will endup having something like this in DT for one frontend and
>> backend dailink:
> 
> Let's not start encoding DPCM into DT, DPCM is very much an
> implemntation detail of the current stack which we're gradually pushing
> towards replacing with something better.  What we want to be doing is
> just treating components inside the SoC the same as components in a
> CODEC, the routing within a SoC being the same as in a CODEC and
> similarly for externally connected devices.
> 
>> 		fe at 1 {
>>                  	is-fe;
>>                          link-name = "MultiMedia1";
> 
> In particular having the concept of "front end" in the DT is *very*
> implementation specific.  We should just be describing the connections
> that exist in the system.
Yep, it makes sense. is-fe flag will be removed in next version, we can 
determine this based on codec dai, so from DT side FE or BE should not 
be any different.

Thanks,
srini

> 
