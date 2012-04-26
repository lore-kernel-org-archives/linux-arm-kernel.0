From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 08:39:36 -0600
Subject: [PATCHv4 1/2] drivers: input: keypad: Add device tree support
In-Reply-To: <CAKdam56ONhS_drgfHCeY6aKWp3nT0PtDEO5SMCKxG+dGVPS66A@mail.gmail.com>
References: <1335346004-18108-1-git-send-email-sourav.poddar@ti.com>	<4F981CD1.2050007@wwwdotorg.org>
 <CAKdam56ONhS_drgfHCeY6aKWp3nT0PtDEO5SMCKxG+dGVPS66A@mail.gmail.com>
Message-ID: <4F995E28.1050203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2012 12:33 AM, Poddar, Sourav wrote:
> On Wed, Apr 25, 2012 at 9:18 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
...
>> It's probably worth considering whether num-rows/columns should be part
>> of matrix-keyboard.txt, and whether linux,keypad-no-autorepeat should be
>> part of some core keyboard binding. Some of the properties in
>> tegra-kbc.txt might be worth generalizing too (debounce/repeat delay,
>> ghost filter)?
>
> Yes, I also think that its a good idea to make some of the above
> binding more generic. Though, I think "linux,keypad-no-autorepeat"
> will still be a custom binding, since its totally on the platform
> whether to use
> autorepeat feature or not?

I think the concept of whether autorepeat should be enabled is pretty
generic. The actual value of the property might well be
board/platform-specific, so may differ in individual board .dts files.
