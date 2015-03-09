From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 15:35:42 +0100
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <CAL_JsqLjooPxPdG2+fqSJToyWCtZHB=FvkqCUt+WgHExNo7D=A@mail.gmail.com>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqLjooPxPdG2+fqSJToyWCtZHB=FvkqCUt+WgHExNo7D=A@mail.gmail.com>
Message-ID: <CACRpkdZgiSWezNtPgDsiNw84Q_4KLxet-DhbmZ6-gu=_3DfNpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 6:47 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Mar 3, 2015 at 3:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> +Optional properties:
>> +
>> +- compatible : "simple-mfd" - this signifies that the operating system should
>> +  spawn child devices for all the subnodes of the MFD device akin to how
>> +  "simple-bus" inidicates when to spawn children for a simple memory-mapped
>> +  bus. For more complex devices, when the nexus driver has to probe registers
>> +  to figure out what children exist etc, this should not be used. In the latter
>> +  case the child devices will be instantiated by the operating system.
>
> If you point of_platform_populate to the parent node, it should
> instantiate all children regardless of "simple-bus" or any other
> match. The match is to probe the grandchildren.

Yep, if children are only children of the top node, yes.

> I could be mistaken,
> but that's how it works at the root level.

Yes but only at the root level.

> You don't have a driver
> probe for the parent, so you want the top level of_platform_populate
> call to instantiate these devices?

of_platform_populate() only populates one level unless the node has
something like "simple-bus" or this new "simple-mfd" compatible on
it.

> Why does simple-bus not work for you? After all, it is not
> "simple-memory-map-bus."

As Lee says it works (obviously since I'm just adding a oneliner
doing exactly the same thing as "simple-bus"), but the
terminology is just wrong. It's not a bus in any hardware sense,
as MFD is a logical subdevice split, nothing else.

Yours,
Linus Walleij
