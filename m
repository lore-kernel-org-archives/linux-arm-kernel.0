From: carlo@endlessm.com (Carlo Caione)
Date: Tue, 15 Mar 2016 10:20:33 +0100
Subject: [PATCH v2 4/4] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <CACRpkda3j7oxL0wawkLy-eHnP6zmfmBgKbm7=gTDH1xqXhKKUQ@mail.gmail.com>
References: <20160305042646.GL13525@rob-hp-laptop>
 <1457516519-15319-1-git-send-email-carlo@caione.org>
 <CACRpkda3j7oxL0wawkLy-eHnP6zmfmBgKbm7=gTDH1xqXhKKUQ@mail.gmail.com>
Message-ID: <CAL9uMOFwgMX24vg_u23nfOg+q+J7+SK+vysSGFPn_pfNq49Rsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 10:10 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Mar 9, 2016 at 10:41 AM, Carlo Caione <carlo@caione.org> wrote:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Fix pin controller documentation introducing the new compatibles for
>> the pinctrl drivers specific for aobus / cbus.
>>
>> This is needed because we have changed the pin controller driver: we
>> have now a single specialized pinctrl driver / compatible for each bus
>> the controller is attached to, instead of one single driver dealing with
>> all the controllers we have on different buses.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
>> Hey Rob,
>> I'm resubmitting a V2 only for this patch since the driver changes have
>> been already taken by Linus.
> (...)
>>  Required properties for the root node:
>> - - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
>> + - compatible: one of "amlogic,meson8-cbus-pinctrl"
>> +                     "amlogic,meson8b-cbus-pinctrl"
>> +                     "amlogic,meson8-aobus-pinctrl"
>> +                     "amlogic,meson8b-aobus-pinctrl"
>
> I guess I just have to merge this. It (IIUC) turns out that the driver is beta
> and prototypeish and the DT bindings were too early to be etched in stone,
> and any old device trees using it are not really working anyways.

They are working but the platform support is so primitive (still
trying to upstream the MMC driver) that really I wouldn't be too
concerned of breaking the DT bindings at this stage of the
development.
On the bright side we learned a lot from the Meson8b architecture so
for mesongxbb things should be smoother.

> We prefer that this not happen because we have a serious control issue
> when it comes to bindings, but sometimes it happens anyways. Like
> with divorces and other unfortunate stuff like that.

I know and agree with this, hopefully this will be a one time issue.

Thanks, I'll pick the DTS changes as soon as Rob ACKs this.

-- 
Carlo Caione
