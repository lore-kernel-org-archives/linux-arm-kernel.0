From: john.stultz@linaro.org (John Stultz)
Date: Wed, 20 Jan 2016 12:25:44 -0800
Subject: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <CAL_Jsq+suCyqSi+cJiVLuA0aZKSciAaeUKW9A5Y_X_3wyW60Ug@mail.gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop>
 <CALAqxLVvJqL60nKfrDiZ+p-1ujxuG72iUN3DCvEE3WJ9bpnGLA@mail.gmail.com>
 <CAL_Jsq+suCyqSi+cJiVLuA0aZKSciAaeUKW9A5Y_X_3wyW60Ug@mail.gmail.com>
Message-ID: <CALAqxLVY7mg2arS7u63fRow8Ln2u7hbrfFf1h2UcoojtwJMRyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 11:53 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 20, 2016 at 12:47 PM, John Stultz <john.stultz@linaro.org> wrote:
> The question here really is will we ever need additional data for each
> mode (in the DT) besides "magic". We can do some amount of extending
> the property like allowing more that single 32-bit value. We can't mix
> strings and integers though. If we don't need that, then lets go with
> the more concise approach. This isn't really an evolving area.
> Selecting boot mode/device has existed for a long time on PCs (it is
> fixed list in the IPMI spec for example). So I can't imagine that we'd
> have to extend this, but I'd like to hear thoughts on it. You had
> mentioned the Galaxy Nexus having a value and a string, but I'd find
> it surprising if the bootloader actually uses the string.

So I've been told the galaxy nexus and possibly other older TI
hardware used only a string.

And the HTC implementations I've seen have code for both a string and
command to be placed, but usually don't actually copy anything to the
string address (which suggest its not used by the bootloader, as you
note).

Either way, we'd have to extend or implement a new driver, but that's
a bridge I think we can cross later when we see such hardware support
upstream (rather then try to create a super driver that handles
everything a creative firmware developer could come up with).

thanks
-john
