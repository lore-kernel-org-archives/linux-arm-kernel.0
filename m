From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 18 Jun 2014 12:01:45 -0700
Subject: [PATCH] ARM: zImage: ensure header in LE format for BE8 kernels
In-Reply-To: <53A1D8FE.6030404@codeaurora.org>
References: <1397147232-28516-1-git-send-email-taras.kondratiuk@linaro.org>
 <CAGa+x85P-M3qUD6L=kezkiQ1NJymEZ9P=u2ANUZJu2b3F+o5LA@mail.gmail.com>
 <53A1D701.8060404@codeaurora.org>
 <CAGa+x86DfDjQG8gN2-x7Kapt2ipsYt879R4OK6JWGoaT93VVig@mail.gmail.com>
 <53A1D8FE.6030404@codeaurora.org>
Message-ID: <CAGa+x87rnQntQpTkR6dZr29NvEQ4x8SOAyo+z9xuYHEdxdG1xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 11:22 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/18/14 11:21, Kevin Hilman wrote:
>> On Wed, Jun 18, 2014 at 11:14 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> On 06/18/14 10:55, Kevin Hilman wrote:
>>>> All of that to say, with this patch applied, I need a new (and
>>>> reliable) way to determine the endianness of a kernel just by looking
>>>> at the zImage.  Recommendations welcome.
>>> Assuming that you have the .config configured to be built into the
>>> kernel you could use extract-ikconfig
>>>
>>> $ ./scripts/extract-ikconfig zImage | grep CONFIG_CPU_ENDIAN_BE8
>> Unfortunately, I can't rely on having that built in since I want the
>> boot tools to be as generic as possible.
>>
>>
>
> Yeah ok. Perhaps you can look for the 'setend be' instruction right
> after the magic values instead.

Yeah, that works, as long as I can always assume that instruction will
be at the same offset (currently at 0x30).

Kevin
