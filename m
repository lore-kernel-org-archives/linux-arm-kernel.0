From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Jun 2014 14:33:38 -0600
Subject: [PATCH 3/3] arm: tegra: initial support for apalis t30
In-Reply-To: <538CDC08.7020106@ziswiler.com>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <b470c9c8631a6ef021d140192eb07006de3cfd93.1401665237.git.marcel@ziswiler.com>
 <538CA5C3.5050709@wwwdotorg.org> <538CDC08.7020106@ziswiler.com>
Message-ID: <538CDFA2.5020704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 02:18 PM, Marcel Ziswiler wrote:
> On 06/02/2014 06:26 PM, Stephen Warren wrote:

>>> +    pwmleds {
>>> +        compatible = "pwm-leds";
>>> +
>>> +        pwm3 {
>>> +            label = "PWM3";
>>> +            pwms = <&pwm 1 19600>;
>>> +            max-brightness = <255>;
>>> +        };
>>> +        pwm2 {
>>> +            label = "PWM2";
>>> +            pwms = <&pwm 2 19600>;
>>> +            max-brightness = <255>;
>>> +        };
>>> +        pwm1 {
>>> +            label = "PWM1";
>>> +            pwms = <&pwm 3 19600>;
>>> +            max-brightness = <255>;
>>> +        };
>>
>> Nit: Why not sort those nodes in numerical order?
> 
> Sure, the only question is ordering based on what. I choose the actual
> Tegra PWM instance while you propose to use our Apalis instance
> numbering which in this particular case turns out to be the opposite but
> makes us even more happy to comply.

Sorting by reg value, or if there is no reg value then alphanumerically,
is what I've tried to (remember to) require for the Tegra DTs.
