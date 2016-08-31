From: dianders@chromium.org (Doug Anderson)
Date: Wed, 31 Aug 2016 14:45:40 -0700
Subject: [RESEND PATCH 3/4] arm64: dts: rockchip: support gmac for rk3399
In-Reply-To: <2498365.kqzATN1cjf@diego>
References: <1472624028-7082-1-git-send-email-wxt@rock-chips.com>
 <1472624028-7082-4-git-send-email-wxt@rock-chips.com>
 <CAD=FV=XQX__rFqGLY2U5mPT8WR4P4aW5tbCqFmA+3rZunbzUZQ@mail.gmail.com>
 <2498365.kqzATN1cjf@diego>
Message-ID: <CAD=FV=UkK2QqbCJrg72nvYYfg8-z5p0ye3mkASnxLKQfSR+wTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 31, 2016 at 2:29 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> IMHO it would be nice if this were broken into two patches.
>>
>> 1. First patch would be the power domain patch and that could land any
>> time.  You wouldn't actually be able to use the gmac but at least
>> you'd be able to turn off its power.  This would be a handy patch to
>> be able to backport if you happened to not need Ethernet support but
>> wanted to save power.
>>
>> 2. Second patch would actually add the gmac.
>
> according to my talk with Caesar in the real v1, the gmac even with power-
> domains should work just nicely even without the dts patches, as the driver
> core takes care of powering up the pd before probe.
>
> But I may miss some peculiarity of the dwmac?

Nothing that I'm terribly aware of.  I was just being selfish because:

1. I'm on a board where I don't need Ethernet.

2. I'm running a semi old kernel (4.4)

3. I don't want to pick back the various fixes that might be needed to
make gmac work on rk3399 to that old kernel.

4. I want it very obvious that gmac isn't really supported on this old
kernel on rk3399 (and having stmmac not in the device tree would make
it very obvious)

5. I do want the power savings of turning the power domains off for the gmac.


If this patch is broken in two then I can pick back just the power
domain patch.  :-P



-Doug
