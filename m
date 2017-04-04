From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 4 Apr 2017 08:39:28 +0100
Subject: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170404073504.GI16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
Message-ID: <CAKv+Gu-3MiGYS=Eh0zfMp41ah6B==HbLFVSh7+kHX_hfHTut-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2017 at 08:35, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> On Tue, Apr 04, 2017 at 06:14:55AM -0000, David Woodhouse wrote:
>>
>> > On Mon, Apr 03, 2017 at 09:18:12AM +0100, David Woodhouse wrote:
>> >>
>> >> You still have typos here.
>> >
>> > I'd like to defer to the maintainers whether we prefer MiB over MB.
>>
>> It is not really a matter of preference. One is correct; the other is not.
>>
>> While simple errors can of course be forgiven, I cannot understand why you
>> would deliberately repeat an error once it has been pointed out to you.
>
> Because I think that people sometimes use those two interchangeably.
> So I said I would defer to the maintainers.
>

I have to agree with Akashi-san here: while you are technically
correct, the reality is that the MiB is not as widely adopted as you
suggest, and there is no ambiguity whatsoever in this particular case
(i.e., when referring to blocks of RAM), so I feel it is somewhat
counterproductive to confuse reviewers by stating 'You still have
typos here.' without specifying that it is MiB vs MB that you are
actually referring to.

These patches are complex enough as they are, so could we *please*
focus on the things that matter?
