From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 5 Sep 2017 22:31:46 +0100
Subject: [PATCH v2 00/29] implement KASLR for ARM
In-Reply-To: <20170905212742.GG5024@atomide.com>
References: <20170903120757.14968-1-ard.biesheuvel@linaro.org>
 <20170905164547.GA5024@atomide.com>
 <CAKv+Gu_eT_eK9Tj4JvWSsK+iW9juGG6xYDO15umu6jBkoun8ew@mail.gmail.com>
 <20170905193754.GD5024@atomide.com>
 <CAKv+Gu9c_j0qriRazSTmq8eD9icCu4Wuzw1z-LF7bubLVLQd7Q@mail.gmail.com>
 <20170905212742.GG5024@atomide.com>
Message-ID: <CAKv+Gu8uZH5PFVBwEGAK1hjGMTJD1a1KN0dVUjw=M3GPsps1FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2017 at 22:27, Tony Lindgren <tony@atomide.com> wrote:
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> [170905 12:43]:
>> Right. Well, I will try to reproduce with the BB white I have.
>
> Yeah that should be reproducable, I got it to happen on BBB here
> after about 5 boots.
>
>> Are you booting with an initrd?
>
> Not on this one, on beagleboard xm I do.
>

Interesting.

>> >> > Then loading modules with CONFIG_RANDOMIZE_BASE=y seems to fail with:
>> >> >
>> >> > $ sudo modprobe rtc-twl
>> >> > rtc_twl: disagrees about version of symbol module_layout
>> >> > modprobe: ERROR: could not insert 'rtc_twl': Exec format error
>> >> >
>> >>
>> >> Is this with CONFIG_MODVERSIONS enabled?
>> >
>> > Yes, but disabling that did not seem to make any difference
>> > based on just one test.
>> >
>>
>> Yeah, well, it appears I missed a couple of details :-)
>>
>> This should fix the module loading issues:
>
> Yeah now modprobe works :) That's after manually applying
> it as the tabs got munched in your patch somewhere, see below.
>

Yeah, Gmail tends to do that now and again. Apologies.

Thanks for confirming that the module loading works for you, I will
fold this into my v3.
