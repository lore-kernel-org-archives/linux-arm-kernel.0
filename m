From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 16 Oct 2015 11:42:54 +0530
Subject: [PATCH v4 2/4] mailbox: Hi6220: add mailbox driver
In-Reply-To: <20151016060809.GC3226@leoy-linaro>
References: <1444667535-16948-1-git-send-email-leo.yan@linaro.org>
 <1444667535-16948-3-git-send-email-leo.yan@linaro.org>
 <CABb+yY2uJZFgDeviRzz8ghVhNzy5d6jf+=fpTAUez01m+O0ttw@mail.gmail.com>
 <20151016052910.GB3226@leoy-linaro>
 <CABb+yY1ArXRz+jznuPj-BOQR18EijTD=czkHJ2BMSh5mNFikow@mail.gmail.com>
 <20151016060809.GC3226@leoy-linaro>
Message-ID: <CAJe_ZhejrJZZA=zVJvfrtmj7oBfTCd1NddoEmrJG1SEo5TvbNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2015 at 11:38, Leo Yan <leo.yan@linaro.org> wrote:
> On Fri, Oct 16, 2015 at 11:17:32AM +0530, Jassi Brar wrote:
>> On Fri, Oct 16, 2015 at 10:59 AM, Leo Yan <leo.yan@linaro.org> wrote:
>> > On Fri, Oct 16, 2015 at 10:43:00AM +0530, Jassi Brar wrote:
>> >> On Mon, Oct 12, 2015 at 10:02 PM, Leo Yan <leo.yan@linaro.org> wrote:
>> >>
>> >> > +
>> >> > +#define MBOX_CHAN_MAX                  32
>> >> > +#define MBOX_CHAN_NUM                  2
>> >> > +
>> >> You mean the hardware has 32 channels but this driver can not manage
>> >> more than 2 ?
>> >>
>> >> OR, there are 32 interfaces but only 2 physical 'floating' links, so
>> >> no more than 2 interfaces can be active at any time?
>> >
>> > For the later case.
>> Former is a s/w limitation and latter is h/w limitation. From what you
>> write below, it seems former to be the case.
>
> Sorry, i misunderstood the question. It's a s/w limitation.
>
>> > Mailbox also can be used by other modules, such
>> > like audio hifi; later need add links for them if want to enable
>> > audio. But so far only uses first 2 channels.
>> >
>> You mean every time your platform needs another channel, you'll update
>> the driver? Not sure about that. It should be simpler to assign which
>> ever and as many channels as the client asks via DT.
>
> For hi6220, every channel is fixed to specific purpose;
on different platform the purposes may be different, so ....

> so i can
> register all of them in driver, such like hifi related channels;
> Though i cannot test them currently, but this will avoid extra
> efforts for enabling channels anymore, do you think this is okay?
> Or you prefer to bind with DT?
>
.... DT please.
