From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 28 Aug 2013 16:01:36 +0200
Subject: [PATCH] pinctrl: at91: add support for OUTPUT config
In-Reply-To: <CACRpkdZ+TRb9OFTMHFCW6FYP10hNJFbuods04XK8=zq4bC8cHg@mail.gmail.com>
References: <1377615082-16808-1-git-send-email-b.brezillon@overkiz.com>
 <CACRpkdbkp-aqYWO=jkBvCT0U3wbKJMBfk2N17cUZeM5rfZiU5Q@mail.gmail.com>
 <CACRpkdZ+TRb9OFTMHFCW6FYP10hNJFbuods04XK8=zq4bC8cHg@mail.gmail.com>
Message-ID: <521E02C0.9010003@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/2013 15:48, Linus Walleij wrote:
> On Wed, Aug 28, 2013 at 3:46 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Aug 27, 2013 at 4:51 PM, Boris BREZILLON
>> <b.brezillon@overkiz.com> wrote:
>>
>>> Add support for pin output control through the pinctrl config:
>>>   - support enabling/disabling output on a given pin
>>>   - support output level setting (high or low)
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> NAK.
>>
>> We already have this:
>>
>>   * @PIN_CONFIG_OUTPUT: this will configure the pin in output, use argument
>>   *      1 to indicate high level, argument 0 to indicate low level.
>>
>> It also has device tree bindings:
>>
>> output-low              - set the pin to output mode with low level
>> output-high             - set the pin to output mode with high level
> Bah maybe I'm misunderstanding :-(
>
> So this is not part of the generic pin config series, but something
> stand-alone to augment the existing driver to do this?

This is a proposal to add support for OUTPUT config using native at91 
pinconf binding (not generic pinconf binding).

I did this to get support for OUTPUT config quickly.

The generic pinconf binding is still in discussion, and will be added as 
soon as at91 maintainers and pinctrl
maintainers agree on how this should be done.

>
> So I just apply this patch right off then?

I don't know, I think we should wait for Jean-Christophe approval.

>
> Yours,
> Linus Walleij
