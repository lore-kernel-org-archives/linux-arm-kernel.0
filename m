From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 16:00:07 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150902225008.GQ21084@n2100.arm.linux.org.uk>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=U2BR=Qk2cVS-cq78Rx=VjriZiE6nC3cn+_SBHx2_5ihg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, Sep 2, 2015 at 3:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> I think you may want to add "adap->dev.of_node = hdmi->dev->of_node;"
>> here.  That will allow device trees to specify the i2c bus by using an
>> alias.
>
> Never copy the of_node from one device to another.  That allows the
> bus matching to unintentionally match the of_node against the wrong
> driver.

So does that mean we need to create a sub-node for the i2c bus if we
want something like this?


> Also, is it appropriate to hook non-DDC devices to a DDC bus?  I suspect
> that's asking for trouble.

I doubt it's appropriate.  Why do you ask?

-Doug
