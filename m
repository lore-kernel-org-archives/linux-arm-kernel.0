From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 14:50:14 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: add GPIO nodes for the BG2Q
In-Reply-To: <20140415114848.GA2813@piout.net>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397549245-3338-3-git-send-email-antoine.tenart@free-electrons.com>
 <534CFA77.9030108@gmail.com> <20140415180058.2fefca78@xhacker>
 <534D0943.2050100@gmail.com> <20140415114848.GA2813@piout.net>
Message-ID: <534D2B06.6000408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 01:48 PM, Alexandre Belloni wrote:
> On 15/04/2014 at 12:26:11 +0200, Sebastian Hesselbarth wrote :
>> On 04/15/2014 12:00 PM, Jisheng Zhang wrote:
>>> On Tue, 15 Apr 2014 02:23:03 -0700
>>> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>>>> I am fine with using nr-gpios property now, but I guess BG2Q also
>>>> has that CONFIG[1,2] registers to actually read out the features
>>>> synthesized in? If I find some time, I'll prepare a patch for
>>>> dw-apb-gpio to exploit that (optional) information instead of
>>>> using nr-gpios.
>>>
>>> The problem is CONFIG1/2 registers don't exist on some versions.
>>> For example, the version used in BG2/BG2CD. So nr-gpio is necessary
>>> if we want to support these versions.
>>
>> Hmm, are you sure about BG2? I remember reading it and it contains
>> sane values. Anyway, a proper patch for dw-apb-gpio would include
>> checking for sane (e.g. non-zero) values. And nr-gpios will always
>> stay as fall-back just because e.g. sunxi does not have the CONFIG
>> registers.
>
> Shouldn't that be use nr-gpios and if not available, read the CONFIG
> registers? Else, what about bogus registers ?

Probably, it is a better idea to only look for CONFIG registers if
nr-gpios is not set. Anyway, I'll really have to find more time first ;)

Sebastian
