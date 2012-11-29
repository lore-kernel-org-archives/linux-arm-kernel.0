From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 29 Nov 2012 14:54:02 +0200
Subject: [PATCH 4/9] usb: chipidea: ci13xxx-imx: add "dr_mode" property to
 device tree bindings
In-Reply-To: <20121126094626.GB15740@nchen-desktop>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-5-git-send-email-m.grzeschik@pengutronix.de>
 <878va17oii.fsf@ashishki-desk.ger.corp.intel.com>
 <20121126094626.GB15740@nchen-desktop>
Message-ID: <87pq2wmuxh.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Fri, Nov 16, 2012 at 01:53:09PM +0200, Alexander Shishkin wrote:
>> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
>> I'd prefer this function to live in ci13xxx_imx, since that's where it's
>> used and it doesn't really need anything from core.c anyway. Or maybe it
>> would make sense to make it even more generic (for other devitetree
>> users), since you're saying that other drivers are using this already.
>> 
>> Looks good to me otherwise.
>
> I think it supplies a way that the platform can override the usb role,
> only freescale uses it, but also other platforms may use it. It is a
> generic feature, other chipidea users may need it.

I'm not objecting against the flags, I just don't like the function in
chipidea core. Platform code can just use the flags. It can be either
part of the platform driver or a generic dt helper, in case there are
more users, it doesn't belong to chipidea core.

Regards,
--
Alex
