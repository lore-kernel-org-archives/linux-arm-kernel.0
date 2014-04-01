From: rabin@rab.in (Rabin Vincent)
Date: Wed, 2 Apr 2014 01:21:01 +0200
Subject: [PATCH] arm: don't allow CONFIG_DEBUG_SET_MODULE_RONX if
 CONFIG_JUMP_LABEL is enabled
In-Reply-To: <CAGXu5jKMF9n9svQBhyQFvCoUe86QhLycDTt-fWyiRfySbn=Fug@mail.gmail.com>
References: <1396346657-7166-1-git-send-email-holler@ahsoftware.de>
 <533AFF77.5030106@codeaurora.org>
 <CAGXu5jKMF9n9svQBhyQFvCoUe86QhLycDTt-fWyiRfySbn=Fug@mail.gmail.com>
Message-ID: <CAH+eYFCwBepjaM+XfqqgVaHMp6N5+Yad3oaR0tezqSeW7ODuRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-01 20:36 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Tue, Apr 1, 2014 at 11:03 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> On 4/1/2014 3:04 AM, Alexander Holler wrote:
>>> CONFIG_DEBUG_SET_MODULE_RONX sounds like a nice security feature, but
>>> things might fail late (and unexpected) if module code is set to read-only
>>> while CONFIG_JUMP_LABEL is enabled (e.g. modprobe bridge).
>
> Isn't this a ordering problem? I thought jump labels got set up once,
> and then after that, the memory could be made RO?

The code gets patched every time the jump label is enabled/disabled,
i.e. every time the static_key is turned on/off based on
static_key_slow_{inc/dec}()
