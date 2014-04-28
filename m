From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 16:11:08 -0700
Subject: [PATCH 2/5] power: reset: Add Allwinner A31 reset code
In-Reply-To: <535BD18B.2070902@roeck-us.net>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-3-git-send-email-maxime.ripard@free-electrons.com>
 <535BD18B.2070902@roeck-us.net>
Message-ID: <20140428231108.GO3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 26, 2014 at 08:32:27AM -0700, Guenter Roeck wrote:
> On 04/23/2014 08:04 AM, Maxime Ripard wrote:
> >That code used to be in the machine code, but it's more fit here with other
> >restart hooks.
> >
> >That will allow to cleanup the machine directory, while waiting for a proper
> >watchdog driver for the A31.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I am a bit lost here. Why is this a separate driver, accessing watchdog registers,
> while the other reset functions are being moved into the watchdog code ?
> 
> Any chance to handle all platforms the same ? Seems to me that would be less messy.

The A31 watchdog is actually a different watchdog from the one in the
other Allwinner SoCs, that probably needs a driver of its own, or at
least, a significant refactoring.

No one did this yet, but eventually this will probably happen.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/155f63fb/attachment.sig>
