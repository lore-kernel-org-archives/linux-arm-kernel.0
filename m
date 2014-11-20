From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Thu, 20 Nov 2014 13:48:27 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141120121202.GA27527@amd>
References: <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
 <546AFEA5.9020000@samsung.com> <20141118084603.GC4059@amd>
 <546B19C8.2090008@samsung.com> <20141118113256.GA10022@amd>
 <546B40FA.2070409@samsung.com> <20141118132159.GA21089@amd>
 <546B6D86.8090701@samsung.com> <20141118165148.GA11711@amd>
 <546C66A5.6060201@samsung.com> <20141120121202.GA27527@amd>
Message-ID: <546DE31B.20602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 11/20/2014 01:12 PM, Pavel Machek wrote:
> Hi!
>
>> I would also swap the segments of a property name to follow the convention
>> as in case of "regulator-max-microamp".
>>
>> Updated version:
>>
>> ==========================================================
>>
>> Optional properties for child nodes:
>> - max-microamp : maximum intensity in microamperes of the LED
>> 		 (torch LED for flash devices)
>> - flash-max-microamp : maximum intensity in microamperes of the
>> 		       flash LED; it is mandatory if the led should
>> 		       support the flash mode
>> - flash-timeout-microsec : timeout in microseconds after which the flash
>> 		           led is turned off
>
> Works for me. Do you want to submit a patch or should I do it?

You can submit a patch for leds/common.txt and a separate patch for the
adp1653 with a reference to the leds/common.txt for the child nodes.

>
>> - indicator-pattern : identifier of the blinking pattern for the
>> 		      indicator led
>>
>
> This would need a bit more documentation, no?

- indicator-pattern : identifier of the blinking pattern for the
  		      indicator led; valid identifiers should be
		      defined in the documentation of the parent
		      node.

I wouldn't go for pre-defined identifiers as the pattern
can be a combination of various settings like ramp-up, ramp-down,
pulse time etc. Drivers should expose only few combinations of
these settings in my opinion, like e.g. leds-lm355x.c does.

Regards,
Jacek
