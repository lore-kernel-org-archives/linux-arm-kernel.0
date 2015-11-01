From: robh@kernel.org (Rob Herring)
Date: Sun, 1 Nov 2015 08:28:59 -0600
Subject: [PATCH 09/19] drm: sun4i: Add DT bindings documentation
In-Reply-To: <20151030173738.GD17183@ulmo.nvidia.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAL_JsqLuUUApGAgdw7U8EJ7p5yrYJg8AKFB32AE9Ufrf47=WpQ@mail.gmail.com>
 <20151030173738.GD17183@ulmo.nvidia.com>
Message-ID: <CAL_Jsq+viBYCzw_YvVu0zVbPFb8r42+ma-wBcw1bbyOKUTaEYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 12:37 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Fri, Oct 30, 2015 at 11:40:03AM -0500, Rob Herring wrote:
>> On Fri, Oct 30, 2015 at 9:20 AM, Maxime Ripard
> [...]
>> > +Optional properties:
>> > +  - allwinner,tv-encoder: phandle to the TV Encoder in our pipeline
>> > +  - allwinner,panel: phandle to the panel used in our RGB interface
>>
>> Use of-graph please.
>
> Why? Panels are a really simple resource and a simple phandle is fully
> capable of describing the relationship.

So we can have some consistency in bindings and common parsing code.
It is simple when it is just a panel, but when it can be tv-encoder or
other board level downstream bridge devices it doesn't stay so simple.
Also, we already have a simple way to do panels which is as a child
node. Let's not have a third way.

Rob
