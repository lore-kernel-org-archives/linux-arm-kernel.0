From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 Aug 2012 09:39:02 -0600
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120815135947.GC2258@S2101-09.ap.freescale.net>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
Message-ID: <502BC296.8030108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2012 07:59 AM, Shawn Guo wrote:
> On Wed, Aug 15, 2012 at 05:25:40PM +0800, Dong Aisheng wrote:
>> On Wed, Aug 15, 2012 at 03:51:17PM +0800, Uwe Kleine-K?nig wrote:
>>> That is just
>>>
>>> 	#define MX35_PAD_COMPARE__SDMA_EXTDMA_2 11
>>>
>>> vs.
>>>
>>> 	#define MX35_PAD_COMPARE__SDMA_EXTDMA_2 0x32c, 0x008, 7, 0x0, 0
>>>
>>> isn't it? (Actually I'd not go for cpp as preprocessor, but that's a
>>> different story.)
>>>
>> Hmm, not sure if dt macro may support this kind of syntax but yes if it supports.
>> Grant,
>> Do you know if dt macro can support it?
>>
> I have the same doubt there.  Copied Stephen who might have a better
> insight on this.

You mean like C pre-processor on .dts files? There's currently no
support for anything like that at all, with either syntax above. I
honestly don't know if/when there will be.
