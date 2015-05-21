From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 May 2015 20:45:25 +0200
Subject: [PATCH 2/3] ARM: dts: sun7i: Add uart2 support for BananaPi
In-Reply-To: <1432211555-25078-2-git-send-email-hdegoede@redhat.com>
References: <1432211555-25078-1-git-send-email-hdegoede@redhat.com>
 <1432211555-25078-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150521184525.GC8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 02:32:34PM +0200, Hans de Goede wrote:
> From: Michael Ring <mail@michael-ring.org>
> 
> Uart2 is available at the bananapi io-pins, add a dts node for this
> (so that people can easily enable it) but leave it disabled as the pins
> are primarily intended for gpio as documented here:
> http://wiki.lemaker.org/Pin_definition

So far the policy we had on this is only to add to the DT the primary
purpose of these pins.

Even though that might seem arbitrary, it's the only way to prevent
anyone adding their own configuration for those pins, which would be a
mess to maintain and use. It's even more true since that sort of thing
is exactly where the overlays shine.

So, I'm ok with adding the uart4, but the uart2 should go.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/9e4a888d/attachment.sig>
