From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 8 Mar 2015 14:11:17 -0700
Subject: [PATCH 0/3] touchscreen: sun4i-ts: A10 (sun4i) has a different
 temperature curve
In-Reply-To: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
References: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150308211117.GA23193@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sun, Mar 08, 2015 at 09:53:39PM +0100, Hans de Goede wrote:
> Hi Dmitry, Maxime, et al.
> 
> Here is a patch-set for the sun4i-ts driver temperature sensor support,
> it consists of 2 fixes:
> 
> 1) Use a better temperature curve for A10 SoCs to avoid reporting a way to
> high temperature.
> 
> 2) Start with reporting an "estimated" temperature of 40 degrees rather then
> returning -EAGAIN until we get the first temperature ready interrupt to avoid
> the kernel tempzone core logging errors because of our -EAGAIN return.

No, I think we better teach thermal core not to complain about
-EAGAINs.

> 
> Dmitry can you please queue up the 2 sun4i-ts patches for 4.1, and Maxime,
> can you please queue up the matching dts change ?
> 
> Thanks & Regards,
> 
> Hans

-- 
Dmitry
