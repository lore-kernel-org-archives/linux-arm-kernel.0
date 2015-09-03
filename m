From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 17:22:59 -0700
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
Message-ID: <CAD=FV=WPWXAJRb0v4Kz2pCey042AaKPF-Xeaz=hU7PWGYK953g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wed, Sep 2, 2015 at 5:13 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Sep 2, 2015 at 4:25 PM, Douglas Anderson <dianders@chromium.org> wrote:
>> The ddc-i2c-bus property was missing from the veyron dtsi file since
>> downstream the ddc-i2c-bus was still being specified in rk3288.dtsi and
>> nobody noticed when the veyron dtsi was sent upstream.  Add it.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> Note: I noticed that this was wrong but I don't currently have
>> graphics up and running on upstream on veyron.  Posting this anyway
>> since it's pretty clear that it's needed.  If someone else wants to
>> try it out that'd be nice, otherwise I'll put it on my list to figure
>> out how to get myself setup for graphics upstream.  ;)
>
> Based on your other patch, this is temporary, right?

Yes, though since I'm not personally working on the other patch series
upstream I can't say for how long the "temporary" is..  I mostly
posted the 2nd patch because it was clearly correct to add some
pinmuxing states and could land any time, so I thought I'd be helpful.

You're right that in the Chrome OS tree I turned right around and
effectively removed the "ddc-i2c-bus", but having it land first adds a
much better logical progression (make it the same as everyone else and
_then_ change it).  It also provides a revert path if something goes
wrong.  :)


> I've been looking at DRM a lot lately. I think specifying the i2c bus
> in the hdmi chip or IP block node is wrong. If the I2C host is
> separate from the HDMI block, then it's only connection is to the HDMI
> connector. So the I2C host to the connector relationship is what the
> DT should describe. HPD gpio is similar. Now if the HDMI bridge
> controls DDC and HPD directly, then we don't need to describe those
> connections.

I will say that I know very very little about DRM.  Mostly I just
visit it when there's some bug I'm running into that I can't find a
better suited owner for.  ;)

I'm not sure I followed your whole paragraph.  Could you give a
fragment of DTS for how you'd imagine this ought to work?  Also: the
patch I submitted does match the current bindings if I understand it
right.  ...as is typical with device tree, if we want to change the
bindings we've got to have a really good reason because we'd either
need to figure out how to deal with existing DTBs in the field that
need to run with newer kernels (if those exist).

-Doug
