From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 7 Sep 2017 20:44:16 +0200
Subject: [PATCH 2/2] RFC: drm/pl111: Support using the VGA bridge as
 fallback
In-Reply-To: <d9adcbb3-782b-3ae8-746a-ffb3b1b031af@tronnes.org>
References: <20170901094629.6566-1-linus.walleij@linaro.org>
 <20170904074355.gjbf7he2dt5kszfg@phenom.ffwll.local>
 <CACRpkdZrwZ980YhKGQSpLxoYaFtHvQBUPTXzXqLCbn+4+zvs9g@mail.gmail.com>
 <d9adcbb3-782b-3ae8-746a-ffb3b1b031af@tronnes.org>
Message-ID: <CAKMK7uG6k2MuK-hemY52tcArGo3rLLQ8e_LabyDapvkHCS=rOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 7, 2017 at 6:12 PM, Noralf Tr?nnes <noralf@tronnes.org> wrote:
>
> Den 07.09.2017 14.59, skrev Linus Walleij:
>>
>> On Mon, Sep 4, 2017 at 9:43 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>
>>> On Fri, Sep 01, 2017 at 11:46:29AM +0200, Linus Walleij wrote:
>>>>
>>>> If we cannot find a panel, assume that the output from the
>>>> PL111 is connected directly to a "dumb" VGA connector,
>>>> so look up the connector from that bridge.
>>>>
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>>        if (panel) {
>>>>                priv->panel = panel;
>>>>                priv->connector = panel->connector;
>>>> +     } else {
>>>> +             priv->connector = drm_dumb_vga_get_connector(bridge);
>>>
>>> Why do you need to set this?
>>
>> Essentially because drm_simple_display_pipe_init() require that you
>> specify a connector in the last argument, so I have to get it from
>> somewhere.
>
>
> It's optional particularly for the bridge case. From docs:
>
>  * If a connector is supplied, the pipe will be coupled with the provided
>  * connector. You may supply a NULL connector when using drm bridges, that
>  * handle connectors themselves (see
> drm_simple_display_pipe_attach_bridge()).

Yup, this was the flip side of the work to make bridges useful for the
simple pipe helpers. The other one is the helper to set up the bridge
I mentioned earlier in this thread.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
