From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 16 Jun 2014 14:30:48 -0700
Subject: [PATCH 1/2] touchscreen: sun4i-ts: A10 (sun4i) has double the
 temperature precision
In-Reply-To: <1402943069-19420-2-git-send-email-hdegoede@redhat.com>
References: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
 <1402943069-19420-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140616213048.GA422@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Mon, Jun 16, 2014 at 08:24:28PM +0200, Hans de Goede wrote:
> Testing has revealed that the temperature in the rtp controller of the A10
> (sun4i) SoC has a resolution of 50 milli degrees / step, where as the
> A13 (sun5i) and later models have 100 milli degrees / step.
> 
> Add a new sun5i-a13-ts compatible to differentiate the newer models and
> set the resolution based on the compatible string.
> 
> This fixes the temperature reported on the A10 being twice as high as expected.

Should we maybe add explicit temperature steps property so that we won;t
need to patch again if they decided to change resolution again?

Thanks.

-- 
Dmitry
