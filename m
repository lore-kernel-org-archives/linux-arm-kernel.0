From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Oct 2016 17:00:02 +0100
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <20161019155658.GB4411@x4>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
Message-ID: <CAKv+Gu_s_GeZJzDvu9Tn8y0k_b1Eyet2F7fZZ4e3wHTohtxstg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2016 at 16:56, Markus Trippelsdorf <markus@trippelsdorf.de> wrote:
> On 2016.10.19 at 08:55 -0700, Linus Torvalds wrote:
>> On Wed, Oct 19, 2016 at 8:37 AM, Markus Trippelsdorf
>> <markus@trippelsdorf.de> wrote:
>> >
>> > This is a gcc bug, see:
>> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=72785
>>
>> Well, in the meantime we apparently have to live with it. Unless Will
>> is using some unreleased gcc version that nobody else is using and we
>> can just ignore it?
>
> Yes, he is using gcc-7 that is unreleased. (It will be released April
> next year.)
>

order_base_2() is still broken though, given that it is documented as

 * The first few values calculated by this routine:
 *  ob2(0) = 0
 *  ob2(1) = 0
 *  ob2(2) = 1
 *  ob2(3) = 2
 *  ob2(4) = 2
 *  ob2(5) = 3

whereas order_base_2(0) actually ends up invoking
roundup_pow_of_two(0), which is documented as being undefined.
