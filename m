From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Sep 2017 10:14:42 +0200
Subject: [PATCH v2] drm/tve200: Replace custom connector with panel bridge
In-Reply-To: <20170904075255.oy5gc5ggxpjhbisk@phenom.ffwll.local>
References: <20170902200711.29298-1-linus.walleij@linaro.org>
 <20170904075255.oy5gc5ggxpjhbisk@phenom.ffwll.local>
Message-ID: <CACRpkdb-v71qOWLdU=64D8Y7yhAF2i6XnWCAwD3x5BYcfORAtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 4, 2017 at 9:52 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sat, Sep 02, 2017 at 10:07:11PM +0200, Linus Walleij wrote:
>> This replaces the custom connector in the TVE200 with the
>> panel bridge helper. As long as we're just using panels
>> and no other bridges, this works just fine.
>>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Drop a few surplus #includes
>> - Collect Eric's review tag

>> +     /* We need the encoder to attach the bridge */
>> +     priv->encoder = &priv->pipe.encoder;
>
> drm_simple_display_pipe_attach_bridge(). Fairly new addition, would be
> great if you can also fix up wherever you copy-pasted this from :-)

The horrible truth is that I did not copy-paste it, I came up with
this for PL111 but using a v4.13 tree and then forward-patching
on top of drm-next.

> I didn't check all the details, but lgtm otherwise. With this nit
> addressed:
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Gnah I already pushed it after Eric's review, but I can make
a follow-up patch, I will also try to get it right in PL111.

Yours,
Linus Walleij
